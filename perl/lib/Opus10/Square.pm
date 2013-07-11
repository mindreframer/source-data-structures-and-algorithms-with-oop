#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: Square.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Square.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Square
# A square.
# @attr _width The width.
# @attr _height The height.
package Opus10::Square;
use Opus10::Declarators;
use Opus10::Rectangle;
our @ISA = qw(Opus10::Rectangle);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this square with the given center point and size.
# @param self This square.
# @param center A point.
# @param size The size.
sub initialize
{
    my ($self, $center, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($center, $size, $size);
}

destructor qw(DESTROY);
#}>a

# @function main
# String test program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    printf "Square test program.\n";
    my $s = Opus10::Square->new(Opus10::Point->new(0,0), 3);
    Opus10::GraphicalObject::test($s);
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Square>

=head2 CLASS C<Opus10::Square>

=head3 Base Classes

=over

=item C<Opus10::Rectangle>

=back

A square.

=head3 ATTRIBUTES

=over

=item C<_height>

The height.

=item C<_width>

The width.

=back

=head3 METHOD C<initialize>

Initializes this square with the given center point and size.

=head4 Parameters

=over

=item C<self>

This square.

=item C<center>

A point.

=item C<size>

The size.

=back

=head3 FUNCTION C<main>

String test program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

