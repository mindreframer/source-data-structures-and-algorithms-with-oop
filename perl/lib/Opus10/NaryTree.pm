#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: NaryTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: NaryTree.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::NaryTree
# N-ary tree impelemented using an array.
# @attr _degree The degree.
# @attr _key The key.
# @attr _subtree The array of subtrees.
package Opus10::NaryTree;
use Carp;
use Opus10::Declarators;
use Opus10::Tree;
use Opus10::Array;
our @ISA = qw(Opus10::Tree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a N-ary tree node that contains the given key and subtrees.
# @param self This general tree.
# @param n The degree.
# @param key An object.
sub initialize
{
    my ($self, $n, $key) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_degree _key _subtree);
    if (defined($key))
    {
	$self->{_degree} = $n;
	$self->{_key} = $key;
	tie (@{$self->{_subtree}}, 'Opus10::Array', $n);
	for (my $i = 0; $i < $n; ++$i)
	{
	    ${$self->{_subtree}}[$i] = Opus10::NaryTree->new($n);
	}
    }
    else
    {
	$self->{_degree} = $n;
	$self->{_key} = undef;
	$self->{_subtree} = undef;
    }
}

destructor qw(DESTROY);

# @method purge
# Purges this N-ary tree.
# @param self This N-ary tree.
sub purge
{
    my ($self) = @_;
    $self->{_key} = undef;
    $self->{_subtree} = undef;
}
#}>a

#{
# @method isEmpty
# IsEmpty predicate
# True if this N-ary tree is empty.
# @param self This N-ary tree.
# @return True if this N-ary tree is empty.
sub isEmpty
{
    my ($self) = @_;
    return !defined($self->{_key});
}

# @method getKey
# The key in this N-ary tree node.
sub getKey
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    return $self->{_key};
}

# @method attachKey
# Attaches the given key to this N-ary tree node.
# @param self This N-ary tree node.
# @param obj An object.
sub attachKey
{
    my ($self, $obj) = @_;
    croak 'StateError' if $self->isEmpty();
    $self->{_key} = $obj;
    tie(@{$self->{_subtree}}, 'Opus10::Array', $self->{_degree});
    for (my $i = 0; $i < $self->{_degree}; ++$i)
    {
	${$self->{_subtree}}[$i] =
	    Opus10::NaryTree->new($self->{_degree});
    }
}

# @method detachKey
# Detaches and returns the key of this N-ary tree node.
# @param self This N-ary tree node.
# @return The key.
sub detachKey
{
    my ($self) = @_;
    croak 'StateError' if !$self->isLeaf();
    my $result = $self->{_key};
    $self->{_key} = undef;
    $self->{_subtree} = undef;
    return $result;
}
#}>b

#{
# @method getSubtree
# Returns the specified subtree of this N-ary tree node.
# @param self This N-ary tree node.
# @param i An index.
# @return The specified subtree.
sub getSubtree
{
    my ($self, $i) = @_;
    croak 'StateError' if $self->isEmpty();
    return ${$self->{_subtree}}[$i];
}

# @method attachSubtree
# Attaches the given N-ary tree
# as the specified subtree of this N-ary tree node.
# @param self This N-ary tree.
# @param i An index.
# @param t An N-ary subtree.
sub attachSubtree
{
    my ($self, $i, $t) = @_;
    croak 'StateError' if ($self->isEmpty() ||
	    !${$self->{_subtree}}[$i]->isEmpty());
    ${$self->{_subtree}}[$i] = $t;
}

# @method detachSubtree
# Detaches and returns the specified subtree of this N-ary tree node.
# @param self This N-ary tree.
# @param i An index.
# @return The specified subtree.
sub detachSubtree
{
    my ($self, $i) = @_;
    croak 'StateError' if $self->isEmpty();
    my $result = ${$self->{_subtree}}[$i];
    ${$self->{_subtree}}[$i] =
	Opus10::NaryTree->new($self->{_degree});
    return $result;
}
#}>c

# @method getDegree
# Returns the degree of this N-ary tree node.
# @param self This N-ary tree.
# @return The degree of this N-ary tree.
sub getDegree
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    else
    {
	return $self->{_degree};
    }
}

# @method isLeaf
# IsLeaf predicate
# @param self This N-ary tree.
# @return True if this N-ary tree is a leaf node.
sub isLeaf
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    for (my $i = 0; $i < $self->{_degree}; ++$i)
    {
	if (!${$self->{_subtree}}[$i]->isEmpty())
	{
	    return 0;
	}
    }
    return 1;
}

use Opus10::Box;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "NaryTree test program.\n";
    my $nt = Opus10::NaryTree->new(3, box(1));
    $nt->attachSubtree(0, Opus10::NaryTree->new(3, box(2)));
    $nt->attachSubtree(1, Opus10::NaryTree->new(3, box(3)));
    $nt->attachSubtree(2, Opus10::NaryTree->new(3, box(4)));
    Opus10::Tree::test($nt);
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

=head1 MODULE C<Opus10::NaryTree>

=head2 CLASS C<Opus10::NaryTree>

=head3 Base Classes

=over

=item C<Opus10::Tree>

=back

N-ary tree impelemented using an array.

=head3 ATTRIBUTES

=over

=item C<_degree>

The degree.

=item C<_key>

The key.

=item C<_subtree>

The array of subtrees.

=back

=head3 METHOD C<attachKey>

Attaches the given key to this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree node.

=item C<obj>

An object.

=back

=head3 METHOD C<attachSubtree>

Attaches the given N-ary tree
as the specified subtree of this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=item C<i>

An index.

=item C<t>

An N-ary subtree.

=back

=head3 METHOD C<detachKey>

Detaches and returns the key of this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree node.

=back

=head4 Return

The key.

=head3 METHOD C<detachSubtree>

Detaches and returns the specified subtree of this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=item C<i>

An index.

=back

=head4 Return

The specified subtree.

=head3 METHOD C<getDegree>

Returns the degree of this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=back

=head4 Return

The degree of this N-ary tree.

=head3 METHOD C<getKey>

The key in this N-ary tree node.

=head3 METHOD C<getSubtree>

Returns the specified subtree of this N-ary tree node.

=head4 Parameters

=over

=item C<self>

This N-ary tree node.

=item C<i>

An index.

=back

=head4 Return

The specified subtree.

=head3 METHOD C<initialize>

Initializes a N-ary tree node that contains the given key and subtrees.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<n>

The degree.

=item C<key>

An object.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate
True if this N-ary tree is empty.

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=back

=head4 Return

True if this N-ary tree is empty.

=head3 METHOD C<isLeaf>

IsLeaf predicate

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=back

=head4 Return

True if this N-ary tree is a leaf node.

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

Purges this N-ary tree.

=head4 Parameters

=over

=item C<self>

This N-ary tree.

=back

=cut

