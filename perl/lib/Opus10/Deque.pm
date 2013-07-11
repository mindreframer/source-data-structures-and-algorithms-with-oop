#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Deque.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Deque.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Deque
# Abstract base class from which deque classes are derived.
package Opus10::Deque;
use Opus10::Declarators;
use Opus10::Queue;
our @ISA = qw(Opus10::Queue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this deque.
# @param self This deque.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method enqueueHead
# Enqueue the given item at the head of this deque.
# @param self This deque.
# @param obj Item to enqueue.
abstract_method qw(enqueueHead);

# @method dequeueHead
# Dequeues and returns the item from the head of this deque.
# @param self This deque.
# @return The item at the head of this deque.
alias_method dequeueHead =>
    qw(Opus10::Queue::dequeue);

# @method getHead
# Head getter.
# @param self This deque.
# @return The item at the head of this deque.
abstract_method qw(getHead);

# @method enqueueTail
# Enqueue the given item at the tail of this deque.
# @param self This deque.
# @param obj Item to enqueue.
alias_method enqueueTail =>
    qw(Opus10::Queue::enqueue);

# @method dequeueTail
# Dequeues and returns the item from the tail of this deque.
# @param self This deque.
# @return The item at the tail of this deque.
abstract_method qw(dequeueTail);

# @method getTail
# Tail getter.
# @param self This deque.
# @return The item at the tail of this deque.
abstract_method qw(getTail);

# @method enqueueTail
# Enqueue the given item at the tail of this deque.
# @param self This deque.
# @param obj Item to enqueue.

# @method dequeueHead
# Dequeues and returns the item from the head of this deque.
# @param self This deque.
# @return The item at the head of this deque.
#}>a

use Opus10::Box;

# @function test
# Deque test function.
# @param deque The deque to test.
sub test
{
    my ($deque) = @_;
    printf "Deque test program.\n";
    for (my $i = 0; $i <= 5; ++$i)
    {
	$deque->enqueueHead(box($i)) if !$deque->isFull();
	$deque->enqueueTail(box($i)) if !$deque->isFull();
    }
    printf "%s\n", $deque;
    printf "getHead = %s\n", $deque->getHead();
    printf "getTail = %s\n", $deque->getTail();
    while (!$deque->isEmpty())
    {
	my $obj = $deque->dequeueHead();
	printf "%s\n", $obj;
	last if $deque->isEmpty();
	$obj = $deque->dequeueTail();
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Deque>

=head2 CLASS C<Opus10::Deque>

=head3 Base Classes

=over

=item C<Opus10::Queue>

=back

Abstract base class from which deque classes are derived.

=head3 METHOD C<dequeueHead>

Dequeues and returns the item from the head of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the head of this deque.

=head3 METHOD C<dequeueTail>

Dequeues and returns the item from the tail of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the tail of this deque.

=head3 METHOD C<enqueueHead>

Enqueue the given item at the head of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=item C<obj>

Item to enqueue.

=back

=head3 METHOD C<enqueueTail>

Enqueue the given item at the tail of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=item C<obj>

Item to enqueue.

=back

=head3 METHOD C<getHead>

Head getter.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the head of this deque.

=head3 METHOD C<getTail>

Tail getter.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the tail of this deque.

=head3 METHOD C<initialize>

Initializes this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head3 FUNCTION C<test>

Deque test function.

=head4 Parameters

=over

=item C<deque>

The deque to test.

=back

=cut

