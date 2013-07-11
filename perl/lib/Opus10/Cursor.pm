#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Cursor.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Cursor.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Cursor
# Abstract base class from which all cursor classes are derived.
package Opus10::Cursor;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this queue.
# @param self This queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method getDatum
# Datum getter.
# @param self This cursor.
# @return The datum at the current position.
abstract_method qw(getDatum);

# @method insertAfter
# Inserts the given item after the current position.
# @param obj The object to insert.
# @param self This cursor.
abstract_method qw(insertAfter);

# @method insertAfter
# Inserts the given item before the current position.
# @param obj The object to insert.
# @param self This cursor.
abstract_method qw(insertBefore);

# @method withdraw
# Withdraws the item from the current position.
# @param self This cursor.
abstract_method qw(withdraw);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Cursor>

=head2 CLASS C<Opus10::Cursor>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Abstract base class from which all cursor classes are derived.

=head3 METHOD C<getDatum>

Datum getter.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=head4 Return

The datum at the current position.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<insertAfter>

Inserts the given item before the current position.

=head4 Parameters

=over

=item C<obj>

The object to insert.

=item C<self>

This cursor.

=back

=head3 METHOD C<withdraw>

Withdraws the item from the current position.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=cut

