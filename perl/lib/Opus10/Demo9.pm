#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo9.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo9.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo9
# Provides demonstration program number 9.
package Opus10::Demo9;
use Opus10::Sorter;
use Opus10::StraightInsertionSorter;
use Opus10::BinaryInsertionSorter;
use Opus10::BubbleSorter;
use Opus10::StraightSelectionSorter;
use Opus10::MedianOfThreeQuickSorter;
use Opus10::HeapSorter;
use Opus10::TwoWayMergeSorter;
use Opus10::BucketSorter;
use Opus10::RadixSorter;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Demonstration program number 9.\n";
    if (@args != 3)
    {
	printf "usage: %s size seed mask\n", $0;
	exit 1;
    }
    my $n = $args[0] + 0;
    my $seed = $args[1] + 0;
    my $mask = $args[2] + 0;
    if ($mask & 4 != 0)
    {
	Opus10::Sorter::test(
	    Opus10::StraightInsertionSorter->new(), $n, $seed);
	Opus10::Sorter::test(
	    Opus10::BinaryInsertionSorter->new(), $n, $seed);
	Opus10::Sorter::test(
	    Opus10::BubbleSorter->new(), $n, $seed);
	Opus10::Sorter::test(
	    Opus10::StraightSelectionSorter->new(), $n, $seed);
    }
    if ($mask & 2 != 0)
    {
	Opus10::Sorter::test(
	    Opus10::MedianOfThreeQuickSorter->new(), $n, $seed);
	Opus10::Sorter::test(
	    Opus10::HeapSorter->new(), $n, $seed);
	Opus10::Sorter::test(
	    Opus10::TwoWayMergeSorter->new(), $n, $seed);
    }
    if ($mask & 1 != 0)
    {
	Opus10::Sorter::test(
	    Opus10::BucketSorter->new(1024), $n, $seed, 1024);
	Opus10::Sorter::test(
	    Opus10::RadixSorter->new(), $n, $seed);
    }
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

=head1 MODULE C<Opus10::Demo9>

=head2 CLASS C<Opus10::Demo9>

Provides demonstration program number 9.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

