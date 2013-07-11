#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: QueueAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: QueueAsLinkedList.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::QueueAsLinkedList
# Queue implemented as a linked list.
# @attr _list The linked list.
package Opus10::QueueAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Queue;
use Opus10::LinkedList;
our @ISA = qw(Opus10::Queue);

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
    $self->declare qw(_list);
    $self->{_list} = Opus10::LinkedList->new();
}

destructor qw(DESTROY);

# @method purge
# Purges this queue.
# @param self This queue.
sub purge
{
    my ($self) = @_;
    $self->{_list}->purge();
    $self->SUPER::purge();
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
    return $self->{_list}->getFirst();
}

# @method enqueue
# Enqueues the given item in this queue.
# @param self This queue.
# @param obj Item to enqueue.
sub enqueue
{
    my ($self, $obj) = @_;
    $self->{_list}->append($obj);
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
    my $result = $self->{_list}->getFirst();
    $self->{_list}->extract($result);
    $self->{_count} -= 1;
    return $result;
}
#}>b

# @method each
# Calls the given visitor function for each object in this queue.
# @param self This queue.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    $self->{_list}->each($visitor);
}

# @method iter
# Returns an iterator that enumerates the items in this queue.
# @param self This queue.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $position = $self->{_list}->getHead(); # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if (defined($position))
	    {
		$result = $position->getDatum();
		$position = $position->getSucc();
	    }
	    return $result;
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
    printf "QueueAsLinkedList test program.\n";
    my $queue2 = Opus10::QueueAsLinkedList->new();
    Opus10::Queue::test($queue2);
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

=head1 MODULE C<Opus10::QueueAsLinkedList>

=head2 CLASS C<Opus10::QueueAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::Queue>

=back

Queue implemented as a linked list.

=head3 ATTRIBUTES

=over

=item C<_list>

The linked list.

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

Calls the given visitor function for each object in this queue.

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

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<iter>

Returns an iterator that enumerates the items in this queue.

=head4 Parameters

=over

=item C<self>

This queue.

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

Purges this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=cut

