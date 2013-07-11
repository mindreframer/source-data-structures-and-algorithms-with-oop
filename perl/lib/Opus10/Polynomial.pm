#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Polynomial.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Polynomial.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Polynomial
# Abstract base class from which all polynomial classes are derived.
package Opus10::Polynomial;
use Opus10::Declarators;
use Opus10::Container;
our @ISA = qw(Opus10::Container);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this term.
# @param self This term.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method addTerm
# Adds the given term to this polynomial.
# @param self This polynomial.
# @param term The term to add.
abstract_method qw(addTerm);

# Addition operator.
# Returns the sum of this polynomial and the given polynomial.
# @param poly A polynomial.
abstract_method qw(add);

use overload
    '+' => qw(add),
    fallback => 1;
#}>a

#{
# @method differentiate
# Differentiates this polynomial.
# @param self This polynomial.
sub differentiate
{
    my ($self) = @_;
    $self->each(
	sub
	{
	    my ($term) = @_;
	    $term->differentiate();
	}
    );
    my $zeroTerm = $self->find(
	Opus10::Polynomial::Term->new(0, 0));
    if (defined($zeroTerm))
    {
	$self->withdraw($zeroTerm);
    }
}
#}>e

#{
# @class Opus10::Polynomial::Term
# Represents a term in a polynomial.
# @attr _coefficient The coefficient of the term.
# @attr _exponent The exponent of the term
package Opus10::Polynomial::Term;
use Carp;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our @VERSION = 1.00;

#{
# @method initialize
# Initializes this term.
# @param self This term.
# @param coefficient A coefficient value.
# @param exponent An exponent value.
sub initialize
{
    my ($self, $coefficient, $exponent) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_coefficient _exponent);
    $self->{_coefficient} = $coefficient;
    $self->{_exponent} = $exponent;
}

destructor qw(DESTROY);

attr_reader qw(_coefficient);
attr_reader qw(_exponent);
#}>b

#{
# @method compareTo
# Compares this term with given term.
# @param self This term.
# @param term The term to compare.
# @return A number less than zero if this term precedes the given term,
# zero if this term equals the given term, and
# a number greater than zero if this term follows the given term.
sub compareTo
{
    my ($self, $term) = @_;
    croak 'TypeError'
	if !$term->isa(__PACKAGE__);
    if ($self->{_exponent} == $term->{_exponent})
    {
	return $self->{_coefficient} <=> $term->{_coefficient};
    }
    else
    {
	return $self->{_exponent} <=> $term->{_exponent};
    }
}

# @method differentiate
# Differentiates this term.
# @param self This term.
sub differentiate
{
    my ($self) = @_;
    if ($self->{_exponent} > 0)
    {
	$self->{_coefficient} =
	    $self->{_coefficient} * $self->{_exponent};
	$self->{_exponent} = $self->{_exponent} - 1;
    }
    else
    {
	$self->{_coefficient} = 0;
    }
}
#}>c

#{
# @method clone
# Returns a clone of this term.
# @param self This term.
# @return A clone of this term.
sub clone
{
    my ($self) = @_;
    my $t = $self->{_coefficient};
    my $e = $self->{_exponent};
    return Opus10::Polynomial::Term->new($t, $e);
}

# @method add
# Addition method.
# Returns the sum of this term and the given term.
# @param self This term.
# @param term A term.
# @return The sum.
sub add
{
    my ($self, $term) = @_;
    croak 'DomainError'
	if $self->{_exponent} != $term->{_exponent};
    my $t = $self->{_coefficient} + $term->{_coefficient};
    my $e = $self->{_exponent};
    return Opus10::Polynomial::Term->new($t, $e);
}

use overload
    '+' => qw(add),
    fallback => 1;
#}>d

# @method toString
# Returns a string representation of this term.
# @param self This term.
# @return A string.
sub toString
{
    my ($self) = @_;
    return sprintf("%gx^%g", $self->{_coefficient}, $self->{_exponent});
}

1;
__DATA__

=head1 MODULE C<Opus10::Polynomial>

=head2 CLASS C<Opus10::Polynomial>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all polynomial classes are derived.

=head3 METHOD C<addTerm>

Adds the given term to this polynomial.

=head4 Parameters

=over

=item C<self>

This polynomial.

=item C<term>

The term to add.

=item C<poly>

A polynomial.

=back

=head3 METHOD C<differentiate>

Differentiates this polynomial.

=head4 Parameters

=over

=item C<self>

This polynomial.

=back

=head3 METHOD C<initialize>

Initializes this term.

=head4 Parameters

=over

=item C<self>

This term.

=back

=head2 CLASS C<Opus10::Polynomial::Term>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Represents a term in a polynomial.

=head3 ATTRIBUTES

=over

=item C<_coefficient>

The coefficient of the term.

=item C<_exponent>

The exponent of the term

=back

=head3 METHOD C<add>

Addition method.
Returns the sum of this term and the given term.

=head4 Parameters

=over

=item C<self>

This term.

=item C<term>

A term.

=back

=head4 Return

The sum.

=head3 METHOD C<clone>

Returns a clone of this term.

=head4 Parameters

=over

=item C<self>

This term.

=back

=head4 Return

A clone of this term.

=head3 METHOD C<compareTo>

Compares this term with given term.

=head4 Parameters

=over

=item C<self>

This term.

=item C<term>

The term to compare.

=back

=head4 Return

A number less than zero if this term precedes the given term,
zero if this term equals the given term, and
a number greater than zero if this term follows the given term.

=head3 METHOD C<differentiate>

Differentiates this term.

=head4 Parameters

=over

=item C<self>

This term.

=back

=head3 METHOD C<initialize>

Initializes this term.

=head4 Parameters

=over

=item C<self>

This term.

=item C<coefficient>

A coefficient value.

=item C<exponent>

An exponent value.

=back

=head3 METHOD C<toString>

Returns a string representation of this term.

=head4 Parameters

=over

=item C<self>

This term.

=back

=head4 Return

A string.

=cut

