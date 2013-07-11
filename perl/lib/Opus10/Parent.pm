#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Parent.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Parent.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Parent
# Represents a parent.
# @attr _name The name.
# @attr _sex The sex.
# @attr _children The children.
package Opus10::Parent;
use Opus10::Declarators;
use Opus10::Person;
our @ISA = qw(Opus10::Person);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this parent with the given name and sex.
# @param self This parent.
# @param name The name.
# @param sex The sex.
# @param children The children.
sub initialize
{
    my ($self, $name, $sex, $children) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($name, $sex);
    $self->declare qw(_children);
    $self->{_children} = $children;
}

destructor qw(DESTROY);

# @method child
# Returns the selected child of this parent.
# @param self This parent.
# @param i The child index.
# @return The child.
sub child
{
    my ($self, $i) = @_;
    return ${$self->{_children}}[$i];
}
#}>a

# @method toString
# Returns a string representation of this parent.
# @param self This parent.
# @return A string.
sub toString
{
    my ($self) = @_;
    # ...
}
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Parent>

=head2 CLASS C<Opus10::Parent>

=head3 Base Classes

=over

=item C<Opus10::Person>

=back

Represents a parent.

=head3 ATTRIBUTES

=over

=item C<_children>

The children.

=item C<_name>

The name.

=item C<_sex>

The sex.

=back

=head3 METHOD C<child>

Returns the selected child of this parent.

=head4 Parameters

=over

=item C<self>

This parent.

=item C<i>

The child index.

=back

=head4 Return

The child.

=head3 METHOD C<initialize>

Initializes this parent with the given name and sex.

=head4 Parameters

=over

=item C<self>

This parent.

=item C<name>

The name.

=item C<sex>

The sex.

=item C<children>

The children.

=back

=head3 METHOD C<toString>

Returns a string representation of this parent.

=head4 Parameters

=over

=item C<self>

This parent.

=back

=head4 Return

A string.

=cut

