#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:01 $
#   $RCSfile: Demo3.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Demo3.pm,v 1.1 2005/09/25 21:36:01 brpreiss Exp $
#

use strict;

# @class Opus10::Demo3
# Provides demonstration program number 3.
package Opus10::Demo3;
use Opus10::OrderedListAsArray;
use Opus10::OrderedListAsLinkedList;
use Opus10::SortedListAsArray;
use Opus10::SortedListAsLinkedList;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Demonstration program number 3.\n";
    Opus10::OrderedListAsArray::main(@args);
    Opus10::OrderedListAsLinkedList::main(@args);
    Opus10::SortedListAsArray::main(@args);
    Opus10::SortedListAsLinkedList::main(@args);
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

=head1 MODULE C<Opus10::Demo3>

=head2 CLASS C<Opus10::Demo3>

Provides demonstration program number 3.

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

