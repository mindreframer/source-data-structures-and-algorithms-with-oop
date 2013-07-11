#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BinaryTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BinaryTree.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BinaryTree
# A binary tree.
# @attr _key The key.
# @attr _left The left subtree.
# @attr _right The right subtree.
package Opus10::BinaryTree;
use Carp;
use Opus10::Declarators;
use Opus10::Tree;
our @ISA = qw(Opus10::Tree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a binary tree node that contains the given key and subtrees.
# @param self This general tree.
# @param key An object. Optional.
# @param left A binary tree. Optional.
# @param right A binary tree. Optional.
sub initialize
{
    my ($self, $key, $left, $right) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_key _left _right);
    if (defined($key))
    {
	$self->{_key} = $key;
	$self->{_left} = defined($left) ?
	    $left : Opus10::BinaryTree->new();
	$self->{_right} = defined($right) ?
	    $right : Opus10::BinaryTree->new();
    }
    else
    {
	$self->{_key} = undef;
	$self->{_left} = undef;
	$self->{_right} = undef;
    }
}

destructor qw(DESTROY);

# @method purge
# Purges this binary tree.
# @param self This binary tree.
sub purge
{
    my ($self) = @_;
    $self->{_key} = undef;
    $self->{_left} = undef;
    $self->{_right} = undef;
}
#}>a

#{
# @method getLeft
# Returns the left subtree of this binary tree node.
# @param self This binary tree node.
# @return The left subtree of this binary tree node.
sub getLeft
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    return $self->{_left};
}

# @method getRight
# Returns the right subtree of this binary tree node.
# @param self This binary tree node.
# @return The right subtree of this binary tree node.
sub getRight
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    return $self->{_right};
}
#}>b

#{
# @method depthFirstTraversal
# Calls the given visitor function for each key in this tree
# in the order of a depth-first traversal of this tree.
# @param self This binary tree node.
# @param visitor A visitor function.
sub depthFirstTraversal
{
    my ($self, $visitor) = @_;
    if (!$self->isEmpty())
    {
	&$visitor($self->getKey(), Opus10::Tree::PREVISIT);
	$self->{_left}->depthFirstTraversal($visitor);
	&$visitor($self->getKey(), Opus10::Tree::INVISIT);
	$self->{_right}->depthFirstTraversal($visitor);
	&$visitor($self->getKey(), Opus10::Tree::POSTVISIT);
    }
}
#}>c

#{
# @method compareTo
# Compares this binary tree with the given binary tree.
# @param self This binary tree.
# @param bt The binary tree to compare.
# @return A number less than, equal to, or greater than zero
# depending on whether this tree is
# less than, equal to, or greater than (respectively) the given tree.
sub compareTo
{
    my ($self, $bt) = @_;
    croak 'IllegalArgument' if ($self->isNot(ref($bt)));
    if ($self->isEmpty())
    {
	if ($bt->isEmpty())
	{
	    return 0;
	}
	else
	{
	    return -1;
	}
    }
    elsif ($bt->isEmpty())
    {
	return 1;
    }
    else
    {
	my $result = $self->getKey() <=> $bt->getKey();
	if ($result == 0)
	{
	    $result = $self->getLeft() <=> $bt->getLeft();
	}
	if ($result == 0)
	{
	    $result = $self->getRight() <=> $bt->getRight();
	}
	return $result;
    }
}
#}>d

# @method isLeaf
# IsLeaf predicate
# @param self This binary tree node.
# @return True if this binary tree node is a leaf node.
sub isLeaf
{
    my ($self) = @_;
    return !$self->isEmpty() &&
	    $self->getLeft()->isEmpty() &&
	    $self->getRight()->isEmpty();
}

# @method getDegree
# The degree of this binary tree node.
# @param self This binary tree node.
# @return The degree of this binary tree node.
sub getDegree
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    else
    {
	return 2;
    }
}

# @method isEmpty
# IsEmpty predicate
# @param self This binary tree node.
# @return True if this binary tree node is empty.
sub isEmpty
{
    my ($self) = @_;
    return !defined($self->{_key});
}

# @method getKey
# Returns the key in this binary tree node.
# @param self This binary tree node.
# @return The key in this binary tree node.
sub getKey
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    return $self->{_key};
}

# @method getSubtree
# Returns the specified subtree of this binary tree node.
# @param self This binary tree node.
# @param i An index in the range 0..1.
# @return The specified subtree.
sub getSubtree
{
    my ($self, $i) = @_;
    if ($i == 0)
    {
	return $self->getLeft();
    }
    elsif ($i == 1)
    {
	return $self->getRight();
    }
    else
    {
	croak 'IndexError';
    }
}

