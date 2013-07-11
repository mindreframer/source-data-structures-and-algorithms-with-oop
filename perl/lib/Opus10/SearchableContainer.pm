#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: SearchableContainer.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SearchableContainer.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SearchableContainer
# Abstract base class from which all container classes are derived.
# @attr _count The number of items in this container.
package Opus10::SearchableContainer;
use Opus10::Declarators;
use Opus10::Container;
our @ISA = qw(Opus10::Container);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this container.
# @param self This container.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method contains
# Contains predicate.
# @param self This searchable container.
# @param obj An object
# @return True if the given object is contained in this container;
# false otherwise.
abstract_method qw(contains);

# @method insert
# Inserts the given object into this searchable container.
# @param self This searchable container.
# @param obj An object
abstract_method qw(insert);

# @method withdraw
# Withdraws the given object from this searchable container.
# @param self This searchable container.
# @param obj An object
abstract_method qw(withdraw);

# @method find
# Finds an object in this container that equals the given object.
# @param self This searchable container.
# @param obj An object
# @return The object that equals the given object.
abstract_method qw(find);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::SearchableContainer>

=head2 CLASS C<Opus10::SearchableContainer>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all container classes are derived.

=head3 ATTRIBUTES

=over

=item C<_count>

The number of items in this container.

=back

=head3 METHOD C<contains>

Contains predicate.

=head4 Parameters

=over

=item C<self>

This searchable container.

=item C<obj>

An object

=back

=head4 Return

True if the given object is contained in this container;
false otherwise.

=head3 METHOD C<find>

Finds an object in this container that equals the given object.

=head4 Parameters

=over

=item C<self>

This searchable container.

=item C<obj>

An object

=back

=head4 Return

The object that equals the given object.

=head3 METHOD C<initialize>

Initializes this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head3 METHOD C<insert>

Inserts the given object into this searchable container.

=head4 Parameters

=over

=item C<self>

This searchable container.

=item C<obj>

An object

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this searchable container.

=head4 Parameters

=over

=item C<self>

This searchable container.

=item C<obj>

An object

=back

=cut

