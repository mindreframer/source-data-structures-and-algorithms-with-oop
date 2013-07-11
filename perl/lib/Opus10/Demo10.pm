#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo10.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo10.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo10
# Provides demonstration program number 10.
package Opus10::Demo10;
use Opus10::GraphAsMatrix;
use Opus10::DigraphAsMatrix;
use Opus10::GraphAsLists;
use Opus10::DigraphAsLists;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 10.\n";
    Opus10::GraphAsMatrix::main(@args);
    Opus10::DigraphAsMatrix::main(@args);
    Opus10::GraphAsLists::main(@args);
    Opus10::DigraphAsLists::main(@args);
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

=head1 MODULE C<Opus10::Demo10>

=head2 CLASS C<Opus10::Demo10>

Provides demonstration program number 10.

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

