#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: QueueAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: QueueAsArray.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::QueueAsArray
# Queue implemented using an array.
# @attr array The array.
# @attr headPos The position of the head of the queue.
# @attr tailPos The position of the tail of the queue.
package Opus10::QueueAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::Queue;
use Opus10::Array;
our @ISA = qw(Opus10::Queue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this queue with the given size.
# @param self This queue.
# @param size The size of the queue.
sub initialize
{
    my ($self, $size) = @_;
    $size = $size || 0;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array _headPos _tailPos);
    tie (@{$self->{_array}}, qw(Opus10::Array), $size);
    $self->{_headPos} = 0;
    $self->{_tailPos} = $size - 1;
}

destructor qw(DESTROY);

# @method purge
# Purges this queue.
# @param self This queue.
sub purge
{
    my ($self) = @_;
    while ($self->{_count} > 0)
    {
	${$self->{_array}}[$self->{_headPos}] = undef;
	$self->{_headPos} += 1;
	if ($self->{_headPos} == @{$self->{_array}})
	{
	    $self->{_headPos} = 0;
	}
	$self->{_count} -= 1;
    }
}
#}>a

#{
# @method getHead
# Returns the item at the head of this queue.
# @param self This queue.
# @return The item at the head of this queue.
sub getHead
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return ${$self->{_array}}[$self->{_headPos}];
}

# @method enqueue
# Enqueues the given item in this queue.
# @param self This queue.
# @param obj Item to enqueue.
sub enqueue
{
    my ($self, $item) = @_;
    croak 'ContainerFull'
	if $self->{_count} == @{$self->{_array}};
    $self->{_tailPos} += 1;
    if ($self->{_tailPos} == @{$self->{_array}})
    {
	$self->{_tailPos} = 0;
    }
    ${$self->{_array}}[$self->{_tailPos}] = $item;
    $self->{_count} += 1;
}

# @method dequeue
# Dequeues and returns the item at the head of this queue.
# @param self This queue.
# @return The item at the head of this queue.
sub dequeue
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = ${$self->{_array}}[$self->{_headPos}];
    ${$self->{_array}}[$self->{_headPos}] = undef;
    $self->{_headPos} += 1;
    if ($self->{_headPos} == @{$self->{_array}})
    {
	$self->{_headPos} = 0;
    }
    $self->{_count} -= 1;
    return $result;
}
#}>b

# @method isFull
# IsFull predicate.
# @param self This queue.
# @return True if this queue is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_array}};
}

# @method each
# Calls the given visitor function for each item in this queue.
# @param self This queue.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    my $pos = $self->{_headPos};
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	$visitor->(${$self->{_array}}[$pos]);
	$pos += 1;
	if ($pos == @{$self->{_array}})
	{
	    $pos = 0;
	}
    }
}

# @method iter
# Returns an iterator that enumerates the items in this queue.
# @param self This queue.
# @return An iterator
sub iter
{
    my ($self) = @_;
    my $position = 0;
    return
	sub
	{
	    my $result = undef;
	    if ($position < $self->{_count})
	    {
		$result = ${$self->{_array}}[
		    ($self->{_headPos} + $position) % @{$self->{_array}}];
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
    printf "QueueAsArray test program.\n";
    my $queue1 = Opus10::QueueAsArray->new(5);
    Opus10::Queue::test($queue1);
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

=head1 MODULE C<Opus10::QueueAsArray>

=head2 CLASS C<Opus10::QueueAsArray>

=head3 Base Classes

=over

=item C<Opus10::Queue>

=back

Queue implemented using an array.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

=item C<headPos>

The position of the head of the queue.

=item C<tailPos>

The position of the tail of the queue.

=back

=head3 METHOD C<dequeue>

Dequeues and returns the item at the head of this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head4 Return

The item at the head of this queue.

=head3 METHOD C<each>

Calls the given visitor function for each item in this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<enqueue>

Enqueues the given item in this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=item C<obj>

Item to enqueue.

=back

=head3 METHOD C<getHead>

Returns the item at the head of this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head4 Return

The item at the head of this queue.

=head3 METHOD C<initialize>

Initializes this queue with the given size.

=head4 Parameters

=over

=item C<self>

This queue.

=item C<size>

The size of the queue.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head4 Return

True if this queue is full.

=head3 METHOD C<iter>

Returns an iterator that enumerates the items in this queue.

=head4 Parameters

=over

=item C<self>

This queue.

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

Purges this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=cut

