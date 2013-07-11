#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: Sorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Sorter.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Sorter
# Abstract base class from which all sorter classes are derived.
# @attr _array The array to sort.
# @attr _n The length of the array.
package Opus10::Sorter;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::Array;
use Opus10::RandomNumberGenerator;
use Opus10::Integer;
use Opus10::Timer;
use Opus10::Integer;
our @ISA = qw(Opus10::Object);

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
    $self->declare qw(_array _n);
    $self->{_array} = undef;
    $self->{_n} = 0;
}

destructor qw(DESTROY);

# @method doSort
# The sort routine.
# @param self This sorter.
abstract_method qw(doSort);

# @method sort
# Sorts the elements of the given array.
# @param self This array.
# @param array The array to be sorted.
sub sort
{
    my ($self, $array) = @_;
    croak 'TypeError' if !$array->isa('Opus10::Array');
    tie (@{$self->{_array}}, 'Opus10::Array', $array);
    $self->{_n} = @{$self->{_array}};
    if ($self->{_n} > 0)
    {
	$self->doSort();
    }
}

# @method swap
# Swaps the specified elements of the being sorted.
# @param self This sorter.
# @param i An index.
# @param j An index.
sub swap
{
    my ($self, $i, $j) = @_;
    (${$self->{_array}}[$i], ${$self->{_array}}[$j]) =
	(${$self->{_array}}[$j], ${$self->{_array}}[$i]);
}
#}>a

# @method test
# Sorter test program.
# @param sorter The sorter to test.
# @param n The array size to test.
# @param seed The seed for the random number generator.
# @param m If given, data values are restricted to the interval [0,m-1].
sub test
{
    my ($sorter, $n, $seed, $m) = @_;
    $m = $m || 0;
    Opus10::RandomNumberGenerator->setSeed($seed);
    tie (my @data, 'Opus10::Array', $n);
    for (my $i = 0; $i < $n; ++$i)
    {
	my $datum = int(
	    Opus10::RandomNumberGenerator->next() * Opus10::Integer::MAXINT);
	if ($m != 0)
	{
	    $datum = $datum % $m;
	}
	$data[$i] = $datum;
    }
    my $timer = Opus10::Timer->new();
    $timer->start();
    $sorter->sort(tied(@data));
    $timer->stop();
    my $datum = sprintf("%s %d %d %g",
		ref($sorter), $n, $seed, $timer->elapsedTime());
    printf STDOUT "%s\n", $datum;
    printf STDERR "%s\n", $datum;
    for (my $i = 1; $i < $n; ++$i)
    {
	if ($data[$i] < $data[$i - 1])
	{
	    printf "FAILED\n";
	    last;
	}
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Sorter>

=head2 CLASS C<Opus10::Sorter>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Abstract base class from which all sorter classes are derived.

=head3 ATTRIBUTES

=over

=item C<_array>

The array to sort.

=item C<_n>

The length of the array.

=back

=head3 METHOD C<doSort>

The sort routine.

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

=head3 METHOD C<sort>

Sorts the elements of the given array.

=head4 Parameters

=over

=item C<self>

This array.

=item C<array>

The array to be sorted.

=back

=head3 METHOD C<swap>

Swaps the specified elements of the being sorted.

=head4 Parameters

=over

=item C<self>

This sorter.

=item C<i>

An index.

=item C<j>

An index.

=back

=head3 METHOD C<test>

Sorter test program.

=head4 Parameters

=over

=item C<sorter>

The sorter to test.

=item C<n>

The array size to test.

=item C<seed>

The seed for the random number generator.

=item C<m>

If given, data values are restricted to the interval [0,m-1].

=back

=cut

