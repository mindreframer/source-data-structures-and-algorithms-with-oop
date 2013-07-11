#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Circle.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Circle.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Circle
# A circle.
# @attr _radius The radius.
package Opus10::Circle;
use Opus10::Declarators;
use Opus10::GraphicalObject;
our @ISA = qw(Opus10::GraphicalObject);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this circle with the given center point and radius.
# @param self This circle.
# @param center A point.
# @param radius The radius.
sub initialize
{
    my ($self, $center, $radius) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($center);
    $self->declare qw(_radius);
    $self->{_radius} = $radius;
}

destructor qw(DESTROY);

# @method draw
# Draws this circle.
# @param self This circle
sub draw
{
    my ($self) = @_;
    # ...
#[
    printf "CIRCLE %s %d\n", $self->{_center}, $self->{_radius};
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
    printf "Circle test program.\n";
    my $c = Opus10::Circle->new(Opus10::Point->new(0,0), 1);
    Opus10::GraphicalObject::test($c);
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Circle>

=head2 CLASS C<Opus10::Circle>

=head3 Base Classes

=over

=item C<Opus10::GraphicalObject>

=back

A circle.

=head3 ATTRIBUTES

=over

=item C<_radius>

The radius.

=back

=head3 METHOD C<draw>

Draws this circle.

=head4 Parameters

=over

=item C<self>

This circle

=back

=head3 METHOD C<initialize>

Initializes this circle with the given center point and radius.

=head4 Parameters

=over

=item C<self>

This circle.

=item C<center>

A point.

=item C<radius>

The radius.

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

