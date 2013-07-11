#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: Wrapper.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Wrapper.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Wrapper
# Used to wrap a value into an object.
# @attr value The wrapped value.
package Opus10::Wrapper;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this wrapper.
# @param self This wrapper.
# @param value A value.
sub initialize
{
    my ($self, $value) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_value);
    $self->{_value} = $value;
}

destructor qw(DESTROY);

attr_reader qw(_value);
#}>a

#{
# @method toString
# Returns the value of this wrapper converted to a string.
# @param self This wrapper.
# @return The value of this wrapper converted to a string.
sub toString
{
    my ($self) = @_;
    return '' . $self->{_value};
}

# @method toNumeric
# Returns the value of this wrapper converted to a number.
# @param self This wrapper.
# @return The value of this wrapper converted to a number.
sub toNumeric
{
    my ($self) = @_;
    return 0 + $self->{_value};
}

# @method toBoolean
# Returns the value of this wrapper converted to a Boolean.
# @param self This wrapper.
# @return The value of this wrapper converted to a Boolean.
sub toBoolean
{
    my ($self) = @_;
    return $self->{_value} ? 1 : 0;
}

1;
__DATA__

=head1 MODULE C<Opus10::Wrapper>

=head2 CLASS C<Opus10::Wrapper>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Used to wrap a value into an object.

=head3 ATTRIBUTES

=over

=item C<value>

The wrapped value.

=back

=head3 METHOD C<initialize>

Initializes this wrapper.

=head4 Parameters

=over

=item C<self>

This wrapper.

=item C<value>

A value.

=back

=head3 METHOD C<toBoolean>

Returns the value of this wrapper converted to a Boolean.

=head4 Parameters

=over

=item C<self>

This wrapper.

=back

=head4 Return

The value of this wrapper converted to a Boolean.

=head3 METHOD C<toNumeric>

Returns the value of this wrapper converted to a number.

=head4 Parameters

=over

=item C<self>

This wrapper.

=back

=head4 Return

The value of this wrapper converted to a number.

=head3 METHOD C<toString>

Returns the value of this wrapper converted to a string.

=head4 Parameters

=over

=item C<self>

This wrapper.

=back

=head4 Return

The value of this wrapper converted to a string.

=cut

