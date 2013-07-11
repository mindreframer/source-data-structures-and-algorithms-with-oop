#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo5.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo5.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo5
# Provides demonstration program number 5.
package Opus10::Demo5;
use Opus10::GeneralTree;
use Opus10::BinaryTree;
use Opus10::NaryTree;
use Opus10::BinarySearchTree;
use Opus10::AVLTree;
use Opus10::MWayTree;
use Opus10::BTree;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 5.\n";
    Opus10::GeneralTree::main(@args);
    Opus10::BinaryTree::main(@args);
    Opus10::NaryTree::main(@args);
    Opus10::BinarySearchTree::main(@args);
    Opus10::AVLTree::main(@args);
    Opus10::MWayTree::main(@args);
    Opus10::BTree::main(@args);
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

=head1 MODULE C<Opus10::Demo5>

=head2 CLASS C<Opus10::Demo5>

Provides demonstration program number 5.

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