# @method attachKey
# Attaches the given key to this binary tree node.
# @param self This binary tree node.
# @param obj An object.
sub attachKey
{
    my ($self, $obj) = @_;
    croak 'StateError' if !$self->isEmpty();
    $self->{_key} = $obj;
    $self->{_left} = Opus10::BinaryTree->new();
    $self->{_right} = Opus10::BinaryTree->new();
}

# @method detachKey
# Detaches the key from this binary tree node.
# @param self This binary tree node.
# @return The key.
sub detachKey
{
    my ($self) = @_;
    croak 'StateError' if !$self->isLeaf();
    my $result = $self->{_key};
    $self->{_key} = undef;
    return $result;
}

# @method attachLeft
# Attaches the given tree as the left subtree of this binary tree node.
# @param self This binary tree node.
# @param t A binary tree.
sub attachLeft
{
    my ($self, $t) = @_;
    croak 'StateError' if ($self->isEmpty() || !$self->getLeft()->isEmpty());
    $self->{_left} = $t;
}

# @method detachLeft
# Detaches and returns the left subtree of this binary tree node.
# @param self This binary tree node.
# @return The left subtree.
sub detachLeft
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    my $result = $self->{_left};
    $self->{_left} = Opus10::BinaryTree->new();
    return $result;
}

# @method attachRight
# Attaches the given tree as the right subtree of this binary tree node.
# @param self This binary tree node.
# @param t A binary tree.
sub attachRight
{
    my ($self, $t) = @_;
    croak 'StateError' if ($self->isEmpty() || !$self->getRight()->isEmpty());
    $self->{_right} = $t;
}

# @method detachRight
# Detaches and returns the right subtree of this binary tree node.
# @param self This binary tree node.
# @return The right subtree.
sub detachRight
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    my $result = $self->{_right};
    $self->{_right} = Opus10::BinaryTree->new();
    return $result;
}

use Opus10::Box;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "BinaryTree test program.\n";
    my $bt = Opus10::BinaryTree->new(box(4));
    $bt->attachLeft(Opus10::BinaryTree->new(box(2)));
    $bt->attachRight(Opus10::BinaryTree->new(box(6)));
    Opus10::Tree::test($bt);
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

=head1 MODULE C<Opus10::BinaryTree>

=head2 CLASS C<Opus10::BinaryTree>

=head3 Base Classes

=over

=item C<Opus10::Tree>

=back

A binary tree.

=head3 ATTRIBUTES

=over

=item C<_key>

The key.

=item C<_left>

The left subtree.

=item C<_right>

The right subtree.

=back

=head3 METHOD C<attachKey>

Attaches the given key to this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=item C<obj>

An object.

=back

=head3 METHOD C<attachLeft>

Attaches the given tree as the left subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=item C<t>

A binary tree.

=back

=head3 METHOD C<attachRight>

Attaches the given tree as the right subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=item C<t>

A binary tree.

=back

=head3 METHOD C<compareTo>

Compares this binary tree with the given binary tree.

=head4 Parameters

=over

=item C<self>

This binary tree.

=item C<bt>

The binary tree to compare.

=back

=head4 Return

A number less than, equal to, or greater than zero
depending on whether this tree is
less than, equal to, or greater than (respectively) the given tree.

=head3 METHOD C<depthFirstTraversal>

Calls the given visitor function for each key in this tree
in the order of a depth-first traversal of this tree.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<detachKey>

Detaches the key from this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The key.

=head3 METHOD C<detachLeft>

Detaches and returns the left subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The left subtree.

=head3 METHOD C<detachRight>

Detaches and returns the right subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The right subtree.

=head3 METHOD C<getDegree>

The degree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The degree of this binary tree node.

=head3 METHOD C<getKey>

Returns the key in this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The key in this binary tree node.

=head3 METHOD C<getLeft>

Returns the left subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The left subtree of this binary tree node.

=head3 METHOD C<getRight>

Returns the right subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

The right subtree of this binary tree node.

=head3 METHOD C<getSubtree>

Returns the specified subtree of this binary tree node.

=head4 Parameters

=over

=item C<self>

This binary tree node.

=item C<i>

An index in the range 0..1.

=back

=head4 Return

The specified subtree.

=head3 METHOD C<initialize>

Initializes a binary tree node that contains the given key and subtrees.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<key>

An object. Optional.

=item C<left>

A binary tree. Optional.

=item C<right>

A binary tree. Optional.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

True if this binary tree node is empty.

=head3 METHOD C<isLeaf>

IsLeaf predicate

=head4 Parameters

=over

=item C<self>

This binary tree node.

=back

=head4 Return

True if this binary tree node is a leaf node.

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

Purges this binary tree.

=head4 Parameters

=over

=item C<self>

This binary tree.

=back

=cut

