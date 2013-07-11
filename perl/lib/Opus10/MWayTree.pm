#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MWayTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MWayTree.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MWayTree
# An M-way search tree implemented using arrays.
# @attr _key The key array.
# @attr _subtree The subtree array.
package Opus10::MWayTree;
use Carp;
use Opus10::Declarators;
use Opus10::SearchTree;
use Opus10::Array;
use Opus10::QueueAsLinkedList;
our @ISA = qw(Opus10::SearchTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an M-way search tree node with the given order m.
# @param self This M-way tree.
# @param m An integer greater than 2.
sub initialize
{
    my ($self, $m) = @_;
    croak 'ArgumentError' if $m <= 2;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_key _subtree);
    tie (@{$self->{_key}}, 'Opus10::Array', $m - 1, 1);
    tie (@{$self->{_subtree}}, 'Opus10::Array', $m);
}

destructor qw(DESTROY);

# @method getM
# Returns the order (M) of this M-way tree.
# @param self This M-way tree.
# Returns M.
sub getM
{
    my ($self) = @_;
    return scalar(@{$self->{_subtree}});
}
#}>a

#{
# @method depthFirstTraversal
# Calls the given visitor function for each key in this M-way search tree
# in depth-first traversal order.
# @param self This M-way tree.
# @param visitor A visitor function.
sub depthFirstTraversal
{
    my ($self, $visitor) = @_;
    if (!$self->isEmpty())
    {
	for (my $i = 1; $i <= $self->{_count}; ++$i)
	{
	    &$visitor(${$self->{_key}}[$i],
		Opus10::Tree::PREVISIT);
	}
	${$self->{_subtree}}[0]->depthFirstTraversal($visitor);
	for (my $i = 1; $i <= $self->{_count}; ++$i)
	{
	    &$visitor(${$self->{_key}}[$i],
		Opus10::Tree::INVISIT);
	    ${$self->{_subtree}}[$i]->depthFirstTraversal(
		$visitor);
	}
	for (my $i = 1; $i <= $self->{_count}; ++$i)
	{
	    &$visitor(${$self->{_key}}[$i],
		Opus10::Tree::POSTVISIT);
	}
    }
}
#}>b

#{
# @method find
# Finds the object in this M-way search tree that equals the given object.
# @param self This M-way tree.
# @param obj The object to find.
# @return The object that equals the given object.
sub find
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	return undef;
    }
    my $i = $self->{_count};
    while ($i > 0)
    {
	my $diff = $obj <=> ${$self->{_key}}[$i];
	if ($diff == 0)
	{
	    return ${$self->{_key}}[$i];
	}
	last if $diff > 0;
	$i -= 1;
    }
    return ${$self->{_subtree}}[$i]->find($obj);
}
#}>c

#{
# @method findIndex
# Returns the position of the given object
# in the array of keys contained in this M-way tree node.
# Uses a binary search.
# @param self This M-way tree.
# @param Obj The object to find.
# @return The position of the given object.
sub findIndex
{
    my ($self, $obj) = @_;
    if ($self->isEmpty() || $obj < ${$self->{_key}}[1])
    {
	return 0;
    }
    my $left = 1;
    my $right = $self->{_count};
    while ($left < $right)
    {
	my $middle = ($left + $right + 1) / 2;
	if ($obj < ${$self->{_key}}[$middle])
	{
	    $right = $middle - 1;
	}
	else
	{
	    $left = $middle;
	}
    }
    return $left;
}
#}>d

#{
# @method insert
# Inserts the given object into this M-way search tree.
# @param self This M-way tree.
# @param $obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    if ($self->isEmpty()) {
	${$self->{_subtree}}[0] =
	    Opus10::MWayTree->new($self->getM());
	${$self->{_key}}[1] = $obj;
	${$self->{_subtree}}[1] =
	    Opus10::MWayTree->new($self->getM());
	$self->{_count} = 1;
    }
    else {
	my $index = $self->findIndex($obj);
	if ($index != 0 && ${$self->{_key}}[$index] == $obj) {
	    croak 'ValueError';
	}
	if (!$self->isFull()) {
	    my $i = $self->{_count};
	    while ($i > $index) {
		${$self->{_key}}[$i + 1] = ${$self->{_key}}[$i];
		${$self->{_subtree}}[$i + 1] =
		    ${$self->{_subtree}}[$i];
		$i -= 1;
	    }
	    ${$self->{_key}}[$index + 1] = $obj;
	    ${$self->{_subtree}}[$index + 1] =
		Opus10::MWayTree->new($self->getM());
	    $self->{_count} += 1;
	}
	else {
	    ${$self->{_subtree}}[$index]->insert($obj);
	}
    }
}
#}>e

