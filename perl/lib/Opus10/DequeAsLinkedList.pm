#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: DequeAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DequeAsLinkedList.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DequeAsLinkedList
# Deque implemented as a linked list.
# @attr list The linked list.
package Opus10::DequeAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Deque;
use Opus10::QueueAsLinkedList;
our @ISA = qw(Opus10::QueueAsLinkedList Opus10::Deque);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this Deque.
# @param self This Deque.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->Opus10::QueueAsLinkedList::initialize();
    $self->Opus10::Deque::initialize();
}

destructor qw(DESTROY);

# @method enqueueHead
# Enqueue the given item at the head of this deque.
# @param self This deque.
# @param obj Item to enqueue.
sub enqueueHead
{
    my ($self, $obj) = @_;
    $self->{_list}->prepend($obj);
    $self->{_count} += 1;
}

# @method dequeueHead
# Dequeue and return the item at the head of this deque.
# @param self This deque.
# @return The item at the head of this deque.
alias_method dequeueHead =>
    qw(Opus10::QueueAsLinkedList::dequeue);
#}>a

#{
# @method getTail
# Returns the item at the tail of this Deque.
# @param self This Deque.
# @return The item at the tail of this Deque.
sub getTail
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return $self->{_list}->getLast();
}

# @method enqueueTail
# Enqueues the given item at the tail of this Deque.
# @param self This Deque.
# @param obj Item to enqueue.
alias_method enqueueTail =>
    qw(Opus10::QueueAsLinkedList::enqueue);

# @method dequeueTail
# Dequeues and returns the item at the tail of this Deque.
# @param self This Deque.
# @return The item at the tail of this Deque.
sub dequeueTail
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = $self->{_list}->getLast();
    $self->{_list}->extract($result);
    $self->{_count} -= 1;
    return $result;
}
#}>b

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "DequeAsLinkedList test program.\n";
    my $deque2 = Opus10::DequeAsLinkedList->new();
    Opus10::Queue::test($deque2);
    Opus10::Deque::test($deque2);
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

=head1 MODULE C<Opus10::DequeAsLinkedList>

=head2 CLASS C<Opus10::DequeAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::QueueAsLinkedList>

=item C<Opus10::Deque>

=back

Deque implemented as a linked list.

=head3 ATTRIBUTES

=over

=item C<list>

The linked list.

=back

=head3 METHOD C<dequeueHead>

Dequeue and return the item at the head of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the head of this deque.

=head3 METHOD C<dequeueTail>

Dequeues and returns the item at the tail of this Deque.

=head4 Parameters

=over

=item C<self>

This Deque.

=back

=head4 Return

The item at the tail of this Deque.

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

Enqueues the given item at the tail of this Deque.

=head4 Parameters

=over

=item C<self>

This Deque.

=item C<obj>

Item to enqueue.

=back

=head3 METHOD C<getTail>

Returns the item at the tail of this Deque.

=head4 Parameters

=over

=item C<self>

This Deque.

=back

=head4 Return

The item at the tail of this Deque.

=head3 METHOD C<initialize>

Initializes this Deque.

=head4 Parameters

=over

=item C<self>

This Deque.

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

=cut

