#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:02 $
#   $RCSfile: Experiment2.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Experiment2.pm,v 1.1 2005/09/25 21:36:02 brpreiss Exp $
#

use strict;

# @class Opus10::Experiment2
# Provides application program number 2.
package Opus10::Experiment2;
use Opus10::Demo9;

our $VERSION = 1.00;

# @function main
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Experiment2 test program.\n";
    printf "4\n";
    printf "sort\n";
    printf "length\n";
    printf "seed\n";
    printf "time\n";
    my @seeds = ("1", "57", "12345", "7252795", "3127");
    foreach my $seed (@seeds)
    {
	my @lengths = ("10", "25", "50", "75",
	    "100", "250", "500", "750",
	    "1000", "1250", "1500", "1750", "2000");
	foreach my $length (@lengths)
	{
	    Opus10::Demo9::main($length, $seed, "7");
	}
	@lengths = ("3000", "4000", "5000", "6000",
	    "7000", "8000", "9000", "10000");
	foreach my $length (@lengths)
	{
	    Opus10::Demo9::main($length, $seed, "3");
	}
	@lengths = ("20000", "30000", "40000", "50000",
	    "60000", "70000", "80000", "90000", "100000");
	foreach my $length (@lengths)
	{
	    Opus10::Demo9::main($length, $seed, "1");
	}
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

=head1 MODULE C<Opus10::Experiment2>

=head2 CLASS C<Opus10::Experiment2>

Provides application program number 2.

=head3 FUNCTION C<main>


=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

