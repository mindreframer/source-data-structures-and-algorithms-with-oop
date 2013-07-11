#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BinaryHeap.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BinaryHeap.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BinaryHeap
# Priority queue implemented using a binary heap.
# @attr _array The heap.
package Opus10::BinaryHeap;
use Carp;
use Opus10::Declarators;
use Opus10::PriorityQueue;
use Opus10::Array;
our @ISA = qw(Opus10::PriorityQueue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this priority queue with the given size.
# @param self This priority queue.
# @param size The size of the binary heap.
sub initialize
{
    my ($self, $size) = @_;
    $size = $size || 0;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array);
    tie (@{$self->{_array}}, qw(Opus10::Array), $size, 1);
}

destructor qw(DESTROY);

# @method purge
# Purges this binary heap.
# @param self This binary heap.
sub purge
{
    my ($self) = @_;
    while ($self->{_count} > 0)
    {
	${$self->{_array}}[$self->{_count}] = undef;
	$self->{_count} -= 1;
    }
}
#}>a

#{
# @method enqueue
# Enqueues the given object in this binary heap.
# @param self This binary heap.
# @param obj An object.
sub enqueue
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if $self->{_count} == @{$self->{_array}};
    $self->{_count} += 1;
    my $i = $self->{_count};
    while ($i > 1 && ${$self->{_array}}[$i / 2] > $obj)
    {
	${$self->{_array}}[$i] = ${$self->{_array}}[$i / 2];
	$i = $i / 2;
    }
    ${$self->{_array}}[$i] = $obj;
}
#}>b

#{
# @method getMin
# Returns the smallest value in this binary heap.
# @param self This binary heap.
# @return The smallest value.
sub getMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return ${$self->{_array}}[1];
}
#}>c

#{
# @method dequeueMin
# Dequeues and returns the smallest value in this binary heap.
# @param self This binary heap.
# @return The smallest value.
sub dequeueMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = ${$self->{_array}}[1];
    my $last = ${$self->{_array}}[$self->{_count}];
    $self->{_count} -= 1;
    my $i = 1;
    while (2 * $i < $self->{_count} + 1)
    {
	my $child = 2 * $i;
	if ($child + 1 < $self->{_count} + 1 &&
	    ${$self->{_array}}[$child + 1] <
		${$self->{_array}}[$child])
	{
	    $child += 1;
	}
	last if $last <= ${$self->{_array}}[$child];
	${$self->{_array}}[$i] = ${$self->{_array}}[$child];
	$i = $child;
    }
    ${$self->{_array}}[$i] = $last;
    return $result;
}
#}>d

# @method isFull
# IsFull predicate.
# @param self This binary heap
# @return True if this binary heap is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_array}} - 1;
}

# @method each
# Calls the given visitor function for each object in this binary heap.
# @param self This binary heap.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 1; $i <= $self->{_count}; ++$i)
    {
	&$visitor(${$self->{_array}}[$i]);
    }
}

# @method iter
# Returns an iterator that enumerates the elements of this binary heap.
# @param self This binary heap.
# @return An iterator
sub iter
{
    my ($self) = @_;
    my $position = 1; # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if ($position <= $self->{_count})
	    {
		$result = ${$self->{_array}}[$position];
		$position += 1;
	    }
	    return $result;
	}
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "BinaryHeap test program.\n";
    my $pqueue = Opus10::BinaryHeap->new(256);
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

=head1 MODULE C<Opus10::BinaryHeap>

=head2 CLASS C<Opus10::BinaryHeap>

=head3 Base Classes

=over

=item C<Opus10::PriorityQueue>

=back

Priority queue implemented using a binary heap.

=head3 ATTRIBUTES

=over

=item C<_array>

The heap.

=back

=head3 METHOD C<dequeueMin>

Dequeues and returns the smallest value in this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=back

=head4 Return

The smallest value.

=head3 METHOD C<each>

Calls the given visitor function for each object in this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<enqueue>

Enqueues the given object in this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=item C<obj>

An object.

=back

=head3 METHOD C<getMin>

Returns the smallest value in this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=back

=head4 Return

The smallest value.

=head3 METHOD C<initialize>

Initializes this priority queue with the given size.

=head4 Parameters

=over

=item C<self>

This priority queue.

=item C<size>

The size of the binary heap.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This binary heap

=back

=head4 Return

True if this binary heap is full.

=head3 METHOD C<iter>

Returns an iterator that enumerates the elements of this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=back

=head4 Return

An iterator

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this binary heap.

=head4 Parameters

=over

=item C<self>

This binary heap.

=back

=cut

