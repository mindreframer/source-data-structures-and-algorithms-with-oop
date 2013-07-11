#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: DoubleEndedPriorityQueue.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DoubleEndedPriorityQueue.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DoubleEndedPriorityQueue
# Abstract base class from which all double-ended priority queue classes
# are derived.
package Opus10::DoubleEndedPriorityQueue;
use Opus10::Declarators;
use Opus10::PriorityQueue;
our @ISA = qw(Opus10::PriorityQueue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this double-ended priority queue.
# @param self This double-ended priority queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method getMax
# Returns the largest object in this priority queue.
# @param self This double-ended priority queue.
# @return The largest object.
abstract_method qw(getMax);

# @method dequeueMax
# Dequeues and returns the largest object in this priority queue.
# @param self This double-ended priority queue.
# @return The largest object.
abstract_method qw(dequeueMax);
#}>a

use Opus10::Box;

# @function test
# DoubleEndedPriorityQueue test program.
# @param pqueue The double-ended priority queue to test.
sub test
{
    my ($pqueue) = @_;
    printf "DoubleEndedPriorityQueue test program.\n";
    Opus10::PriorityQueue::test($pqueue);
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
    while (!$pqueue->isEmpty())
    {
	my $obj = $pqueue->dequeueMax();
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::DoubleEndedPriorityQueue>

=head2 CLASS C<Opus10::DoubleEndedPriorityQueue>

=head3 Base Classes

=over

=item C<Opus10::PriorityQueue>

=back

Abstract base class from which all double-ended priority queue classes
are derived.

=head3 METHOD C<dequeueMax>

Dequeues and returns the largest object in this priority queue.

=head4 Parameters

=over

=item C<self>

This double-ended priority queue.

=back

=head4 Return

The largest object.

=head3 METHOD C<getMax>

Returns the largest object in this priority queue.

=head4 Parameters

=over

=item C<self>

This double-ended priority queue.

=back

=head4 Return

The largest object.

=head3 METHOD C<initialize>

Initializes this double-ended priority queue.

=head4 Parameters

=over

=item C<self>

This double-ended priority queue.

=back

=head3 FUNCTION C<test>

DoubleEndedPriorityQueue test program.

=head4 Parameters

=over

=item C<pqueue>

The double-ended priority queue to test.

=back

=cut

