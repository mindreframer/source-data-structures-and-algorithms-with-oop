#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:59 $
#   $RCSfile: Application11.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Application11.pm,v 1.1 2005/09/25 21:35:59 brpreiss Exp $
#

use strict;

# @class Opus10::Application11
# Provides application program number 11.
package Opus10::Application11;
use Opus10::Box;
use Opus10::GraphAsMatrix;
use Opus10::GraphAsLists;
use Opus10::DigraphAsMatrix;
use Opus10::DigraphAsLists;
use Opus10::Algorithms;

our $VERSION = 1.00;

# @function weightedGraphTest
# Weighted graph test program.
# @param g The weighted graph to test.
sub weightedGraphTest
{
    my ($g) = @_;
    printf "Weighted graph test program.\n";
    $g->addVertex(0, box(123));
    $g->addVertex(1, box(234));
    $g->addVertex(2, box(345));
    $g->addEdge(0, 1, box(3));
    $g->addEdge(0, 2, box(1));
    $g->addEdge(1, 2, box(4));
    printf "%s\n", $g;
    printf "Prim's Algorithm\n";
    my $g2 = Opus10::Algorithms::primsAlgorithm($g, 0);
    printf "%s\n", $g2;
    $g2->purge();
    printf "Kruskal's Algorithm\n";
    $g2 = Opus10::Algorithms::kruskalsAlgorithm($g);
    printf "%s\n", $g2;
    $g2->purge();
}

# @function weightedDigraphTest
# Weighted digraph test program.
# @param g The weighted digraph to test.
sub weightedDigraphTest
{
    my ($g) = @_;
    printf "Weighted digraph test program.\n";
    Opus10::Application11::weightedGraphTest($g);
    printf "Dijkstra's Algorithm\n";
    my $g2 = Opus10::Algorithms::dijkstrasAlgorithm($g, 0);
    printf "%s\n", $g2;
    $g2->purge();
    printf "Floyd's Algorithm\n";
    $g2 = Opus10::Algorithms::floydsAlgorithm($g);
    printf "%s\n", $g2;
    $g2->purge();
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Application program number 11.\n";

    my $g = Opus10::GraphAsMatrix->new(32);
    Opus10::Application11::weightedGraphTest($g);
    $g->purge();

    $g = Opus10::GraphAsLists->new(32);
    Opus10::Application11::weightedGraphTest($g);
    $g->purge();

    $g = Opus10::DigraphAsMatrix->new(32);
    Opus10::Application11::weightedDigraphTest($g);
    $g->purge();

    $g = Opus10::DigraphAsLists->new(32);
    Opus10::Application11::weightedDigraphTest($g);
    $g->purge();

    printf "Critical path analysis.\n";
    $g = Opus10::DigraphAsMatrix->new(10);
    for (my $v = 0; $v < 10; ++$v)
    {
	$g->addVertex($v);
    }
    $g->addEdge(0, 1, box(3));
    $g->addEdge(1, 2, box(1));
    $g->addEdge(1, 3, box(4));
    $g->addEdge(2, 4, box(0));
    $g->addEdge(3, 4, box(0));
    $g->addEdge(4, 5, box(1));
    $g->addEdge(5, 6, box(9));
    $g->addEdge(5, 7, box(5));
    $g->addEdge(6, 8, box(0));
    $g->addEdge(7, 8, box(0));
    $g->addEdge(8, 9, box(2));
    printf "%s\n", $g;
    my $g2 = Opus10::Algorithms::criticalPathAnalysis($g);
    printf "%s\n", $g2;
    $g2->purge();
    $g->purge();

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

=head1 MODULE C<Opus10::Application11>

=head2 CLASS C<Opus10::Application11>

Provides application program number 11.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 FUNCTION C<weightedDigraphTest>

Weighted digraph test program.

=head4 Parameters

=over

=item C<g>

The weighted digraph to test.

=back

=head3 FUNCTION C<weightedGraphTest>

Weighted graph test program.

=head4 Parameters

=over

=item C<g>

The weighted graph to test.

=back

=cut

