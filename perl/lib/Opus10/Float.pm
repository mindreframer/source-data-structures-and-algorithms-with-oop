#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: Float.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Float.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Float
# Used to wrap a float into an object.
package Opus10::Float;
use Opus10::Declarators;
use Opus10::Wrapper;
our @ISA = qw(Opus10::Wrapper);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this string.
# @param self This string.
# @param value A value.
sub initialize
{
    my ($self, $value) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($value);
}

destructor qw(DESTROY);

# @method compareTo
# Compares this float with the value in the given wrapper.
# @param self This wrapper.
# @param obj The given wrapper.
# @return A number less than zero if this float is less than
# the value in the given wrapper,
# zero if this float equals the value in the given wrapper, and
# a number greater than zero if this float is greater than
# the value in the given wrapper.
sub compareTo
{
    my ($self, $obj) = @_;
    return $self->{_value} <=> $obj->{_value};
}
#}>a

#{
use POSIX qw(frexp);

# @method hash
# Returns a hahs of this float.
# @param self This float.
# @return An integer.
sub hash
{
    my ($self) = @_;
    my ($mantissa, $exponent) = POSIX::frexp($self->{_value});
    return int((2 * abs($mantissa) - 1) * 2147483648);
}
#}>b

# @function main
# String test program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    printf "Float test program.\n";
    printf "57.0=0%o\n", Opus10::Float->new(57.0)->hash();
    printf "23.0=0%o\n", Opus10::Float->new(23.0)->hash();
    printf "0.75=0%o\n", Opus10::Float->new(0.75)->hash();
    printf "-123.0e6=0%o\n", Opus10::Float->new(-123.0e6)->hash();
    printf "-123.0e7=0%o\n", Opus10::Float->new(-123.0e7)->hash();
    printf "0.875=0%o\n", Opus10::Float->new(0.875)->hash();
    printf "14.0=0%o\n", Opus10::Float->new(14.0)->hash();
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Float>

=head2 CLASS C<Opus10::Float>

=head3 Base Classes

=over

=item C<Opus10::Wrapper>

=back

Used to wrap a float into an object.

=head3 METHOD C<compareTo>

Compares this float with the value in the given wrapper.

=head4 Parameters

=over

=item C<self>

This wrapper.

=item C<obj>

The given wrapper.

=back

=head4 Return

A number less than zero if this float is less than
the value in the given wrapper,
zero if this float equals the value in the given wrapper, and
a number greater than zero if this float is greater than
the value in the given wrapper.

=head3 METHOD C<hash>

Returns a hahs of this float.

=head4 Parameters

=over

=item C<self>

This float.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this string.

=head4 Parameters

=over

=item C<self>

This string.

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

=cut

