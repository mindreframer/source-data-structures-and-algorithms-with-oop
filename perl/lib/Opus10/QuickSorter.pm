#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: QuickSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: QuickSorter.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::QuickSorter
# Abstract quick sorter base class.
package Opus10::QuickSorter;
use Carp;
use Opus10::Declarators;
use Opus10::Sorter;
use Opus10::StraightInsertionSorter;
our @ISA = qw(Opus10::Sorter);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this sorter.
# @param self This sorter.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method selectPivot
# Selects a pivot element between the given left and right indices.
# @param self This quick sorter.
# @param left The left index.
# @param right The right index.
abstract_method qw(selectPivot);
#}>a

#{
# Stop recursion when array size is less than or equal to CUTOFF.
use constant CUTOFF => 2; # minimum cut-off

# @method quicksort
# Recursively sorts the elements of the array
# between the left and right indices.
# @param self This quick sorter.
# @param left The left index.
# @param right The right index.
sub quicksort {
    my ($self, $left, $right) = @_;
    if ($right - $left + 1 > CUTOFF) {
	my $p = $self->selectPivot($left, $right);
	$self->swap($p, $right);
	my $pivot = ${$self->{_array}}[$right];
	my $i = $left;
	my $j = $right - 1;
	while (1) {
	    while ($i < $j && ${$self->{_array}}[$i] < $pivot) {
		$i += 1;
	    }
	    while ($i < $j && ${$self->{_array}}[$j] > $pivot) {
		$j -= 1;
	    }
	    last if $i >= $j;
	    $self->swap($i, $j);
	    $i += 1;
	    $j -= 1;
	}
	if (${$self->{_array}}[$i] > $pivot) {
	    $self->swap($i, $right);
	}
	if ($left < $i) {
	    $self->quicksort($left, $i - 1);
	}
	if ($right > $i) {
	    $self->quicksort($i + 1, $right);
	}
    }
}
#}>b

#{
# @method doSort
# Sorts the elements of the array.
# @param self This quick sorter.
sub doSort
{
    my ($self) = @_;
    $self->quicksort(0, $self->{_n} - 1);
    Opus10::StraightInsertionSorter->new()->sort(
	tied(@{$self->{_array}}));
}
#}>c

1;
__DATA__

=head1 MODULE C<Opus10::QuickSorter>

=head2 CLASS C<Opus10::QuickSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

Abstract quick sorter base class.

=head3 METHOD C<doSort>

Sorts the elements of the array.

=head4 Parameters

=over

=item C<self>

This quick sorter.

=back

=head3 METHOD C<initialize>

Initializes this sorter.

=head4 Parameters

=over

=item C<self>

This sorter.

=back

=head3 METHOD C<quicksort>

Recursively sorts the elements of the array
between the left and right indices.

=head4 Parameters

=over

=item C<self>

This quick sorter.

=item C<left>

The left index.

=item C<right>

The right index.

=back

=head3 METHOD C<selectPivot>

Selects a pivot element between the given left and right indices.

=head4 Parameters

=over

=item C<self>

This quick sorter.

=item C<left>

The left index.

=item C<right>

The right index.

=back

=cut

