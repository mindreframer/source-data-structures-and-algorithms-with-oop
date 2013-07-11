#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo4.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo4.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo4
# Provides demonstration program number 4.
package Opus10::Demo4;
use Opus10::String;
use Opus10::ChainedHashTable;
use Opus10::ChainedScatterTable;
use Opus10::OpenScatterTable;
use Opus10::OpenScatterTableV2;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 4.\n";
    Opus10::String::testHash();
    Opus10::ChainedHashTable::main(@args);
    Opus10::ChainedScatterTable::main(@args);
    Opus10::OpenScatterTable::main(@args);
    Opus10::OpenScatterTableV2::main(@args);
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

=head1 MODULE C<Opus10::Demo4>

=head2 CLASS C<Opus10::Demo4>

Provides demonstration program number 4.

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

