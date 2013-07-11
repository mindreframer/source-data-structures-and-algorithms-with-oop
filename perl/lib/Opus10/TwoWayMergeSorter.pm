#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: TwoWayMergeSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: TwoWayMergeSorter.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

#{
# @class Opus10::TwoWayMergeSorter
# A two-way merge sorter.
# @attr _tempArray A temporary array.
package Opus10::TwoWayMergeSorter;
use Carp;
use Opus10::Declarators;
use Opus10::Sorter;
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
    $self->declare qw(_tempArray);
    $self->{_tempArray} = undef;
}

destructor qw(DESTROY);
#}>a

#{
# @method merge
# Merges two sorted sub-arrays,
# array[left] ... array[middle] and
# array[middle + 1] ... array[right]
# using the temporary array.
# @param self This merge sorter.
# @param left The left index.
# @param middle The middle index.
# @param right The right index.
sub merge
{
    my ($self, $left, $middle, $right) = @_;
    my $i = $left;
    my $j = $left;
    my $k = $middle + 1;
    while ($j <= $middle && $k <= $right)
    {
	if (${$self->{_array}}[$j] < ${$self->{_array}}[$k])
	{
	    ${$self->{_tempArray}}[$i] = ${$self->{_array}}[$j];
	    $i += 1;
	    $j += 1;
	}
	else
	{
	    ${$self->{_tempArray}}[$i] = ${$self->{_array}}[$k];
	    $i += 1;
	    $k += 1;
	}
    }
    while ($j <= $middle)
    {
	${$self->{_tempArray}}[$i] = ${$self->{_array}}[$j];
	$i += 1;
	$j += 1;
    }
    for (my $i = $left; $i < $k; ++$i)
    {
	${$self->{_array}}[$i] = ${$self->{_tempArray}}[$i];
    }
}
#}>b

#{
# @method doSort
# Sorts the elements of the array.
# @param self This merge sorter.
sub doSort
{
    my ($self) = @_;
    tie(@{$self->{_tempArray}}, 'Opus10::Array', $self->{_n});
    $self->mergesort(0, $self->{_n} - 1);
    $self->{_tempArray} = undef;
}

# @method mergesort
# Recursively sorts the elements of the array
# between the left and right indices.
# @param self This merge sorter.
# @param left The left index.
# @param right The right index.
sub mergesort
{
    my ($self, $left, $right) = @_;
    if ($left < $right)
    {
	my $middle = int(($left + $right) / 2);
	$self->mergesort($left, $middle);
	$self->mergesort($middle + 1, $right);
	$self->merge($left, $middle, $right);
    }
}
#}>c

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "TwoWayMergeSorter test program.\n";
    Opus10::Sorter::test(
	Opus10::TwoWayMergeSorter->new(), 100, 123);
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

=head1 MODULE C<Opus10::TwoWayMergeSorter>

=head2 CLASS C<Opus10::TwoWayMergeSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

A two-way merge sorter.

=head3 ATTRIBUTES

=over

=item C<_tempArray>

A temporary array.

=back

=head3 METHOD C<doSort>

Sorts the elements of the array.

=head4 Parameters

=over

=item C<self>

This merge sorter.

=back

=head3 METHOD C<initialize>

Initializes this sorter.

=head4 Parameters

=over

=item C<self>

This sorter.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<merge>

Merges two sorted sub-arrays,
array[left] ... array[middle] and
array[middle + 1] ... array[right]
using the temporary array.

=head4 Parameters

=over

=item C<self>

This merge sorter.

=item C<left>

The left index.

=item C<middle>

The middle index.

=item C<right>

The right index.

=back

=head3 METHOD C<mergesort>

Recursively sorts the elements of the array
between the left and right indices.

=head4 Parameters

=over

=item C<self>

This merge sorter.

=item C<left>

The left index.

=item C<right>

The right index.

=back

=cut

