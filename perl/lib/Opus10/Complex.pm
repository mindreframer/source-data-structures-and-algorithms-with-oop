#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Complex.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Complex.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Complex
# A complex number class.
# @attr _real The real part of the complex number.
# @attr _imag The imaginary part of the complex number.
package Opus10::Complex;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this a complex number
# with the given real and imaginary parts.
# @param self This complex number.
# @param real The real part.
# @param image The imaginary part.
sub initialize
{
    my ($self, $real, $imag) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_real _imag);
    $self->{_real} = $real;
    $self->{_imag} = $imag;
}

destructor qw(DESTROY);
#}>a

#{
# The real part of this complex number.
attr_accessor qw(_real);

# The imaginary part of this complex number.
attr_accessor qw(_imag);
#}>b

#{
# @method getR
# The radius of this complex number.
# @param self This complex number.
sub getR
{
    my ($self) = @_;
    return sqrt($self->{_real} * $self->{_real} +
		$self->{_imag} * $self->{_imag});
}

# @method setR
# Sets the radius of this complex number to the given value.
# @param self This complex number.
# @param value A radius.
sub setR
{
    my ($self, $value) = @_;
    my $tmp = $self->getTheta();
    $self->{_real} = $value * cos($tmp);
    $self->{_imag} = $value * sin($tmp);
}

# @method getTheta
# The angle of this complex number.
# @param self This complex number.
sub getTheta
{
    my ($self) = @_;
    return atan2($self->{_imag}, $self->{_real});
}

# @method setTheta
# Sets the angle of this complex number to the given value.
# @param self This complex number.
# @param value A angle.
sub setTheta
{
    my ($self, $value) = @_;
    my $tmp = $self->getR();
    $self->{_real} = $tmp * cos($value);
    $self->{_imag} = $tmp * sin($value);
}
#}>c

#{
# @method plus
# Addition operator.
# Returns the sum of this complex number
# and the given complex number.
# @param self This complex number.
# @param c A complex number.
# @return The sum.
sub plus
{
    my ($self, $c) = @_;
    return Opus10::Complex->new(
	$self->getReal() + $c->getReal(),
	$self->getImag() + $c->getImag());
}

# @method minus
# Subtraction operator.
# Returns the difference of this complex number
# and the given complex number.
# @param self This complex number.
# @param c A complex number.
# @return The difference.
sub minus
{
    my ($self, $c) = @_;
    return Opus10::Complex->new(
	$self->getReal() - $c->getReal(),
	$self->getImag() - $c->getImag());
}

# @method negate
# Unary minus.
# Returns the negative value of this complex number.
# @param self This complex number.
# @return The negation.
sub negate
{
    my ($self) = @_;
    return Opus10::Complex->new(
	-$self->getReal(),
	-$self->getImag());
}
#}>d

#{
# @method times
# Multiplication operator.
# Returns the product of this complex number and the given complex number.
# @param self This complex number.
# @param c A complex number.
# @return The product.
sub times
{
    my ($self, $c) = @_;
    return Opus10::Complex->new(
	$self->getReal() * $c->getReal() -
	    $self->getImag() * $c->getImag(),
	$self->getReal() * $c->getImag() +
	    $self->getImag() * $c->getReal());
}

# @method div
# Division operator.
# Returns the quotient of this complex number
# and the given complex number.
# @param self This complex number.
# @param c A complex number.
# @return The quotient.
sub div
{
    my ($self, $c) = @_;
    my $denom = $c->getReal() * $c->getReal() -
		$c->getImag() * $c->getImag();
    return Opus10::Complex->new(
	($self->getReal() * $c->getReal() -
	    $self->getImag() * $c->getImag()) / $denom,
	($self->getImag() * $c->getReal() -
		$self->getReal() * $c->getImag()) / $denom);
}
#}>e

# @method toString
# Returns a string representation of this complex number.
# @param self This complex number.
# @return A string.
sub toString
{
    my ($self) = @_;
    return sprintf("%g+%gi", $self->getReal(), $self->getImag());
}

#{
# @function order
# Returns the first and second arguments in the order determined by the third.
# @param x A value.
# @param y A value.
# @param reversed Indicates x and y are reversed.
# @return (y,x) if reversed else return (x,y).
sub order
{
    my ($x, $y, $reversed) = @_;
    return $reversed ? ($y, $x) : ($x, $y);
}

use overload
    '+' => sub
	    {
		my ($c, $d) = order(@_);
		return $c->plus($d);
	    },
    '-' => sub
	    {
		my ($c, $d) = order(@_);
		return $c->minus($d);
	    },
    '*' => sub
	    {
		my ($c, $d) = order(@_);
		return $c->times($d);
	    },
    '/' => sub
	    {
		my ($c, $d) = order(@_);
		return $c->div($d);
	    },
    'neg' => qw(negate),
    '""' => qw(toString),
    fallback => 1;
#}>f

use constant PI => atan2(0,-1);

#{
# @function main
# Complex test program.
# @param args Command-line arguments.
sub main
{
    my (@args) = @_;
#[
    printf "Complex test program.\n";
#]
    my $c = Opus10::Complex->new(0, 0);
    printf "%s\n", $c;
    $c->setReal(1);
    $c->setImag(2);
    printf "%s\n", $c;
    $c->setTheta(PI/2);
    $c->setR(50);
    printf "%s\n", $c;
    $c = Opus10::Complex->new(1, 2);
    my $d = Opus10::Complex->new(3, 4);
    printf "%s\n", $c;
    printf "%s\n", $d;
    printf "%s\n", $c+$d;
    printf "%s\n", $c-$d;
    printf "%s\n", $c*$d;
    printf "%s\n", $c/$d;
    printf "%s\n", -$c;
    return 0
}
#}>g

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Complex>

=head2 CLASS C<Opus10::Complex>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

A complex number class.

=head3 ATTRIBUTES

=over

=item C<_imag>

The imaginary part of the complex number.

=item C<_real>

The real part of the complex number.

=back

=head3 METHOD C<div>

Division operator.
Returns the quotient of this complex number
and the given complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<c>

A complex number.

=back

=head4 Return

The quotient.

=head3 METHOD C<getR>

The radius of this complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=back

=head3 METHOD C<getTheta>

The angle of this complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=back

=head3 METHOD C<initialize>

Initializes this a complex number
with the given real and imaginary parts.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<real>

The real part.

=item C<image>

The imaginary part.

=back

=head3 FUNCTION C<main>

Complex test program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head3 METHOD C<minus>

Subtraction operator.
Returns the difference of this complex number
and the given complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<c>

A complex number.

=back

=head4 Return

The difference.

=head3 METHOD C<negate>

Unary minus.
Returns the negative value of this complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=back

=head4 Return

The negation.

=head3 FUNCTION C<order>

Returns the first and second arguments in the order determined by the third.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=item C<reversed>

Indicates x and y are reversed.

=back

=head4 Return

(y,x) if reversed else return (x,y).

=head3 METHOD C<plus>

Addition operator.
Returns the sum of this complex number
and the given complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<c>

A complex number.

=back

=head4 Return

The sum.

=head3 METHOD C<setR>

Sets the radius of this complex number to the given value.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<value>

A radius.

=back

=head3 METHOD C<setTheta>

Sets the angle of this complex number to the given value.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<value>

A angle.

=back

=head3 METHOD C<times>

Multiplication operator.
Returns the product of this complex number and the given complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=item C<c>

A complex number.

=back

=head4 Return

The product.

=head3 METHOD C<toString>

Returns a string representation of this complex number.

=head4 Parameters

=over

=item C<self>

This complex number.

=back

=head4 Return

A string.

=cut

