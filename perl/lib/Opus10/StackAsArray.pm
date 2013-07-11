#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: StackAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: StackAsArray.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::StackAsArray
# Stack implemented using an array.
# @attr _array The array.
package Opus10::StackAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::Stack;
use Opus10::Array;
our @ISA = qw(Opus10::Stack);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this stack with the given size.
# @param size The size of the stack. Optional.
sub initialize
{
    my ($self, $size) = @_;
    $size = $size || 0;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array);
    tie (@{$self->{_array}}, qw(Opus10::Array), $size);
}

destructor qw(DESTROY);

# @method purge
# Purges this stack.
# @param self This stack.
sub purge
{
    my ($self) = @_;
    while ($self->{_count} > 0)
    {
	$self->{_count} -= 1;
	${$self->{_array}}[$self->{_count}] = undef;
    }
}
#}>a

#{
# @method push
# Pushes the given item onto this stack.
# @param self This stack.
# @param obj The item to push.
sub push
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if $self->{_count} == @{$self->{_array}};
    ${$self->{_array}}[$self->{_count}] = $obj;
    $self->{_count} += 1;
}

# @method pop
# Pops and returns the top item of this stack.
# @param self This stack.
# @return The top item.
sub pop
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    $self->{_count} -= 1;
    my $result = ${$self->{_array}}[$self->{_count}];
    ${$self->{_array}}[$self->{_count}] = undef;
    return $result;
}

# @method getTop
# Returns the top item of this stack.
# @param self This stack.
# @return The top item.
sub getTop
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return ${$self->{_array}}[$self->{_count} - 1];
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
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	$visitor->(${$self->{_array}}[$i]);
    }
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
    my $i = 0;
    return
	sub
	{
	    my $result = undef;
	    if ($i < $self->{_count})
	    {
		$result = ${$self->{_array}}[$i];
		$i = $i + 1;
	    }
	    return $result;
	};
}
#}>d

# @method isFull
# IsFull predicate.
# @param self This stack.
# @return True if this stack is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_array}};
}

# @method compareTo
# Compares this stack with the given stack.
# @param self This stack.
# @param obj The given stack.
# @return A negative number if this stack is less than the given stack,
# zero if this stack equals the given stack, and
# a positive number if this stack is greater than the given stack.
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
    printf "StackAsArray test program.\n";
    my $stack1 = Opus10::StackAsArray->new(5);
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

=head1 MODULE C<Opus10::StackAsArray>

=head2 CLASS C<Opus10::StackAsArray>

=head3 Base Classes

=over

=item C<Opus10::Stack>

=back

Stack implemented using an array.

=head3 ATTRIBUTES

=over

=item C<_array>

The array.

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
a positive number if this stack is greater than the given stack.

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

Returns the top item of this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

The top item.

=head3 METHOD C<initialize>

Initializes this stack with the given size.

=head4 Parameters

=over

=item C<size>

The size of the stack. Optional.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

True if this stack is full.

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

Pops and returns the top item of this stack.

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

Pushes the given item onto this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=item C<obj>

The item to push.

=back

=cut

