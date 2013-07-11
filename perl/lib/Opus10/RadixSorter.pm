#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: RadixSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: RadixSorter.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::RadixSorter
# A Radix sorter.
# @attr _count A count array.
# @attr _tempArray A temporary array.
package Opus10::RadixSorter;
use Carp;
use Opus10::Declarators;
use Opus10::Sorter;
our @ISA = qw(Opus10::Sorter);

#}>head

our $VERSION = 1.00;

#{
# The number of bits in the radix.
use constant r => 8;
# The radix.
use constant R => 1 << r;
# Number of passes.
use constant p => int((32 + r - 1) / r);

# @method initialize
# Initializes this sorter.
# @param self This sorter.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_count _tempArray);
    (tie@{$self->{_count}}, 'Opus10::Array', R);
    $self->{_tempArray} = undef;
}

destructor qw(DESTROY);
#}>a

#{
# @method doSort
# Sorts the elements of the array.
# @param self This sorter.
sub doSort
{
    my ($self) = @_;
    my $RM1 = R - 1;
    tie(@{$self->{_tempArray}}, 'Opus10::Array', $self->{_n});
    for (my $i = 0; $i < p; ++$i)
    {
	for (my $j = 0; $j < R; ++$j)
	{
	    ${$self->{_count}}[$j] = 0;
	}
	my $shift = r * $i;
	for (my $k = 0; $k < $self->{_n}; ++$k)
	{
	    my $index =
		(${$self->{_array}}[$k] >> $shift) & $RM1;
	    ${$self->{_count}}[$index] += 1;
	    ${$self->{_tempArray}}[$k] = ${$self->{_array}}[$k];
	}
	my $pos = 0;
	for (my $j = 0; $j < R; ++$j)
	{
	    my $tmp = $pos;
	    $pos += ${$self->{_count}}[$j];
	    ${$self->{_count}}[$j] = $tmp;
	}
	for (my $k = 0; $k < $self->{_n}; ++$k)
	{
	    my $index =
		(${$self->{_tempArray}}[$k] >> $shift) & $RM1;
	    ${$self->{_array}}[${$self->{_count}}[$index]] = 
		${$self->{_tempArray}}[$k];
	    ${$self->{_count}}[$index] += 1;
	}
    }
    $self->{_tempArray} = undef;
}
#}>b

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "RadixSorter test program.\n";
    Opus10::Sorter::test(Opus10::RadixSorter->new(), 100, 123);
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

=head1 MODULE C<Opus10::RadixSorter>

=head2 CLASS C<Opus10::RadixSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

A Radix sorter.

=head3 ATTRIBUTES

=over

=item C<_count>

A count array.

=item C<_tempArray>

A temporary array.

=back

=head3 METHOD C<doSort>

Sorts the elements of the array.

=head4 Parameters

=over

=item C<self>

This sorter.

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

=cut

