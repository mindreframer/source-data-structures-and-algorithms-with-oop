#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:02 $
#   $RCSfile: Experiment1.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Experiment1.pm,v 1.1 2005/09/25 21:36:02 brpreiss Exp $
#

use strict;

# @class Opus10::Experiment1
# Provides application program number 1.
package Opus10::Experiment1;
use Opus10::Example;
use Opus10::Timer;

our $VERSION = 1.00;

# @function main
# Program that measures the running times of both
# a recursive and a non-recursive method to compute
# the Fibonacci numbers.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf STDERR "Experiment1 test program.\n";
    printf STDOUT "3\n";
    printf STDOUT "n\n";
    printf STDOUT "fib1 s\n";
    printf STDOUT "fib2 s\n";
    my $timer1 = Opus10::Timer->new();
    my $timer2 = Opus10::Timer->new();
    for (my $i = 0; $i <= 44; ++$i)
    {
	$timer1->start();
	my $result = Opus10::Example::fibonacci1($i);
	$timer1->stop();

	$timer2->start();
	$result = Opus10::Example::fibonacci2($i);
	$timer2->stop();

	my $datum = sprintf("%d\t%g\t%g",
	    $i, $timer1->elapsedTime(), $timer2->elapsedTime());
	printf STDOUT "%s\n", $datum;
	printf STDERR "%s\n", $datum;
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

=head1 MODULE C<Opus10::Experiment1>

=head2 CLASS C<Opus10::Experiment1>

Provides application program number 1.

=head3 FUNCTION C<main>

Program that measures the running times of both
a recursive and a non-recursive method to compute
the Fibonacci numbers.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

