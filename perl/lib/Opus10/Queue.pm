#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Queue.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Queue.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Queue
# Abstract base class from which all queue classes are derived.
package Opus10::Queue;
use Opus10::Declarators;
use Opus10::Container;
our @ISA = qw(Opus10::Container);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this queue.
# @param self This queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method enqueue
# Enqueues the given item onto this queue.
# @param self This queue.
# @param item The item to enqueue.
abstract_method qw(enqueue);

# @method dequeue
# Dequeues and returns the item at the head of this queue.
# @param self This queue.
# @return The item at the head of the queue.
abstract_method qw(dequeue);

# @method head
# Returns the item at the head of this queue.
# @param self This queue.
# @return The item at the head of this queue.
abstract_method qw(getHead);
#}>a

use Opus10::Box;

# @function test
# Queue test function.
# @param queue The queue to test.
sub test
{
    my ($queue) = @_;
    printf "Queue test program.\n";
    for (my $i = 0; $i < 5; ++$i)
    {
	last if ($queue->isFull());
	$queue->enqueue(box($i));
    }
    printf "%s\n", $queue;
    printf "Using each\n";
    $queue->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $queue->iter();
    while (defined(my $item = $iter->()))
    {
	printf "%s\n", $item;
    }
    printf "getHead\n";
    printf "%s\n", $queue->getHead();
    printf "Dequeueing\n";
    while (!$queue->isEmpty())
    {
	printf "%s\n", $queue->dequeue();
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Queue>

=head2 CLASS C<Opus10::Queue>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all queue classes are derived.

=head3 METHOD C<dequeue>

Dequeues and returns the item at the head of this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head4 Return

The item at the head of the queue.

=head3 METHOD C<enqueue>

Enqueues the given item onto this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=item C<item>

The item to enqueue.

=back

=head3 METHOD C<head>

Returns the item at the head of this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head4 Return

The item at the head of this queue.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 FUNCTION C<test>

Queue test function.

=head4 Parameters

=over

=item C<queue>

The queue to test.

=back

=cut

