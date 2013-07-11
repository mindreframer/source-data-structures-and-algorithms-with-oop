#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BTree.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BTree
# A B-tree.
# @attr _parent The parent of this B-tree.
package Opus10::BTree;
use Carp;
use Opus10::Declarators;
use Opus10::MWayTree;
our @ISA = qw(Opus10::MWayTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an M-way search tree node with the given order m.
# @param self This B-tree.
# @param m An integer greater than 2.
sub initialize
{
    my ($self, $m) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($m);
    $self->declare qw(_parent);
}

destructor qw(DESTROY);

# @method attachSubtree
# Attaches the given tree
# as the specified subtree of this B-tree node.
# @param self This B-tree.
# @param i An index.
# @param t A B-tree node.
sub attachSubtree
{
    my ($self, $i, $t) = @_;
    ${$self->{_subtree}}[$i] = $t;
    $t->{_parent} = $self;
}

attr_accessor qw(_parent);
#}>a

# @method purge
# Purges this B-Tree.
# Note: Because of the circular references in a B-tree,
# all B-trees must be purged in order for the reference counting GC to work.
# @param self This B-tree.
sub purge
{
    my ($self) = @_;
    $self->{_parent} = undef;
    if (!$self->isEmpty())
    {
	for (my $i = 1; $i <= $self->{_count}; ++$i)
	{
	    ${$self->{_key}}[$i] = undef;
	}
	for (my $i = 0; $i <= $self->{_count}; ++$i)
	{
	    ${$self->{_subtree}}[$i]->purge();
	    ${$self->{_subtree}}[$i] = undef;
	}
	$self->{_count} = 0;
    }
}

#{
# @method insert
# Inserts the given object in this B-tree.
# @param self This B-tree.
# @param obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	if (!defined($self->{_parent}))
	{
	    $self->attachSubtree(0,
		Opus10::BTree->new($self->getM()));
	    ${$self->{_key}}[1] = $obj;
	    $self->attachSubtree(1,
		Opus10::BTree->new($self->getM()));
	    $self->{_count} = 1;
	}
	else
	{
	    $self->{_parent}->insertUp($obj,
		Opus10::BTree->new($self->getM()));
	}
    }
    else
    {
	my $index = $self->findIndex($obj);
	croak 'ArgumentError'
	    if ($index != 0 && ${$self->{_key}}[$index] == $obj);
	${$self->{_subtree}}[$index]->insert($obj);
    }
}
#}>b

#{
# @method insertUp
# Inserts the given (object, B-tree) pair into this B-tree.
# @param self This B-tree.
# @param obj An object.
# @param child A B-tree.
sub insertUp
{
    my ($self, $obj, $child) = @_;
    my $index = $self->findIndex($obj);
    if (!$self->isFull())
    {
	$self->insertPair($index + 1, $obj, $child);
	$self->{_count} += 1;
    }
    else
    {
	my ($extraKey, $extraTree) = 
	    $self->insertPair($index + 1, $obj, $child);
	if (!defined($self->{_parent}))
	{
	    my $left = Opus10::BTree->new($self->getM());
	    my $right = Opus10::BTree->new($self->getM());
	    $left->attachLeftHalfOf($self);
	    $right->attachRightHalfOf($self);
	    $right->insertUp($extraKey, $extraTree);
	    $self->attachSubtree(0, $left);
	    ${$self->{_key}}[1] =
		${$self->{_key}}[($self->getM() + 1) / 2];
	    $self->attachSubtree(1, $right);
	    $self->{_count} = 1;
	}
	else
	{
	    $self->{_count} = ($self->getM() + 1) / 2 - 1;
	    my $right = Opus10::BTree->new($self->getM());
	    $right->attachRightHalfOf($self);
	    $right->insertUp($extraKey, $extraTree);
	    $self->{_parent}->insertUp(${$self->{_key}}[
		($self->getM() + 1) / 2], $right);
	}
    }
}
#}>c

