#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Deap.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Deap.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Deap
# Double-end priority queue implemented as a double-end binary heap.
# @attr _array The heap.
package Opus10::Deap;
use Carp;
use Opus10::Declarators;
use Opus10::DoubleEndedPriorityQueue;
use Opus10::Array;
our @ISA = qw(Opus10::DoubleEndedPriorityQueue);

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
    tie (@{$self->{_array}}, qw(Opus10::Array), $size + 1, 1);
}

destructor qw(DESTROY);

# @method purge
# Purges this deap.
# @param self This deap.
sub purge
{
    my ($self) = @_;
    $self->{_array} =
	Opus10::Array->new(scalar(@{$self->{_array}}), 1);
    $self->{_count} = 0;
}

# @method log2
# Returns ceil(log_2(i)).
# @param i A non-negative integer.
# @return ceil(log_2(i)).
sub log2
{
    my ($i) = @_;
    use integer;
    my $result = 0;
    while ((1 << $result) <= $i)
    {
	$result += 1;
    }
    return $result - 1;
}

# @method mask
# Returns 2^(ceil(log_2(i))).
# @param i A non-negative integer.
# @return 2^(ceil(log_2(i))).
sub mask
{
    my ($i) = @_;
    use integer;
    return 1 << (log2($i) - 1);
}

# @method dual
# Returns the index of the dual of the given index.
# @param self This deap.
# @param i An index.
# @return The dual of the given index.
sub dual
{
    my ($self, $i) = @_;
    my $m = mask($i);
    my $result = $i ^ $m;
    if (($result & $m) != 0)
    {
	if ($result >= $self->{_count} + 2)
	{
	    use integer;
	    $result = $result / 2;
	}
    }
    else
    {
	if (2 * $result < $self->{_count} + 2)
	{
	    $result *= 2;
	    if ($result + 1 < $self->{_count} + 2
		&& ${$self->{_array}}[$result + 1] >
		    ${$self->{_array}}[$result])
	    {
		$result += 1;
	    }
	}
    }
    return $result;
}

# @method getMin
# Return the smallest object in this deap.
# @param self This deap.
# @return The smallest object.
sub getMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return ${$self->{_array}}[2];
}

# @method getMax
# Return the largest object in this deap.
# @param self This deap.
# @return The largest object.
sub getMax
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    if ($self->{_count} == 1)
    {
	return ${$self->{_array}}[2];
    }
    else
    {
	return ${$self->{array}}[3];
    }
}

# @method insertMin
# Inserts the given object into the min-heap of this deap
# at the given position.
# @param self This deap.
# @param pos An index in the min-heap of this deap.
# @param obj An object.
sub insertMin
{
    my ($self, $pos, $obj) = @_;
    my $i = $pos;
    while ($i > 2 && ${$self->{_array}}[$i / 2] > $obj)
    {
	${$self->{_array}}[$i] = ${$self->{_array}}[$i / 2];
	use integer;
	$i /= 2;
    }
    ${$self->{_array}}[$i] = $obj;
}

# @method insertMax
# Inserts the given object into the max-heap of this deap
# at the given position.
# @param self This deap
# @param pos An index in the max-heap of this deap.
# @param obj An object.
sub insertMax
{
    my ($self, $pos, $obj) = @_;
    my $i = $pos;
    while ($i > 3 && ${$self->{_array}}[$i / 2] < $obj)
    {
	${$self->{_array}}[$i] = ${$self->{_array}}[$i / 2];
	use integer;
	$i /= 2;
    }
    ${$self->{_array}}[$i] = $obj;
}

# @method enqueue
# Enqueues the given object in this deap.
# @param self this deap.
# @param obj The object to enqueue.
sub enqueue
{
    my ($self, $obj) = @_;
    croak 'ContainerFull' if $self->{_count} == @{$self->{_array}} - 1;
    $self->{_count} += 1;
    if ($self->{_count} == 1)
    {
	${$self->{_array}}[2] = $obj;
    }
    else
    {
	my $i = $self->{_count} + 1;
	my $j = $self->dual($i);
	if (($i & mask($i)) != 0)
	{
	    if ($obj >= ${$self->{_array}}[$j])
	    {
		$self->insertMax($i, $obj);
	    }
	    else
	    {
		${$self->{_array}}[$i] = ${$self->{_array}}[$j];
		$self->insertMin($j, $obj);
	    }
	}
	else
	{
	    if ($obj < ${$self->{_array}}[$j])
	    {
		$self->insertMin($i, $obj);
	    }
	    else
	    {
		${$self->{_array}}[$i] = ${$self->{_array}}[$j];
		$self->insertMax($j, $obj);
	    }
	}
    }
}

# @method dequeueMin
# Dequeues and returns the smallest object in this deap.
sub dequeueMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = ${$self->{_array}}[2];
    my $last = ${$self->{_array}}[$self->{_count} + 1];
    $self->{_count} -= 1;
    if ($self->{_count} <= 1)
    {
	${$self->{_array}}[2] = $last;
    }
    else
    {
	my $i = 2;
	while (2 * $i < $self->{_count} + 2)
	{
	    my $child = 2 * $i;
	    if ($child + 1 < $self->{_count} + 2 &&
		${$self->{_array}}[$child + 1] < ${$self->{_array}}[$child])
	    {
		$child += 1;
	    }
	    ${$self->{_array}}[$i] = ${$self->{_array}}[$child];
	    $i = $child;
	}
	my $j = $self->dual($i);
	if ($last <= ${$self->{_array}}[$j])
	{
	    $self->insertMin($i, $last);
	}
	else
	{
	    ${$self->{_array}}[$i] = ${$self->{_array}}[$j];
	    $self->insertMax($j, $last);
	}
    }
    return $result;
}

