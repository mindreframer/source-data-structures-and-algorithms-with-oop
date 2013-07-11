#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: Rectangle.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Rectangle.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Rectangle
# A rectangle.
# @attr _width The width.
# @attr _height The height.
package Opus10::Rectangle;
use Opus10::Declarators;
use Opus10::GraphicalObject;
our @ISA = qw(Opus10::GraphicalObject);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this rectangle with the given center point, width and height.
# @param self This rectangle.
# @param center A point.
# @param width The width.
# @param height The height.
sub initialize
{
    my ($self, $center, $width, $height) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($center);
    $self->declare qw(_width _height);
    $self->{_width} = $width;
    $self->{_height} = $height;
}

destructor qw(DESTROY);

# @method draw
# Draws this rectangle.
# @param self This rectangle
sub draw
{
    my ($self) = @_;
    # ...
#[
    printf "RECTANGLE %s %d\n",
	$self->{_center}, $self->{_width}, $self->{_height};
#]
}
#}>a

# @function main
# String test program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    printf "Rectangle test program.\n";
    my $r = Opus10::Rectangle->new(Opus10::Point->new(0,0), 1, 2);
    Opus10::GraphicalObject::test($r);
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Rectangle>

=head2 CLASS C<Opus10::Rectangle>

=head3 Base Classes

=over

=item C<Opus10::GraphicalObject>

=back

A rectangle.

=head3 ATTRIBUTES

=over

=item C<_height>

The height.

=item C<_width>

The width.

=back

=head3 METHOD C<draw>

Draws this rectangle.

=head4 Parameters

=over

=item C<self>

This rectangle

=back

=head3 METHOD C<initialize>

Initializes this rectangle with the given center point, width and height.

=head4 Parameters

=over

=item C<self>

This rectangle.

=item C<center>

A point.

=item C<width>

The width.

=item C<height>

The height.

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

