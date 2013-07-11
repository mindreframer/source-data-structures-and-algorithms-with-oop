#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: PriorityQueue.pm,v $
#   $Revision: 1.2 $
#
#   $Id: PriorityQueue.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::PriorityQueue
# Abstract base class from which all priority queue classes are derived.
package Opus10::PriorityQueue;
use Opus10::Declarators;
use Opus10::Container;
our @ISA = qw(Opus10::Container);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this priority queue.
# @param self This priority queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method enqueue
# Enqueues the given object in this priority queue.
# @param self This priority queue.
# @param obj An object
abstract_method qw(enqueue);

# @method getMin
# Returns the smallest object in this priority queue.
# @param self This priority queue.
# @return The smallest object in this priority queue.
abstract_method qw(getMin);

# @method dequeueMin
# Dequeues and returns the smallest object in this priority queue.
# @param self This priority queue.
# @return The smallest object in this priority queue.
abstract_method qw(dequeueMin);
#}>a

use Opus10::Box;

# @function test
# PriorityQueue test program.
# @param pqueue The priority queue to test.
sub test
{
    my ($pqueue) = @_;
    printf "PriorityQueue test program.\n";
    printf "%s\n", $pqueue;
    $pqueue->enqueue(box(3));
    $pqueue->enqueue(box(1));
    $pqueue->enqueue(box(4));
    $pqueue->enqueue(box(1));
    $pqueue->enqueue(box(5));
    $pqueue->enqueue(box(9));
    $pqueue->enqueue(box(2));
    $pqueue->enqueue(box(6));
    $pqueue->enqueue(box(5));
    $pqueue->enqueue(box(4));
    printf "%s\n", $pqueue;
    printf "Using each\n";
    $pqueue->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $pqueue->iter();
    while (defined(my $obj = $iter->()))
    {
	printf "%s\n", $obj;
    }
    printf "Dequeueing\n";
    while (!$pqueue->isEmpty())
    {
	my $obj = $pqueue->dequeueMin();
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::PriorityQueue>

=head2 CLASS C<Opus10::PriorityQueue>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all priority queue classes are derived.

=head3 METHOD C<dequeueMin>

Dequeues and returns the smallest object in this priority queue.

=head4 Parameters

=over

=item C<self>

This priority queue.

=back

=head4 Return

The smallest object in this priority queue.

=head3 METHOD C<enqueue>

Enqueues the given object in this priority queue.

=head4 Parameters

=over

=item C<self>

This priority queue.

=item C<obj>

An object

=back

=head3 METHOD C<getMin>

Returns the smallest object in this priority queue.

=head4 Parameters

=over

=item C<self>

This priority queue.

=back

=head4 Return

The smallest object in this priority queue.

=head3 METHOD C<initialize>

Initializes this priority queue.

=head4 Parameters

=over

=item C<self>

This priority queue.

=back

=head3 FUNCTION C<test>

PriorityQueue test program.

=head4 Parameters

=over

=item C<pqueue>

The priority queue to test.

=back

=cut