# @method dequeueMax
# Dequeues and returns the largest object in this deap.
# @param self This deap.
# @return The largest object.
sub dequeueMax
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    if ($self->{_count} == 1)
    {
	$self->{_count} -=1;
	return ${$self->{_array}}[2];
    }
    elsif ($self->{_count} == 2)
    {
	$self->{_count} -= 1;
	return ${$self->{_array}}[3];
    }
    else
    {
	my $result = ${$self->{_array}}[3];
	my $last = ${$self->{_array}}[$self->{_count} + 1];
	$self->{_count} -= 1;
	my $i = 3;
	while (2 * $i < $self->{_count} + 2)
	{
	    my $child = 2 * $i;
	    if ($child + 1 < $self->{_count} + 2 &&
		    ${$self->{_array}}[$child + 1] > ${$self->{_array}}[$child])
	    {
		$child += 1;
	    }
	    ${$self->{_array}}[$i] = ${$self->{_array}}[$child];
	    $i = $child;
	}
	my $j = $self->dual($i);
	if ($last >= ${$self->{_array}}[$j])
	{
	    $self->insertMax($i, $last);
	}
	else
	{
	    ${$self->{_array}}[$i] = ${$self->{_array}}[$j];
	    $self->insertMin($j, $last);
	}
	return $result;
    }
}

# @method isFull
# IsFull predicate.
# @param self This deap.
# Returns true if this deap is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_array}} - 2;
}

# @method each
# Calls the given visitor function for each object in this deap
# (in no particular order).
# @param self This deap.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 2; $i <= $self->{_count} + 1; ++$i)
    {
	&$visitor(${$self->{_array}}[$i]);
    }
}

# @method iter
# Returns an iterator that enumerates the objects in this deap
# (in no particular order).
# @param self This deap.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $position = 2; # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if ($position < $self->{_count} + 2)
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
    printf "Deap test program.\n";
    my $depqueue = Opus10::Deap->new(256);
    Opus10::DoubleEndedPriorityQueue::test($depqueue);
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

=head1 MODULE C<Opus10::Deap>

=head2 CLASS C<Opus10::Deap>

=head3 Base Classes

=over

=item C<Opus10::DoubleEndedPriorityQueue>

=back

Double-end priority queue implemented as a double-end binary heap.

=head3 ATTRIBUTES

=over

=item C<_array>

The heap.

=back

=head3 METHOD C<dequeueMax>

Dequeues and returns the largest object in this deap.

=head4 Parameters

=over

=item C<self>

This deap.

=back

=head4 Return

The largest object.

=head3 METHOD C<dequeueMin>

Dequeues and returns the smallest object in this deap.

=head3 METHOD C<dual>

Returns the index of the dual of the given index.

=head4 Parameters

=over

=item C<self>

This deap.

=item C<i>

An index.

=back

=head4 Return

The dual of the given index.

=head3 METHOD C<each>

Calls the given visitor function for each object in this deap
(in no particular order).

=head4 Parameters

=over

=item C<self>

This deap.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<enqueue>

Enqueues the given object in this deap.

=head4 Parameters

=over

=item C<self>

this deap.

=item C<obj>

The object to enqueue.

=back

=head3 METHOD C<getMax>

Return the largest object in this deap.

=head4 Parameters

=over

=item C<self>

This deap.

=back

=head4 Return

The largest object.

=head3 METHOD C<getMin>

Return the smallest object in this deap.

=head4 Parameters

=over

=item C<self>

This deap.

=back

=head4 Return

The smallest object.

=head3 METHOD C<initialize>

Initializes this priority queue with the given size.

=head4 Parameters

=over

=item C<self>

This priority queue.

=item C<size>

The size of the binary heap.

=back

=head3 METHOD C<insertMax>

Inserts the given object into the max-heap of this deap
at the given position.

=head4 Parameters

=over

=item C<self>

This deap

=item C<pos>

An index in the max-heap of this deap.

=item C<obj>

An object.

=back

=head3 METHOD C<insertMin>

Inserts the given object into the min-heap of this deap
at the given position.

=head4 Parameters

=over

=item C<self>

This deap.

=item C<pos>

An index in the min-heap of this deap.

=item C<obj>

An object.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This deap.
Returns true if this deap is full.

=back

=head3 METHOD C<iter>

Returns an iterator that enumerates the objects in this deap
(in no particular order).

=head4 Parameters

=over

=item C<self>

This deap.

=back

=head4 Return

An iterator.

=head3 METHOD C<log2>

Returns ceil(log_2(i)).

=head4 Parameters

=over

=item C<i>

A non-negative integer.

=back

=head4 Return

ceil(log_2(i)).

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<mask>

Returns 2^(ceil(log_2(i))).

=head4 Parameters

=over

=item C<i>

A non-negative integer.

=back

=head4 Return

2^(ceil(log_2(i))).

=head3 METHOD C<purge>

Purges this deap.

=head4 Parameters

=over

=item C<self>

This deap.

=back

=cut

