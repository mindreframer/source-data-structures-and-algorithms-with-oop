#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: DequeAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DequeAsArray.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DequeAsArray
# Deque implemented using an array.
package Opus10::DequeAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::Queue;
use Opus10::Deque;
use Opus10::QueueAsArray;
our @ISA = qw(Opus10::QueueAsArray Opus10::Deque);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this deque with the given size.
# @param self This deque.
# @param size The size of the deque.
sub initialize
{
    my ($self, $size) = @_;
    $size = $size || 0;
    return if $self->isInitialized();
    $self->Opus10::QueueAsArray::initialize($size);
    $self->Opus10::Deque::initialize($size);
}

destructor qw(DESTROY);
#}>a

#{
# @method enqueueHead
# Enqueue the given item at the head of this deque.
# @param self This deque.
# @param obj The item to enqueue.
sub enqueueHead
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if $self->{_count} == @{$self->{_array}};
    if ($self->{_headPos} == 0)
    {
	$self->{_headPos} = @{$self->{_array}} - 1;
    }
    else
    {
	$self->{_headPos} -= 1;
    }
    ${$self->{_array}}[$self->{_headPos}] = $obj;
    $self->{_count} += 1;
}

# @method dequeueHead
# Dequeue and return the item at the head of this deque.
# @param self This deque.
# @return The item at the head of this deque.
alias_method dequeueHead =>
    qw(Opus10::QueueAsArray::dequeue);
#}>b

#{
# @method getTail
# Tail getter.
# @param self This deque.
# @return The item at the tail of this deque.
sub getTail
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return ${$self->{_array}}[$self->{_tailPos}];
}

# @method enqueueTail
# Enqueues the given item at the tail of this deque.
# @param self This deque.
# @param obj The item to enqueue.
alias_method enqueueTail =>
    qw(Opus10::QueueAsArray::enqueue);

# @method dequeueTail
# Dequeue and return the item at the tail of this deque.
# @param self This deque.
# @return The item at the tail of deque.
sub dequeueTail
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = ${$self->{_array}}[$self->{_tailPos}];
    ${$self->{_array}}[$self->{_tailPos}] = undef;
    if ($self->{_tailPos} == 0)
    {
	$self->{_tailPos} = @{$self->{_array}} - 1;
    }
    else
    {
	$self->{_tailPos} -= 1;
    }
    $self->{_count} -= 1;
    return $result;
}
#}>c

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "DequeAsArray test program.\n";
    my $deque1 = Opus10::DequeAsArray->new(10);
    Opus10::Queue::test($deque1);
    Opus10::Deque::test($deque1);
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

=head1 MODULE C<Opus10::DequeAsArray>

=head2 CLASS C<Opus10::DequeAsArray>

=head3 Base Classes

=over

=item C<Opus10::QueueAsArray>

=item C<Opus10::Deque>

=back

Deque implemented using an array.

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

Dequeue and return the item at the tail of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=back

=head4 Return

The item at the tail of deque.

=head3 METHOD C<enqueueHead>

Enqueue the given item at the head of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=item C<obj>

The item to enqueue.

=back

=head3 METHOD C<enqueueTail>

Enqueues the given item at the tail of this deque.

=head4 Parameters

=over

=item C<self>

This deque.

=item C<obj>

The item to enqueue.

=back

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

Initializes this deque with the given size.

=head4 Parameters

=over

=item C<self>

This deque.

=item C<size>

The size of the deque.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