#{
# @method withdraw
# Withdraws the given object from this M-way search tree.
# @param self This M-way tree.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    croak 'ArgumentError' if $self->isEmpty();
    my $index = $self->findIndex($obj);
    if ($index != 0 && ${$self->{_key}}[$index] == $obj) {
	if (!${$self->{_subtree}}[$index - 1]->isEmpty()) {
	    my $max = ${$self->{_subtree}}[$index - 1]->getMax();
	    ${$self->{_key}}[$index] = $max;
	    ${$self->{_subtree}}[$index - 1]->withdraw($max);
	}
	elsif (!${$self->{_subtree}}[$index]->isEmpty()) {
	    my $min = ${$self->{_subtree}}[$index]->getMin();
	    ${$self->{_key}}[$index] = $min;
	    ${$self->{_subtree}}[$index]->withdraw($min);
	}
	else {
	    $self->{_count} -= 1;
	    my $i = $index;
	    while ($i <= $self->{_count}) {
		${$self->{_key}}[$i] = ${$self->{_key}}[$i + 1];
		${$self->{_subtree}}[$i] =
		    ${$self->{_subtree}}[$i + 1];
		$i += 1;
	    }
	    ${$self->{_key}}[$i] = undef;
	    ${$self->{_subtree}}[$i] = undef;
	    if ($self->{_count} == 0) {
		${$self->{_subtree}}[0] = undef;
	    }
	}
    }
    else {
	${$self->{_subtree}}[$index]->withdraw($obj);
    }
}
#}>f

# @method purge
# Purges this M-way search tree.
# @param self This M-way tree.
sub purge
{
    my ($self) = @_;
    for (my $i = 1; $i <= $self->{_count}; ++$i)
    {
	${$self->{_key}}[$i] = undef;
    }
    for (my $i = 0; $i <= $self->{_count}; ++$i)
    {
	${$self->{_subtree}}[$i] = undef;
    }
    $self->{_count} = 0;
}

# @method breadthFirstTraversal
# Calls the given visitor function for each key in this M-way search tree
# in breadth-first traversal order.
# @param self This M-way tree.
# @param visitor A visitor function.
sub breadthFirstTraversal
{
    my ($self, $visitor) = @_;
    my $queue = Opus10::QueueAsLinkedList->new();
    if (!$self->isEmpty())
    {
	$queue->enqueue($self);
    }
    while (!$queue->isEmpty())
    {
	my $head = $queue->dequeue();
	for (my $i = 1; $i < $head->getDegree(); ++$i)
	{
	    &$visitor($head->getKey($i));
	}
	for (my $i = 0; $i < $head->getDegree(); ++$i)
	{
	    my $child = $head->getSubtree($i);
	    if (!$child->isEmpty())
	    {
		$queue->enqueue($child);
	    }
	}
    }
}

# @method iter
# Returns an iterator that enumerates the keys in an M-way search tree.
# @param self This M-way tree.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $stack = Opus10::StackAsLinkedList->new(); # Iterator state.
    my $position = 1; # Iterator state.
    if (!$self->isEmpty())
    {
	$stack->push($self);
    }
    return
	sub
	{
	    my $result = undef;
	    if (!$stack->isEmpty())
	    {
		my $top = $stack->getTop();
		$result = $top->getKey($position);
		$position += 1;
		if ($position == $top->getDegree())
		{
		    $position = 1;
		    $top = $stack->pop();
		    my $i = $top->getDegree() - 1;
		    while ($i >= 0)
		    {
			my $subtree = $top->getSubtree($i);
			if (!$subtree->isEmpty())
			{
			    $stack->push($subtree);
			}
			$i -= 1;
		    }
		}
	    }
	    return $result;
	}
}

# @method isEmpty
# IsEmpty predicate.
# @param self This M-way tree.
# @return true if this M-way search tree is empty.
sub isEmpty
{
    my ($self) = @_;
    return $self->{_count} == 0;
}

# @method isFull
# IsFull predicate.
# @param self This M-way tree.
# @return True if this M-way search tree is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == $self->getM() - 1;
}

# @method isLeaf
# IsLeaf predicate.
# @param self This M-way tree.
# @return True if this M-way search tree node is a leaf node.
sub isLeaf
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	if (!${$self->{_subtree}}[$i]->isEmpty())
	{
	    return 0;
	}
    }
    return 1;
}

# @method getDegree
# Returns the degree of this M-way search tree node.
# @param self This M-way tree.
# @return The degree.
sub getDegree
{
    my ($self) = @_;
    if ($self->{_count} == 0)
    {
	return 0;
    }
    else
    {
	return $self->{_count} + 1;
    }
}

# @method getKey
# Returns the specified key contained in this M-way search tree node.
# @param self This M-way tree.
# @param i An index.
# @return The specified key.
sub getKey
{
    my ($self, $i) = @_;
    croak 'StateError' if $self->isEmpty();
    if (defined($i))
    {
	return ${$self->{_key}}[$i];
    }
    else
    {
	return ${$self->{_key}}[1];
    }
}

