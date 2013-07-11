#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: GraphicalObject.pm,v $
#   $Revision: 1.2 $
#
#   $Id: GraphicalObject.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::GraphicalObject
# Base class from which graphical object classes are derived.
# @attr _center The center point.
package Opus10::GraphicalObject;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::Point;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

# Background color.
use constant BACKGROUND_COLOR => 0;

# Foreground color.
use constant FOREGROUND_COLOR => 1;

#{
# @method initialize
# Initializes this graphical object.
# @param self This graphical object.
# @param center The center point.
sub initialize
{
    my ($self, $center) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_center);
    if (defined($center))
    {
	$self->{_center} = $center;
    }
    else
    {
	$self->{_center} = Opus10::Point->new(0,0);
    }
}

destructor qw(DESTROY);

# @method draw
# Draws this graphical object.
# @param self This graphical object.
abstract_method qw(draw);

# @method erase
# Erases this graphical object.
# @param self This graphical object.
sub erase
{
    my ($self) = @_;
    $self->setPenColor(BACKGROUND_COLOR);
    $self->draw();
    $self->setPenColor(FOREGROUND_COLOR);
}

# @method moveTo
# Moves this graphical object to the given point.
# @param self This graphical object.
# @param p A point.
sub moveTo
{
    my ($self, $p) = @_;
    $self->erase();
    $self->{_center} = $p;
    $self->draw();
}
#}>a

# @method setPenColor
# Sets the pen color to the given color.
# @param self This graphical object.
# @param color A color.
sub setPenColor
{
    my ($self, $color) = @_;
}

# @function test
# GraphicalObject test program.
# @param go The graphical object to test.
sub test
{
    my ($go) = @_;
    printf "GraphicalObject test program.\n";
    $go->draw();
    $go->moveTo(Opus10::Point->new(1,1));
    $go->erase();
}

1;
__DATA__

=head1 MODULE C<Opus10::GraphicalObject>

=head2 CLASS C<Opus10::GraphicalObject>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Base class from which graphical object classes are derived.

=head3 ATTRIBUTES

=over

=item C<_center>

The center point.

=back

=head3 METHOD C<draw>

Draws this graphical object.

=head4 Parameters

=over

=item C<self>

This graphical object.

=back

=head3 METHOD C<erase>

Erases this graphical object.

=head4 Parameters

=over

=item C<self>

This graphical object.

=back

=head3 METHOD C<initialize>

Initializes this graphical object.

=head4 Parameters

=over

=item C<self>

This graphical object.

=item C<center>

The center point.

=back

=head3 METHOD C<moveTo>

Moves this graphical object to the given point.

=head4 Parameters

=over

=item C<self>

This graphical object.

=item C<p>

A point.

=back

=head3 METHOD C<setPenColor>

Sets the pen color to the given color.

=head4 Parameters

=over

=item C<self>

This graphical object.

=item C<color>

A color.

=back

=head3 FUNCTION C<test>

GraphicalObject test program.

=head4 Parameters

=over

=item C<go>

The graphical object to test.

=back

=cut

