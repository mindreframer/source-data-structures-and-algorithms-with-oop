#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:59 $
#   $RCSfile: Application8.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Application8.pm,v 1.1 2005/09/25 21:35:59 brpreiss Exp $
#

use strict;

# @class Opus10::Application8
# Provides application program number 8.
package Opus10::Application8;
use Carp;
use Opus10::Simulation;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Application program number 8.\n";
    my $simulation = Opus10::Simulation->new();
    $simulation->run(10000);
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

=head1 MODULE C<Opus10::Application8>

=head2 CLASS C<Opus10::Application8>

Provides application program number 8.

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

