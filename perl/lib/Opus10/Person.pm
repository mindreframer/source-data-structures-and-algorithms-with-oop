#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Person.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Person.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Person
# Represents a person.
# @attr _name The name.
# @attr _sex The sex.
package Opus10::Person;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# Female sex.
use constant FEMALE => 0;
# Male sex.
use constant MALE => 1;

# @method initialize
# Initializes this person with the given name and sex.
# @param self This person.
# @param name The name.
# @param sex The sex.
sub initialize
{
    my ($self, $name, $sex) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_name _sex);
    $self->{_name} = $name;
    $self->{_sex} = $sex;
}

destructor qw(DESTROY);
#}>a

# @method toString
# Returns a string representation of this person.
# @param self This person.
# @return A string.
sub toString
{
    my ($self) = @_;
    return $self->{_name};
}
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Person>

=head2 CLASS C<Opus10::Person>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents a person.

=head3 ATTRIBUTES

=over

=item C<_name>

The name.

=item C<_sex>

The sex.

=back

=head3 METHOD C<initialize>

Initializes this person with the given name and sex.

=head4 Parameters

=over

=item C<self>

This person.

=item C<name>

The name.

=item C<sex>

The sex.

=back

=head3 METHOD C<toString>

Returns a string representation of this person.

=head4 Parameters

=over

=item C<self>

This person.

=back

=head4 Return

A string.

=cut

