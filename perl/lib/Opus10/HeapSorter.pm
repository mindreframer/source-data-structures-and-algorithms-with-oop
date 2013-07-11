#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: HeapSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: HeapSorter.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::HeapSorter
# A heap sorter.
package Opus10::HeapSorter;
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
}

destructor qw(DESTROY);

# @method percolateDown
# Percolates down the elements in the array with the given length
# and starting at the given position.
# @param self This heap sorter.
# @param i Start index.
# @param j Length of array.
sub percolateDown
{
    my ($self, $i, $length) = @_;
    while (2 * $i <= $length)
    {
	my $j = 2 * $i;
	if ($j < $length &&
	    ${$self->{_array}}[$j + 1] > ${$self->{_array}}[$j])
	{
	    $j += 1;
	}
	last if ${$self->{_array}}[$i] >= ${$self->{_array}}[$j];
	$self->swap($i, $j);
	$i = $j;
    }
}
#}>a

#{
# @method buildHeap
# Builds the heap.
# @param self This heap sorter.
sub buildHeap
{
    my ($self) = @_;
    my $i = int($self->{_n} / 2);
    while ($i > 0)
    {
	$self->percolateDown($i, $self->{_n});
	$i -= 1;
    }
}
#}>b

#{
# @method doSort
# Sorts the elements of the array.
# @param self This heap sorter.
sub doSort
{
    my ($self) = @_;
    my $base = tied(@{$self->{_array}})->getBaseIndex();
    tied(@{$self->{_array}})->setBaseIndex(1);
    $self->buildHeap();
    my $i = $self->{_n};
    while ($i >= 2)
    {
	$self->swap($i, 1);
	$self->percolateDown(1, $i - 1);
	$i -= 1;
    }
    tied(@{$self->{_array}})->setBaseIndex($base);
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
    print "HeapSorter test program.\n";
    Opus10::Sorter::test(Opus10::HeapSorter->new(), 100, 123);
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

=head1 MODULE C<Opus10::HeapSorter>

=head2 CLASS C<Opus10::HeapSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

A heap sorter.

=head3 METHOD C<buildHeap>

Builds the heap.

=head4 Parameters

=over

=item C<self>

This heap sorter.

=back

=head3 METHOD C<doSort>

Sorts the elements of the array.

=head4 Parameters

=over

=item C<self>

This heap sorter.

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

=head3 METHOD C<percolateDown>

Percolates down the elements in the array with the given length
and starting at the given position.

=head4 Parameters

=over

=item C<self>

This heap sorter.

=item C<i>

Start index.

=item C<j>

Length of array.

=back

=cut

