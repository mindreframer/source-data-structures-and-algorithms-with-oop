#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: StackAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: StackAsLinkedList.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::StackAsLinkedList
# Stack implemented using a linked list.
# @attr _list The linked list.
package Opus10::StackAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Stack;
use Opus10::LinkedList;
our @ISA = qw(Opus10::Stack);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this stack.
# @param self This stack.
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
# Purges this stack.
# @param self This stack.
sub purge
{
    my ($self) = @_;
    $self->{_list}->purge();
}
#}>a

#{
# @method push
# Pushes the given item on to this stack.
# @param self This stack.
# #param obj The item to push.
sub push
{
    my ($self, $obj) = @_;
    $self->{_list}->prepend($obj);
    $self->{_count} += 1;
}

# @method pop
# Pops and returns the top item in this stack.
# @param self This stack.
# @return The top item.
sub pop
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $result = $self->{_list}->getFirst();
    $self->{_list}->extract($result);
    $self->{_count} -= 1;
    return $result;
}

# @method getTop
# Returns the top item in this stack.
# @param self This stack.
# @return The top item.
sub getTop
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return $self->{_list}->getFirst();
}
#}>b

#{
# @method each
# Calls the given visitor function for each item in this stack.
# @param self This stack.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    $self->{_list}->each($visitor);
}
#}>c

#{
# @method iter
# Returns an iterator that enumerates the items in this stack.
# @param self This stack.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $position = $self->{_list}->getHead();
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
	};
}
#}>d

# @method compareTo
# Compares this stack with the given stack.
# @param self This stack.
# @param obj The given stack.
# @return A negative number if this stack is less than the given stack,
# zero if this stack equals the given stack, and
# a number greater than zero if this stack is greater than the given stack.
sub compareTo
{
    my ($self, $obj) = @_;
    croak 'ArgumentError' if !$self->isa(ref($obj));
    croak 'NotImplementedError';
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "StackAsLinkedList test program.\n";
    my $stack1 = Opus10::StackAsLinkedList->new(5);
    Opus10::Stack::test($stack1);
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

=head1 MODULE C<Opus10::StackAsLinkedList>

=head2 CLASS C<Opus10::StackAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::Stack>

=back

Stack implemented using a linked list.

=head3 ATTRIBUTES

=over

=item C<_list>

The linked list.

=back

=head3 METHOD C<compareTo>

Compares this stack with the given stack.

=head4 Parameters

=over

=item C<self>

This stack.

=item C<obj>

The given stack.

=back

=head4 Return

A negative number if this stack is less than the given stack,
zero if this stack equals the given stack, and
a number greater than zero if this stack is greater than the given stack.

=head3 METHOD C<each>

Calls the given visitor function for each item in this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<getTop>

Returns the top item in this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

The top item.

=head3 METHOD C<initialize>

Initializes this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head3 METHOD C<iter>

Returns an iterator that enumerates the items in this stack.

=head4 Parameters

=over

=item C<self>

This stack.

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

=head3 METHOD C<pop>

Pops and returns the top item in this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

The top item.

=head3 METHOD C<purge>

Purges this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head3 METHOD C<push>

Pushes the given item on to this stack.

=head4 Parameters

=over

=item C<self>

This stack.
#param obj The item to push.

=back

=cut

