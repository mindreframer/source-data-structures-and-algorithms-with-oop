#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BinaryInsertionSorter.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BinaryInsertionSorter.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BinaryInsertionSorter
# Binary insertion sorter.
package Opus10::BinaryInsertionSorter;
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

# @method doSort
# Sorts the elements of the array.
# @param self This sorter.
sub doSort
{
    my ($self) = @_;
    for (my $i = 1; $i < $self->{_n}; ++$i)
    {
	my $tmp = ${$self->{_array}}[$i];
	my $left = 0;
	my $right = $i;
	while ($left < $right)
	{
	    my $middle = int(($left +$right) / 2);
	    if ($tmp >= ${$self->{_array}}[$middle])
	    {
		$left = $middle + 1;
	    }
	    else
	    {
		$right = $middle;
	    }
	}
	my $j = $i;
	while ($j > $left)
	{
	    $self->swap($j - 1, $j);
	    $j -= 1;
	}
    }
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
    print "BinaryInsertionSorter test program.\n";
    Opus10::Sorter::test(Opus10::BinaryInsertionSorter->new(), 100, 123);
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

=head1 MODULE C<Opus10::BinaryInsertionSorter>

=head2 CLASS C<Opus10::BinaryInsertionSorter>

=head3 Base Classes

=over

=item C<Opus10::Sorter>

=back

Binary insertion sorter.

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

