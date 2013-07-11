#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Point.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Point.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Point
# Represents a point in the Cartesian plane.
# @attr _x The abcissa.
# @attr _y The ordinate.
package Opus10::Point;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this point.
# @param self This point.
# @param x The abcissa.
# @param y The ordinate.
sub initialize
{
    my ($self, $x, $y) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_x _y);
    $self->{_x} = $x;
    $self->{_y} = $y;
}

destructor qw(DESTROY);

# The abcissa.
attr_reader qw(_x);

# The ordinate.
attr_reader qw(_y);
#}>a

# @method toString
# Returns a string representation of this point.
# @param self This point.
# @return A string representation of this point.
sub toString
{
    my ($self) = @_;
    return sprintf("Point(%d,%d)", $self->{_x}, $self->{_y});
}

use overload
    '""' => qw(toString),
    fallback => 1;

1;
__DATA__

=head1 MODULE C<Opus10::Point>

=head2 CLASS C<Opus10::Point>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents a point in the Cartesian plane.

=head3 ATTRIBUTES

=over

=item C<_x>

The abcissa.

=item C<_y>

The ordinate.

=back

=head3 METHOD C<initialize>

Initializes this point.

=head4 Parameters

=over

=item C<self>

This point.

=item C<x>

The abcissa.

=item C<y>

The ordinate.

=back

=head3 METHOD C<toString>

Returns a string representation of this point.

=head4 Parameters

=over

=item C<self>

This point.

=back

=head4 Return

A string representation of this point.

=cut

