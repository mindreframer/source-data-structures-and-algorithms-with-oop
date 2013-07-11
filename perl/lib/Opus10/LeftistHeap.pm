#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: LeftistHeap.pm,v $
#   $Revision: 1.2 $
#
#   $Id: LeftistHeap.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::LeftistHeap
# A mergeable priority queue implemented as a leftist binary tree.
# A leftist heap.
# @attr _nullPathLength The null path length.
package Opus10::LeftistHeap;
use Carp;
use Opus10::Declarators;
use Opus10::BinaryTree;
use Opus10::MergeablePriorityQueue;
our @ISA = qw(Opus10::BinaryTree Opus10::MergeablePriorityQueue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a leftist heap node that contains the given key.
# @param self This leftist heap.
# @param key An object. Optional.
sub initialize
{
    my ($self, $key) = @_;
    return if $self->isInitialized();
    $self->declare qw(_nullPathLength);
    if (defined($key))
    {
	$self->SUPER::initialize($key,
	    Opus10::LeftistHeap->new(),
	    Opus10::LeftistHeap->new());
	$self->{_nullPathLength} = 1;
    }
    else
    {
	$self->SUPER::initialize();
	$self->{_nullPathLength} = 0;
    }
}

destructor qw(DESTROY);

attr_accessor qw(_nullPathLength);
#}>a

# @function min
# Returns the smaller of the given objects.
# @param x An object.
# @param y An object.
# @return The smaller object.
sub min
{
    my ($x, $y) = @_;
    return $x < $y ? $x : $y;
}

#{
# @method merge
# Merges this leftist heap with the given leftist heap.
# All the objects in the given leftist heap
# are transfered to this leftist heap.
# Therefore, after the merge, the given leftist heap is empty.
# @param self This leftist heap.
# @param queue A leftist heap.
sub merge
{
    my ($self, $queue) = @_;
    if ($self->isEmpty())
    {
	$self->swapContentsWith($queue);
    }
    elsif (!$queue->isEmpty())
    {
	if ($self->{_key} > $queue->{_key})
	{
	    $self->swapContentsWith($queue);
	}
	$self->{_right}->merge($queue);
	if ($self->{_left}->getNullPathLength() <
	    $self->{_right}->getNullPathLength())
	{
	    $self->swapSubtrees();
	}
	$self->{_nullPathLength} = 1 +
	    min($self->{_left}->getNullPathLength(),
		$self->{_right}->getNullPathLength());
    }
}
#}>b

#{
# @method enqueue
# Enqueues the given object in this leftist heap.
# @param self This leftist heap.
# @param obj The object to enqueue.
sub enqueue
{
    my ($self, $obj) = @_;
    $self->merge(Opus10::LeftistHeap->new($obj));
}
#}>c

#{
# @method getMin
# Returns the smallest object in this leftist heap.
# @param self This leftist heap.
# @return The smallest object in this  heap.
sub getMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->isEmpty();
    return $self->{_key};
}
#}>d

#{
# @method dequeueMin
# Dequeues and returns the smallest object in this leftist heap.
# @param self This leftist heap.
# @return The smallext object in this heap.
sub dequeueMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->isEmpty();
    my $result = $self->{_key};
    my $oldLeft = $self->{_left};
    my $oldRight = $self->{_right};
    $self->purge();
    $self->swapContentsWith($oldLeft);
    $self->merge($oldRight);
    return $result;
}
#}>e

# @method swapContentsWith
# Swaps the contents of this leftist heap node
# with the given leftist heap node.
# @param self This leftist heap.
# @param heap A leftist heap node.
sub swapContentsWith
{
    my ($self, $heap) = @_;
    ($self->{_key}, $heap->{_key}) =
	($heap->{_key}, $self->{_key});
    ($self->{_left}, $heap->{_left}) =
	($heap->{_left}, $self->{_left});
    ($self->{_right}, $heap->{_right}) =
	($heap->{_right}, $self->{_right});
    ($self->{_nullPathLength}, $heap->{_nullPathLength}) =
	($heap->{_nullPathLength}, $self->{_nullPathLength});
}

# @method swapSubtrees
# Swaps the subtrees of this leftist heap node.
# @param self This leftist heap.
sub swapSubtrees
{
    my ($self) = @_;
    ($self->{_left}, $self->{_right}) =
	($self->{_right}, $self->{_left});
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "LeftistHeap test program.\n";
    my $pqueue = Opus10::LeftistHeap->new();
    Opus10::PriorityQueue::test($pqueue);
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

=head1 MODULE C<Opus10::LeftistHeap>

=head2 CLASS C<Opus10::LeftistHeap>

=head3 Base Classes

=over

=item C<Opus10::BinaryTree>

=item C<Opus10::MergeablePriorityQueue>

=back

A mergeable priority queue implemented as a leftist binary tree.
A leftist heap.

=head3 ATTRIBUTES

=over

=item C<_nullPathLength>

The null path length.

=back

=head3 METHOD C<dequeueMin>

Dequeues and returns the smallest object in this leftist heap.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=back

=head4 Return

The smallext object in this heap.

=head3 METHOD C<enqueue>

Enqueues the given object in this leftist heap.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=item C<obj>

The object to enqueue.

=back

=head3 METHOD C<getMin>

Returns the smallest object in this leftist heap.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=back

=head4 Return

The smallest object in this  heap.

=head3 METHOD C<initialize>

Initializes a leftist heap node that contains the given key.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=item C<key>

An object. Optional.

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

=head3 METHOD C<merge>

Merges this leftist heap with the given leftist heap.
All the objects in the given leftist heap
are transfered to this leftist heap.
Therefore, after the merge, the given leftist heap is empty.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=item C<queue>

A leftist heap.

=back

=head3 FUNCTION C<min>

Returns the smaller of the given objects.

=head4 Parameters

=over

=item C<x>

An object.

=item C<y>

An object.

=back

=head4 Return

The smaller object.

=head3 METHOD C<swapContentsWith>

Swaps the contents of this leftist heap node
with the given leftist heap node.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=item C<heap>

A leftist heap node.

=back

=head3 METHOD C<swapSubtrees>

Swaps the subtrees of this leftist heap node.

=head4 Parameters

=over

=item C<self>

This leftist heap.

=back

=cut

