#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BucketSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BucketSorter.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BucketSorter
# A bucket sorter.
# @attr _m The number of buckets.
# @attr _bucket The buckets.
package Opus10::BucketSorter;
use Carp;
use Opus10::Declarators;
use Opus10::Sorter;
our @ISA = qw(Opus10::Sorter);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this bucket sorter with the given number of buckets.
# @param m The number of buckets.
# @param self This sorter.
sub initialize
{
    my ($self, $m) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_m _count);
    $self->{_m} = $m;
    tie(@{$self->{_count}}, 'Opus10::Array', $m);
}

destructor qw(DESTROY);
#}>a

#{
# @method doSort
# Sorts the elements of the array.
# @param self This bucket sorter
sub doSort
{
    my ($self) = @_;
    for (my $i = 0; $i < $self->{_m}; ++$i)
    {
	${$self->{_count}}[$i] = 0;
    }
    for (my $j = 0; $j < $self->{_n}; ++$j)
    {
	${$self->{_count}}[${$self->{_array}}[$j]] += 1;
    }
    my $j = 0;
    for (my $i = 0; $i < $self->{_m}; ++$i)
    {
	while (${$self->{_count}}[$i] > 0)
	{
	    ${$self->{_array}}[$j] = $i;
	    $j += 1;
	    ${$self->{_count}}[$i] -= 1;
	}
    }
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
    print "BucketSorter test program.\n";
    Opus10::Sorter::test(Opus10::BucketSorter->new(1024), 100, 123, 1024);
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

=head1 MODULE C<Opus10::BucketSorter>

=head2 CLASS C<Opus10::BucketSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

A bucket sorter.

=head3 ATTRIBUTES

=over

=item C<_bucket>

The buckets.

=item C<_m>

The number of buckets.

=back

=head3 METHOD C<doSort>

Sorts the elements of the array.

=head4 Parameters

=over

=item C<self>

This bucket sorter

=back

=head3 METHOD C<initialize>

Initializes this bucket sorter with the given number of buckets.

=head4 Parameters

=over

=item C<m>

The number of buckets.

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