# @method getSubtree
# Returns the specified subtree of this M-way search tree node.
# @param self This M-way tree.
# @param i An index.
# @return The specified subtree.
sub getSubtree
{
    my ($self, $i) = @_;
    croak 'StateError' if $self->isEmpty();
    return ${$self->{_subtree}}[$i];
}

# @method getCount
# Returns the number of keys contained in this M-way search tree.
# @param self This M-way tree.
# @return The number of keys.
sub getCount
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    my $result = $self->{_count};
    for (my $i = 0; $i <= $self->{_count}; ++$i)
    {
	$result += ${$self->{_subtree}}[$i]->getCount();
    }
    return $result;
}

# @method contains
# Returns true if the given object is in this M-way search tree.
# @param self This M-way tree.
# @param obj An object.
# @return True if the given object is in this tree.
sub contains
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    my $i = $self->{_count};
    while ($i > 0)
    {
	if (${$self->{_key}}[$i]->is($obj))
	{
	    return 1;
	}
	last if ($obj > ${$self->{_key}}[$i]);
	$i -= 1;
    }
    return ${$self->{_subtree}}[$i]->contains($obj);
}

# @method getMin
# Return the smallest key in this M-way search tree.
# @param self This M-way tree.
# @return The smallest key.
sub getMin
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return undef;
    }
    elsif (${$self->{_subtree}}[0]->isEmpty())
    {
	return ${$self->{_key}}[1];
    }
    else
    {
	return ${$self->{_subtree}}[0]->getMin();
    }
}

# @method getMax
# The largest key in this M-way search tree.
# @param self This M-way tree.
# @param The largest key.
sub getMax
{
    my ($self);
    if ($self->isEmpty())
    {
	return undef;
    }
    elsif (${$self->{_subtree}}[$self->{_count}]->isEmpty())
    {
	return ${$self->{_key}}[$self->{_count}];
    }
    else
    {
	return ${$self->{_subtree}}[$self->{_count}]->getMax();
    }
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "MWayTree test program.\n";
    my $tree = Opus10::MWayTree->new(3);
    Opus10::SearchTree::test($tree);
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

=head1 MODULE C<Opus10::MWayTree>

=head2 CLASS C<Opus10::MWayTree>

=head3 Base Classes

=over

=item C<Opus10::SearchTree>

=back

An M-way search tree implemented using arrays.

=head3 ATTRIBUTES

=over

=item C<_key>

The key array.

=item C<_subtree>

The subtree array.

=back

=head3 METHOD C<breadthFirstTraversal>

Calls the given visitor function for each key in this M-way search tree
in breadth-first traversal order.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<contains>

Returns true if the given object is in this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<obj>

An object.

=back

=head4 Return

True if the given object is in this tree.

=head3 METHOD C<depthFirstTraversal>

Calls the given visitor function for each key in this M-way search tree
in depth-first traversal order.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<find>

Finds the object in this M-way search tree that equals the given object.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<obj>

The object to find.

=back

=head4 Return

The object that equals the given object.

=head3 METHOD C<findIndex>

Returns the position of the given object
in the array of keys contained in this M-way tree node.
Uses a binary search.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<Obj>

The object to find.

=back

=head4 Return

The position of the given object.

=head3 METHOD C<getCount>

Returns the number of keys contained in this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

The number of keys.

=head3 METHOD C<getDegree>

Returns the degree of this M-way search tree node.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

The degree.

=head3 METHOD C<getKey>

Returns the specified key contained in this M-way search tree node.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<i>

An index.

=back

=head4 Return

The specified key.

=head3 METHOD C<getM>

Returns the order (M) of this M-way tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.
Returns M.

=back

=head3 METHOD C<getMax>

The largest key in this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<The>

largest key.

=back

=head3 METHOD C<getMin>

Return the smallest key in this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

The smallest key.

=head3 METHOD C<getSubtree>

Returns the specified subtree of this M-way search tree node.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<i>

An index.

=back

=head4 Return

The specified subtree.

=head3 METHOD C<initialize>

Initializes an M-way search tree node with the given order m.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<m>

An integer greater than 2.

=back

=head3 METHOD C<insert>

Inserts the given object into this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<$obj>

The object to insert.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

true if this M-way search tree is empty.

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

True if this M-way search tree is full.

=head3 METHOD C<isLeaf>

IsLeaf predicate.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

True if this M-way search tree node is a leaf node.

=head3 METHOD C<iter>

Returns an iterator that enumerates the keys in an M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head4 Return

An iterator.

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

Purges this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this M-way search tree.

=head4 Parameters

=over

=item C<self>

This M-way tree.

=item C<obj>

The object to withdraw.

=back

=cut

