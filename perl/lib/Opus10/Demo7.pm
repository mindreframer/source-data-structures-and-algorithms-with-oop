#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo7.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo7.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo7
# Provides demonstration program number 7.
package Opus10::Demo7;
use Opus10::SetAsArray;
use Opus10::SetAsBitVector;
use Opus10::MultisetAsArray;
use Opus10::MultisetAsLinkedList;
use Opus10::PartitionAsForest;
use Opus10::PartitionAsForestV2;
use Opus10::PartitionAsForestV3;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 7.\n";
    Opus10::SetAsArray::main(@args);
    Opus10::SetAsBitVector::main(@args);
    Opus10::MultisetAsArray::main(@args);
    Opus10::MultisetAsLinkedList::main(@args);
    Opus10::PartitionAsForest::main(@args);
    Opus10::PartitionAsForestV2::main(@args);
    Opus10::PartitionAsForestV3::main(@args);
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

=head1 MODULE C<Opus10::Demo7>

=head2 CLASS C<Opus10::Demo7>

Provides demonstration program number 7.

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

