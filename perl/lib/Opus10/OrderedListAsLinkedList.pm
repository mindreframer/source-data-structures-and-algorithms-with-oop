#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: OrderedListAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: OrderedListAsLinkedList.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::OrderedListAsLinkedList::Cursor
# Represents a position in this list.
# @attr _list An ordered list.
# @attr _element A list element.
package Opus10::OrderedListAsLinkedList::Cursor;
use Carp;
use Opus10::Declarators;
use Opus10::Cursor;
our @ISA = qw(Opus10::Cursor);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a cursor that represents the position
# in the given list at the given list element.
# @param self This cursor.
# @param list An ordered list.
# @param element A list element.
sub initialize
{
    my ($self, $list, $element) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_list _element);
    $self->{_list} = $list;
    $self->{_element} = $element;
}

destructor qw(DESTROY);

# @method getDatum
# Returns the object at this position.
# @param self This cursor.
# @return The object at this position.
sub getDatum
{
    my ($self) = @_;
    return $self->{_element}->getDatum();
}
#}>f

# @method insertAfter
# Inserts the given object in the list after this position.
# @param self This cursor.
# @param obj The object to insert.
sub insertAfter
{
    my ($self, $obj) = @_;
    $self->{_element}->insertAfter($obj);
    $self->{_list}->setCount($self->{_list}->getCount() + 1);
}
#}>g

# @method insertBefore
# Inserts the given object in the list before this position.
# @param self This cursor.
# @param obj The object to insert.
sub insertBefore
{
    my ($self, $obj) = @_;
    $self->{_element}->insertBefore($obj);
    $self->{_list}->setCount($self->{_list}->getCount() + 1);
}

#{
# @method withdraw
# Withdraws from the list the object at this position.
# @param self This cursor.
sub withdraw
{
    my ($self) = @_;
    $self->{_list}->getLinkedList()->extract(
	$self->{_element}->getDatum());
    $self->{_list}->setCount($self->{_list}->getCount() - 1);
}
#}>h

#{
# @class Opus10::OrderedListAsLinkedList
# An ordered list implemented using a linked list.
# @attr linkedList The linked list.
package Opus10::OrderedListAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedList;
use Opus10::LinkedList;
our @ISA = qw(Opus10::OrderedList);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an ordered list.
# @param self This queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_linkedList);
    $self->{_linkedList} = Opus10::LinkedList->new();
}

destructor qw(DESTROY);

attr_reader qw(_linkedList);
#}>a

# @method setCount
# Count setter.
# @param self This ordered list.
# @param value The new value.
sub setCount
{
    my ($self, $value) = @_;
    $self->{_count} = $value;
}

#{
# @method insert
# Inserts the given object into this ordered list (at the end of the list).
# @param self This ordered list.
# @param obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    $self->{_linkedList}->append($obj);
    $self->{_count} += 1;
}
#}>b

#{
# @method contains
# Returns true if the given object is in this ordered list.
# @param self This ordered list.
# @param obj An object.
# @return True if the given object is in this ordered list.
sub contains
{
    my ($self, $obj) = @_;
    my $ptr = $self->{_linkedList}->getHead();
    while (defined($ptr))
    {
	if ($ptr->getDatum()->is($obj))
	{
	    return 1;
	}
	$ptr = $ptr->getSucc();
    }
    return 0;
}

# @method find
# Returns an object in this ordered list that is equal to the given object.
# @param self This ordered list.
# @param obj An object.
# @return An object in this ordered list that is equal to the given object.
sub find
{
    my ($self, $obj) = @_;
    my $ptr = $self->{_linkedList}->getHead();
    while (defined($ptr))
    {
	if ($ptr->getDatum() == $obj)
	{
	    return $ptr->getDatum();
	}
	$ptr = $ptr->getSucc();
    }
    return undef;
}
#}>c

#{
# @method withdraw
# Withdraws the given object from this ordered list.
# @param self This ordered list.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    $self->{_linkedList}->extract($obj);
    $self->{_count} -= 1;
}
#}>d

#{
# @method findPosition
# Returns a cursor that represents the position in this list
# of an object equal to the given object.
# @param obj An object.
# @return A cursor.
sub findPosition
{
    my ($self, $obj) = @_;
    my $ptr = $self->{_linkedList}->getHead();
    while (defined($ptr))
    {
	last if ($ptr->getDatum() == $obj);
	$ptr = $ptr->getSucc();
    }
    return Opus10::OrderedListAsLinkedList::Cursor->new(
	$self, $ptr);
}

