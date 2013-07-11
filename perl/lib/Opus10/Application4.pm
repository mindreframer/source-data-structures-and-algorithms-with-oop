#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:35:59 $
#   $RCSfile: Application4.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Application4.pm,v 1.1 2005/09/25 21:35:59 brpreiss Exp $
#

use strict;

# @class Opus10::Application4
# Provides application program number 4.
package Opus10::Application4;
use Opus10::Polynomial;
use Opus10::PolynomialAsSortedList;

our $VERSION = 1.00;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Application program number 4.\n";

    my $p1 = Opus10::PolynomialAsSortedList->new();
    $p1->addTerm(Opus10::Polynomial::Term->new(4.5, 5));
    $p1->addTerm(Opus10::Polynomial::Term->new(3.2, 14));
    printf "%s\n", $p1;

    my $p2 = Opus10::PolynomialAsSortedList->new();
    $p2->addTerm(Opus10::Polynomial::Term->new(7.8, 3));
    $p2->addTerm(Opus10::Polynomial::Term->new(1.6, 14));
    $p2->addTerm(Opus10::Polynomial::Term->new(9.999, 27));
    printf "%s\n", $p2;

    my $p3 = $p1 + $p2;
    printf "%s\n", $p3;

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

=head1 MODULE C<Opus10::Application4>

=head2 CLASS C<Opus10::Application4>

Provides application program number 4.

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

