#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:59 $
#   $RCSfile: Application2.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Application2.pm,v 1.1 2005/09/25 21:35:59 brpreiss Exp $
#

use strict;

# @class Opus10::Application2
# Provides application program number 2.
package Opus10::Application2;
use Opus10::Algorithms;
use Opus10::NaryTree;
use Opus10::Box;

our $VERSION = 1.00;

# @function buildTree
# Builds an N-ary tree that contains character keys in the given range.
# @param lo The lower bound of the range.
# @param hi The upper bound of the range.
# @return An N-ary tree.
sub buildTree
{
    my ($lo, $hi) = @_;
    my $mid = ($lo + $hi) / 2;
    my $result = Opus10::NaryTree->new(2, box(chr($mid)));
    if ($lo < $mid)
    {
	$result->attachSubtree(0, buildTree($lo, $mid - 1));
    }
    if ($hi > $mid)
    {
	$result->attachSubtree(1, buildTree($mid + 1, $hi));
    }
    return $result;
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Application program number 2.\n";
    printf "Should be: dbfaceg.\n";
    my $tree = buildTree(ord('a'), ord('g'));
    Opus10::Algorithms::breadthFirstTraversal($tree,
	sub 
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
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

=head1 MODULE C<Opus10::Application2>

=head2 CLASS C<Opus10::Application2>

Provides application program number 2.

=head3 FUNCTION C<buildTree>

Builds an N-ary tree that contains character keys in the given range.

=head4 Parameters

=over

=item C<lo>

The lower bound of the range.

=item C<hi>

The upper bound of the range.

=back

=head4 Return

An N-ary tree.

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