# @method getItem
# Returns the object in this list at the given offset.
# @param self This ordered list.
# @param offset An offset.
# @return The object at the given offset.
sub getItem
{
    my ($self, $offset) = @_;
    croak 'IndexError'
	if $offset < 0 || $offset >= $self->{_count};
    return ${$self->{_linkedList}}[$offset];

    my $ptr = $self->{_linkedList}->getHead();
    my $i = 0;
    while ($i < $offset && defined($ptr))
    {
	$ptr = $ptr->getSucc();
	$i += 1;
    }
    return $ptr->getDatum();
}
#}>e

# @method each
# Calls the given visitor function
# for each object in this ordered list.
# @param self This ordered list.
# @param visitor A function.
sub each
{
    my ($self, $visitor) = @_;
    $self->{_linkedList}->each($visitor);
}

# @method iter
# Returns an iterator that enumerates
# the object in this ordered list.
# @param self This ordered list.
sub iter
{
    my ($self) = @_;
    my $position = $self->{_linkedList}->getHead(); # Iterator state
    return
	sub
	{
	    my $result = undef;
	    if (defined($position))
	    {
		$result = $position->getDatum();
		$position = $position->getSucc();
	    }
	    return $result;
	}
}

# @method purge
# Purges this ordered list.
# @param self This ordered list.
sub purge
{
    my ($self) = @_;
    $self->{_linkedList} = Opus10::LinkedList->new();
    $self->{_count} = 0;
}

# @method isFull
# IsFull predicate.
# @param self This ordered list.
# @return True if this list is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_linkedList}};
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "OrderedListAsLinkedList test program.\n";
    my $list = Opus10::OrderedListAsLinkedList->new();
    Opus10::OrderedList::test($list);
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

=head1 MODULE C<Opus10::OrderedListAsLinkedList>

=head2 CLASS C<Opus10::OrderedListAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::OrderedList>

=back

An ordered list implemented using a linked list.

=head3 ATTRIBUTES

=over

=item C<linkedList>

The linked list.

=back

=head3 METHOD C<contains>

Returns true if the given object is in this ordered list.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<obj>

An object.

=back

=head4 Return

True if the given object is in this ordered list.

=head3 METHOD C<each>

Calls the given visitor function
for each object in this ordered list.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<visitor>

A function.

=back

=head3 METHOD C<find>

Returns an object in this ordered list that is equal to the given object.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<obj>

An object.

=back

=head4 Return

An object in this ordered list that is equal to the given object.

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

=head3 METHOD C<getItem>

Returns the object in this list at the given offset.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<offset>

An offset.

=back

=head4 Return

The object at the given offset.

=head3 METHOD C<initialize>

Initializes an ordered list.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<insert>

Inserts the given object into this ordered list (at the end of the list).

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<obj>

The object to insert.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This ordered list.

=back

=head4 Return

True if this list is full.

=head3 METHOD C<iter>

Returns an iterator that enumerates
the object in this ordered list.

=head4 Parameters

=over

=item C<self>

This ordered list.

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

=head3 METHOD C<purge>

Purges this ordered list.

=head4 Parameters

=over

=item C<self>

This ordered list.

=back

=head3 METHOD C<setCount>

Count setter.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<value>

The new value.

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this ordered list.

=head4 Parameters

=over

=item C<self>

This ordered list.

=item C<obj>

The object to withdraw.

=back

=head2 CLASS C<Opus10::OrderedListAsLinkedList::Cursor>

=head3 Base Classes

=over

=item C<Opus10::Cursor>

=back

Represents a position in this list.

=head3 ATTRIBUTES

=over

=item C<_element>

A list element.

=item C<_list>

An ordered list.

=back

=head3 METHOD C<getDatum>

Returns the object at this position.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=head4 Return

The object at this position.

=head3 METHOD C<initialize>

Initializes a cursor that represents the position
in the given list at the given list element.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<list>

An ordered list.

=item C<element>

A list element.

=back

=head3 METHOD C<insertAfter>

Inserts the given object in the list after this position.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<obj>

The object to insert.

=back

=head3 METHOD C<insertBefore>

Inserts the given object in the list before this position.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<obj>

The object to insert.

=back

=head3 METHOD C<withdraw>

Withdraws from the list the object at this position.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=cut

