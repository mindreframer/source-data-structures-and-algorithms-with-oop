#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: PolynomialAsSortedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: PolynomialAsSortedList.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::PolynomialAsSortedList
# Polynomial implemented as a sorted list of terms.
# @attr _list The list.
package Opus10::PolynomialAsSortedList;
use Opus10::Declarators;
use Opus10::Polynomial;
use Opus10::SortedListAsLinkedList;
our @ISA = qw(Opus10::Polynomial);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this polynomial.
# @param self This polynomial.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_list);
    $self->{_list} = Opus10::SortedListAsLinkedList->new();
}

destructor qw(DESTROY);

delegate qw(addTerm _list insert);
delegate qw(each _list);
delegate qw(find _list);
delegate qw(withdraw _list);
#}>a

delegate qw(purge _list);
delegate qw(toString _list);

#{
# @method add
# Addition method.
# Returns the sum of this polynomial and the given polynomial.
# @param self This polynomial.
# @param poly A polynomial.
# @return The sum.
sub add
{
    my ($self, $poly) = @_;
    my $result = Opus10::PolynomialAsSortedList->new();
    my $p1 = $self->{_list}->iter();
    my $p2 = $poly->{_list}->iter();
    my $term1 = $p1->();
    my $term2 = $p2->();
    while (defined($term1) && defined($term2)) {
	if ($term1->getExponent() < $term2->getExponent()) {
	    $result->addTerm($term1->clone());
	    $term1 = $p1->();
	}
	elsif ($term1->getExponent() > $term2->getExponent()) {
	    $result->addTerm($term2->clone());
	    $term2 = $p2->();
	}
	else {
	    my $sum = $term1 + $term2;
	    if ($sum->getCoefficient() != 0) {
		$result->addTerm($sum);
	    }
	    $term1 = $p1->();
	    $term2 = $p2->();
	}
    }
    while (defined($term1)) {
	$result->addTerm($term1->clone());
	$term1 = $p1->();
    }
    while (defined($term2)) {
	$result->addTerm($term2->clone());
	$term2 = $p2->();
    }
    return $result;
}
#}>b

1;
__DATA__

=head1 MODULE C<Opus10::PolynomialAsSortedList>

=head2 CLASS C<Opus10::PolynomialAsSortedList>

=head3 Base Classes

=over

=item C<Opus10::Polynomial>

=back

Polynomial implemented as a sorted list of terms.

=head3 ATTRIBUTES

=over

=item C<_list>

The list.

=back

=head3 METHOD C<add>

Addition method.
Returns the sum of this polynomial and the given polynomial.

=head4 Parameters

=over

=item C<self>

This polynomial.

=item C<poly>

A polynomial.

=back

=head4 Return

The sum.

=head3 METHOD C<initialize>

Initializes this polynomial.

=head4 Parameters

=over

=item C<self>

This polynomial.

=back

=cut

