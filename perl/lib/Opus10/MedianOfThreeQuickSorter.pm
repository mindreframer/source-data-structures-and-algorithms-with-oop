#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MedianOfThreeQuickSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MedianOfThreeQuickSorter.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MedianOfThreeQuickSorter
# Median-of-three quick sorter.
package Opus10::MedianOfThreeQuickSorter;
use Carp;
use Opus10::Declarators;
use Opus10::QuickSorter;
our @ISA = qw(Opus10::QuickSorter);

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
# Sorts the left, middle, and right array element
# and returns the position of the middle element as the pivot.
# @param self This quick sorter.
# @param left Index of left element.
# @param right Index of right element.
sub selectPivot
{
    my ($self, $left, $right) = @_;
    my $middle = int(($left + $right) / 2);
    if (${$self->{_array}}[$left] > ${$self->{_array}}[$middle])
    {
	$self->swap($left, $middle);
    }
    if (${$self->{_array}}[$left] > ${$self->{_array}}[$right])
    {
	$self->swap($left, $right);
    }
    if (${$self->{_array}}[$middle] > ${$self->{_array}}[$right])
    {
	$self->swap($middle, $right);
    }
    return $middle;
}
#}>a

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "MedianOfThreeQuickSorter test program.\n";
    Opus10::Sorter::test(Opus10::MedianOfThreeQuickSorter->new(), 100, 123);
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

=head1 MODULE C<Opus10::MedianOfThreeQuickSorter>

=head2 CLASS C<Opus10::MedianOfThreeQuickSorter>

=head3 Base Classes

=over

=item C<Opus10::QuickSorter>

=back

Median-of-three quick sorter.

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

=head3 METHOD C<selectPivot>

Sorts the left, middle, and right array element
and returns the position of the middle element as the pivot.

=head4 Parameters

=over

=item C<self>

This quick sorter.

=item C<left>

Index of left element.

=item C<right>

Index of right element.

=back

=cut

