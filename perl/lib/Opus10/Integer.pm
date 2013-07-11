#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: Integer.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Integer.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Integer
# Used to wrap an integer into an object.
package Opus10::Integer;
use Opus10::Declarators;
use Opus10::Wrapper;
our @ISA = qw(Opus10::Wrapper);

#}>head

our $VERSION = 1.00;

#{
use constant MAXINT => 2147483647;

# @method initialize
# Initializes this integer.
# @param self This integer.
# @param value A value.
sub initialize
{
    my ($self, $value) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($value);
}

destructor qw(DESTROY);

# @method compareTo
# Compares this integer with the value in the given wrapper.
# @param self This wrapper.
# @param obj The given wrapper.
# @return A number less than zero if this integer is less than
# the value in the given wrapper,
# zero if this integer equals the value in the given wrapper, and
# a number greater than zero if this integer is greater than
# the value in the given wrapper.
sub compareTo
{
    my ($self, $obj) = @_;
    return $self->{_value} <=> $obj->{_value};
}
#}>a

#{
# @method hash
# Returns a hash of this integer.
# @param self This integer.
# @return An integer.
sub hash
{
    my ($self) = @_;
    return $self->{_value} & (~0 >> 1);
}
#}>b

# @method add
# Returns the sum of this and the given integer.
# @param self This integer.
# @param obj The given integer.
# @return The sum.
sub add
{
    my ($self, $obj) = @_;
    my $sum = $self->{_value} + $obj->{_value};
    return Opus10::Integer->new($sum);
}

# @method mul
# Returns the product of this and the given integer.
# @param self This integer.
# @param obj The given integer.
# @return The product.
sub mul
{
    my ($self, $obj) = @_;
    my $sum = $self->{_value} * $obj->{_value};
    return Opus10::Integer->new($sum);
}

use overload
    '+' => qw(add),
    '*' => qw(mul),
    fallback => 1;

# @function main
# String test program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    printf "Integer test program.\n";
    printf "57=%d\n", Opus10::Integer->new(57)->hash();
    printf "-123=%d\n", Opus10::Integer->new(-123)->hash();
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Integer>

=head2 CLASS C<Opus10::Integer>

=head3 Base Classes

=over

=item C<Opus10::Wrapper>

=back

Used to wrap an integer into an object.

=head3 METHOD C<add>

Returns the sum of this and the given integer.

=head4 Parameters

=over

=item C<self>

This integer.

=item C<obj>

The given integer.

=back

=head4 Return

The sum.

=head3 METHOD C<compareTo>

Compares this integer with the value in the given wrapper.

=head4 Parameters

=over

=item C<self>

This wrapper.

=item C<obj>

The given wrapper.

=back

=head4 Return

A number less than zero if this integer is less than
the value in the given wrapper,
zero if this integer equals the value in the given wrapper, and
a number greater than zero if this integer is greater than
the value in the given wrapper.

=head3 METHOD C<hash>

Returns a hash of this integer.

=head4 Parameters

=over

=item C<self>

This integer.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this integer.

=head4 Parameters

=over

=item C<self>

This integer.

=item C<value>

A value.

=back

=head3 FUNCTION C<main>

String test program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<mul>

Returns the product of this and the given integer.

=head4 Parameters

=over

=item C<self>

This integer.

=item C<obj>

The given integer.

=back

=head4 Return

The product.

=cut

