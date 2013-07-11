#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo6.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo6.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo6
# Provides demonstration program number 6.
package Opus10::Demo6;
use Opus10::BinaryHeap;
use Opus10::LeftistHeap;
use Opus10::BinomialQueue;
use Opus10::Deap;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 6.\n";
    Opus10::BinaryHeap::main(@args);
    Opus10::LeftistHeap::main(@args);
    Opus10::BinomialQueue::main(@args);
    Opus10::Deap::main(@args);
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

=head1 MODULE C<Opus10::Demo6>

=head2 CLASS C<Opus10::Demo6>

Provides demonstration program number 6.

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