# @method insertPair
# Inserts the given object and subtree at the specified index
# in the key and subtree arrays of this B-tree node
# and returns any leftover key and subtree.
# @param index The position at which to insert the pair.
# @param obj An object.
# @param child A B-tree.
# @return The leftover key and subtree.
sub insertPair
{
    my ($self, $index, $obj, $child) = @_;
    if ($index == $self->getM())
    {
	return ($obj, $child);
    }
    my @result = (${$self->{_key}}[$self->getM() - 1],
		    ${$self->{_subtree}}[$self->getM() - 1]);
    my $i = $self->getM() - 1;
    while ($i > $index)
    {
	${$self->{_key}}[$i] = ${$self->{_key}}[$i - 1];
	${$self->{_subtree}}[$i] = ${$self->{_subtree}}[$i - 1];
	$i -= 1;
    }
    ${$self->{_key}}[$index] = $obj;
    ${$self->{_subtree}}[$index] = $child;
    $child->{_parent} = $self;
    return @result;
}

# @method attachLeftHalfOf
# Attaches the left half of the given B-tree
# to this B-tree node.
# @param selft This B-tree.
# @param btree A B-tree.
sub attachLeftHalfOf
{
    my ($self, $btree) = @_;
    $self->{_count} = (($self->getM() + 1) / 2) - 1;
    $self->attachSubtree(0, $btree->getSubtree(0));
    for (my $i = 1; $i <= $self->{_count}; ++$i)
    {
	${$self->{_key}}[$i] = $btree->getKey($i);
	$self->attachSubtree($i, $btree->getSubtree($i));
    }
}

# @method attachRightHalfOf
# Attaches the right half of the given B-tree
# to this B-tree node.
# @param self This B-tree.
# @param btree A B-tree.
sub attachRightHalfOf
{
    my ($self, $btree) = @_;
    $self->{_count} =
	$self->getM() - (($self->getM() + 1) / 2) - 1;
    my $j = (($self->getM() + 1) / 2);
    $self->attachSubtree(0, $btree->getSubtree($j));
    $j += 1;
    for (my $i = 1; $i <= $self->{_count}; ++$i)
    {
	${$self->{_key}}[$i] = $btree->getKey($j);
	$self->attachSubtree($i, $btree->getSubtree($j));
    }
}

# @method withdraw
# Withdraws the given object from this B-tree.
# @param self This B-tree.
# @param obj The object to withdraw.
sub withdraw
{
    croak 'NotImplementedError';
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "BTree test program.\n";
    my $tree = Opus10::BTree->new(3);
    Opus10::SearchTree::test($tree);
    $tree->purge();
    return $status;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::BTree>

=head2 CLASS C<Opus10::BTree>

=head3 Base Classes

=over

=item C<Opus10::MWayTree>

=back

A B-tree.

=head3 ATTRIBUTES

=over

=item C<_parent>

The parent of this B-tree.

=back

=head3 METHOD C<attachLeftHalfOf>

Attaches the left half of the given B-tree
to this B-tree node.

=head4 Parameters

=over

=item C<selft>

This B-tree.

=item C<btree>

A B-tree.

=back

=head3 METHOD C<attachRightHalfOf>

Attaches the right half of the given B-tree
to this B-tree node.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<btree>

A B-tree.

=back

=head3 METHOD C<attachSubtree>

Attaches the given tree
as the specified subtree of this B-tree node.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<i>

An index.

=item C<t>

A B-tree node.

=back

=head3 METHOD C<initialize>

Initializes an M-way search tree node with the given order m.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<m>

An integer greater than 2.

=back

=head3 METHOD C<insert>

Inserts the given object in this B-tree.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<obj>

The object to insert.

=back

=head3 METHOD C<insertPair>

Inserts the given object and subtree at the specified index
in the key and subtree arrays of this B-tree node
and returns any leftover key and subtree.

=head4 Parameters

=over

=item C<index>

The position at which to insert the pair.

=item C<obj>

An object.

=item C<child>

A B-tree.

=back

=head4 Return

The leftover key and subtree.

=head3 METHOD C<insertUp>

Inserts the given (object, B-tree) pair into this B-tree.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<obj>

An object.

=item C<child>

A B-tree.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this B-Tree.
Note: Because of the circular references in a B-tree,
all B-trees must be purged in order for the reference counting GC to work.

=head4 Parameters

=over

=item C<self>

This B-tree.

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this B-tree.

=head4 Parameters

=over

=item C<self>

This B-tree.

=item C<obj>

The object to withdraw.

=back

=cut

