#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:59 $
#   $RCSfile: Application12.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Application12.pm,v 1.1 2005/09/25 21:35:59 brpreiss Exp $
#

use strict;

# @class Opus10::Application12
# Provides application program number 12.
package Opus10::Application12;
use Opus10::Array;
use Opus10::DepthFirstSolver;
use Opus10::DepthFirstBranchAndBoundSolver;
use Opus10::BreadthFirstSolver;
use Opus10::BreadthFirstBranchAndBoundSolver;
use Opus10::ScalesBalancingProblem;
use Opus10::ZeroOneKnapsackProblem;
use Opus10::Box;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Application program number 12.\n";

    my $solver1 = Opus10::DepthFirstSolver->new();
    my $solver2 = Opus10::DepthFirstBranchAndBoundSolver->new();
    my $solver3 = Opus10::BreadthFirstSolver->new();
    my $solver4 = Opus10::BreadthFirstBranchAndBoundSolver->new();

    my $weights = box([20, 20, 2, 2, 1]);
    my $scales = Opus10::ScalesBalancingProblem->new($weights);
    printf "%s\n", $scales->solve($solver1);
    printf "%s\n", $scales->solve($solver2);
    printf "%s\n", $scales->solve($solver3);
    printf "%s\n", $scales->solve($solver4);


    $weights = box([100, 50, 45, 20, 10, 5]);
    my $profits = box([ 40, 35, 18,  4, 10, 2]);
    my $knapsack = Opus10::ZeroOneKnapsackProblem->new($weights, $profits, 100);
    printf "%s\n", $knapsack->solve($solver1);
    printf "%s\n", $knapsack->solve($solver2);
    printf "%s\n", $knapsack->solve($solver3);
    printf "%s\n", $knapsack->solve($solver4);

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

=head1 MODULE C<Opus10::Application12>

=head2 CLASS C<Opus10::Application12>

Provides application program number 12.

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

