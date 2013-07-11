#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: OrderedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: OrderedList.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::OrderedList
# Abstract base class from which all ordered lists are derived.
package Opus10::OrderedList;
use Opus10::Declarators;
use Opus10::SearchableContainer;
our @ISA = qw(Opus10::SearchableContainer);

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

# @method getItem
# Returns the object at the given index in this ordered list.
# @param index An index.
# @return The object at the given index.
abstract_method qw(getItem);

# @method findPosition
# Returns a cursor that represents the position in this list
# of an object that is equal to the given object.
# @param obj An object.
# @return A cursor.
abstract_method qw(findPosition);
#}>a

use Opus10::Box;

# @function test
# OrderedList test program.
# @param list The ordered list to test.
sub test
{
    my ($list) = @_;
    printf "OrderedList test program.\n";
    $list->insert(box(1));
    $list->insert(box(2));
    $list->insert(box(3));
    $list->insert(box(4));
    printf "%s\n", $list;
    my $obj = $list->find(box(2));
    $list->withdraw($obj);
    printf "%s\n", $list;
    my $position = $list->findPosition(box(3));
    $position->insertAfter(box(5));
    printf "%s\n", $list;
    $position->insertBefore(box(6));
    printf "%s\n", $list;
    $position->withdraw();
    printf "%s\n", $list;
    printf "Using each\n";
    $list->each(
	sub
	{
	    my ($item) = @_;
	    printf "%s\n", $item;
	}
    );
    printf "Using Iterator\n";
    my $iter = $list->iter();
    while (defined(my $item = $iter->()))
    {
	printf "%s\n", $item;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::OrderedList>

=head2 CLASS C<Opus10::OrderedList>

=head3 Base Classes

=over

=item C<Opus10::SearchableContainer>

=back

Abstract base class from which all ordered lists are derived.

=head3 METHOD C<findPosition>

Returns a cursor that represents the position in this list
of an object that is equal to the given object.

=head4 Parameters

=over

=item C<obj>

An object.

=back

=head4 Return

A cursor.

=head3 METHOD C<getItem>

Returns the object at the given index in this ordered list.

=head4 Parameters

=over

=item C<index>

An index.

=back

=head4 Return

The object at the given index.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 FUNCTION C<test>

OrderedList test program.

=head4 Parameters

=over

=item C<list>

The ordered list to test.

=back

=cut

