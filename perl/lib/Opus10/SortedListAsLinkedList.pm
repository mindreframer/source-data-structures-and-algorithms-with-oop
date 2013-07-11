#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SortedListAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SortedListAsLinkedList.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

# @class Opus10::SortedListAsLinkedList::Cursor
# Represents a position in this list.
package Opus10::SortedListAsLinkedList::Cursor;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedListAsLinkedList;
our @ISA = qw(Opus10::OrderedListAsLinkedList::Cursor);

our $VERSION = 1.00;

# @method initialize
# Initializes a cursor that represents the position
# in the given list at the given offset.
# @param self This cursor.
# @param list An sorted list.
# @param offset An offset.
sub initialize
{
    my ($self, $list, $offset) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($list, $offset);
}

destructor qw(DESTROY);

# @method insertAfter
# Not supported.
# @param self This cursor.
sub insertAfter
{
    croak 'OperationNotSupported';
}

# @method insertBefore
# Not supported.
# @param self This cursor.
sub insertBefore
{
    croak 'OperationNotSupported';
}

#{
# @class Opus10::SortedListAsLinkedList
# An sorted list implemented using an linked list.
package Opus10::SortedListAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedListAsLinkedList;
use Opus10::SortedList;
our @ISA = qw(Opus10::OrderedListAsLinkedList
    Opus10::SortedList);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an sorted list with the given size.
# @param self This queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->Opus10::OrderedListAsLinkedList::initialize();
    $self->Opus10::SortedList::initialize();
}

destructor qw(DESTROY);
#}>a

#{
# @method insert
# Inserts the given object into this sorted list (at the end of the list).
# @param self This sorted list.
# @param obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    my $prevPtr = undef;
    my $ptr = $self->{_linkedList}->getHead();
    while (defined($ptr))
    {
	last if ($ptr->getDatum() >= $obj);
	$prevPtr = $ptr;
	$ptr = $ptr->getSucc();
    }
    if (defined($prevPtr))
    {
	$prevPtr->insertAfter($obj);
    }
    else
    {
	$self->{_linkedList}->prepend($obj);
    }
    $self->{_count} += 1;
}
#}>b

# @method findElement
# Finds the linked-list element that contains an object
# that is equal to the given object.
# @param self This sorted list.
# @param obj An object.
# @return A linked list element.
sub findElement
{
    my ($self, $obj) = @_;
    my $ptr = $self->{_linkedList}->getHead();
    while (defined($ptr))
    {
	if ($ptr->getDatum() == $obj)
	{
	    return $ptr;
	}
	$ptr = $ptr->getSucc();
    }
    return undef;
}

# @method findPosition
# Returns a cursor that represents the position in this list
# of an object equal to the given object.
# @param obj An object.
# @return A cursor.
sub findPosition
{
    my ($self, $obj) = @_;
    return Opus10::SortedListAsLinkedList::Cursor->new(
	$self, $self->findElement($obj));
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "SortedListAsLinkedList test program.\n";
    my $list = Opus10::SortedListAsLinkedList->new(10);
    Opus10::SortedList::test($list);
    return $status;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::SortedListAsLinkedList>

=head2 CLASS C<Opus10::SortedListAsLinkedList>

An sorted list implemented using an linked list.

=head3 METHOD C<findElement>

Finds the linked-list element that contains an object
that is equal to the given object.

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

An object.

=back

=head4 Return

A linked list element.

=head3 METHOD C<findPosition>

Returns a cursor that represents the position in this list
of an object equal to the given object.

=head4 Parameters

=over

=item C<obj>

An object.

=back

=head4 Return

A cursor.

=head3 METHOD C<initialize>

Initializes an sorted list with the given size.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<insert>

Inserts the given object into this sorted list (at the end of the list).

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

The object to insert.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head2 CLASS C<Opus10::SortedListAsLinkedList::Cursor>

=head3 Base Classes

=over

=item C<Opus10::OrderedListAsLinkedList::Cursor>

=back

Represents a position in this list.

=head3 METHOD C<initialize>

Initializes a cursor that represents the position
in the given list at the given offset.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<list>

An sorted list.

=item C<offset>

An offset.

=back

=head3 METHOD C<insertAfter>

Not supported.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=head3 METHOD C<insertBefore>

Not supported.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=cut

