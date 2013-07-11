#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: OrderedListAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: OrderedListAsArray.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::OrderedListAsArray::Cursor
# Represents a position in this list.
# @attr _list An ordered list.
# @attr _offset An offset.
package Opus10::OrderedListAsArray::Cursor;
use Carp;
use Opus10::Declarators;
use Opus10::Cursor;
our @ISA = qw(Opus10::Cursor);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a cursor that represents the position
# in the given list at the given offset.
# @param self This cursor.
# @param list An ordered list.
# @param offset An offset.
sub initialize
{
    my ($self, $list, $offset) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_list _offset);
    $self->{_list} = $list;
    $self->{_offset} = $offset;
}

destructor qw(DESTROY);

# @method getDatum
# Returns the object at this position.
# @param self This cursor.
# @return The object at this position.
sub getDatum
{
    my ($self) = @_;
    croak 'IndexError' if $self->{_offset} < 0 ||
	$self->{_offset} >= $self->{_list}->getCount();
    return ${$self->{_list}->getArray()}[$self->{_offset}];
}
#}>f

# @method insertAfter
# Inserts the given object in the list after this position.
# @param self This cursor.
# @param obj The object to insert.
sub insertAfter
{
    my ($self, $obj) = @_;
    croak 'IndexError' if $self->{_offset} < 0 ||
	$self->{_offset} >= $self->{_list}->getCount();
    croak 'ContainerFull' if $self->{_list}->getCount() ==
	@{$self->{_list}->getArray()};
    my $insertPosition = $self->{_offset} + 1;
    my $i = $self->{_list}->getCount();
    while ($i > $insertPosition)
    {
	${$self->{_list}->getArray()}[$i] =
	    ${$self->{_list}->getArray()}[$i - 1];
	$i -= 1;
    }
    ${$self->{_list}->getArray()}[$insertPosition] = $obj;
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
    croak 'IndexError' if $self->{_offset} < 0 ||
	$self->{_offset} >= $self->{_list}->getCount();
    croak 'ContainerFull' if $self->{_list}->getCount() ==
	@{$self->{_list}->getArray()};
    my $insertPosition = $self->{_offset};
    my $i = $self->{_list}->getCount();
    while ($i > $insertPosition)
    {
	${$self->{_list}->getArray()}[$i] =
	    ${$self->{_list}->getArray()}[$i - 1];
	$i -= 1;
    }
    ${$self->{_list}->getArray()}[$insertPosition] = $obj;
    $self->{_list}->setCount($self->{_list}->getCount() + 1);
    $self->{_offset} += 1;
}

#{
# @method withdraw
# Withdraws from the list the object at this position.
# @param self This cursor.
sub withdraw
{
    my ($self) = @_;
    croak 'IndexError' if $self->{_offset} < 0 ||
	$self->{_offset} >= $self->{_list}->getCount();
    croak 'ContainerEmpty' if $self->{_list}->getCount() == 0;
    my $i = $self->{_offset};
    while ($i < $self->{_list}->getCount() - 1)
    {
	${$self->{_list}->getArray()}[$i] = 
	    ${$self->{_list}->getArray()}[$i + 1];
	$i += 1;
    }
    ${$self->{_list}->getArray()}[$i] = undef;
    $self->{_list}->setCount($self->{_list}->getCount() - 1);
}
#}>h

#{
# @class Opus10::OrderedListAsArray
# An ordered list implemented using an array.
# @attr array The array.
package Opus10::OrderedListAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedList;
use Opus10::Array;
our @ISA = qw(Opus10::OrderedList);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an ordered list with the given size.
# @param size The size of the list.
# @param self This queue.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array);
    tie (@{$self->{_array}}, 'Opus10::Array', $size);
}

destructor qw(DESTROY);

attr_reader qw(_array);
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
    croak 'ContainerFull'
	if @{$self->{_array}} == $self->{_count};
    ${$self->{_array}}[$self->{_count}] = $obj;
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
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	if (${$self->{_array}}[$i]->is($obj))
	{
	    return 1;
	}
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
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	if (${$self->{_array}}[$i] == $obj)
	{
	    return ${$self->{_array}}[$i];
	}
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
    my $i = 0;
    while ($i < $self->{_count} &&
	${$self->{_array}}[$i]->isNot($obj))
    {
	$i += 1;
    }
    croak 'ArgumentError' if $i == $self->{_count};
    while ($i < $self->{_count} - 1)
    {
	${$self->{_array}}[$i] = ${$self->{_array}}[$i + 1];
	$i += 1;
    }
    ${$self->{_array}}[$i] = undef;
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
    my $i = 0;
    while ($i < $self->{_count} &&
	${$self->{_array}}[$i] != $obj)
    {
	$i += 1;
    }
    return Opus10::OrderedListAsArray::Cursor->new($self, $i);
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
    return ${$self->{_array}}[$offset];
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
    for (my $i = 0; $i < $self->{_count}; ++$i)
    {
	&$visitor(${$self->{_array}}[$i]);
    }
}

# @method iter
# Returns an iterator that enumerates
# the object in this ordered list.
# @param self This ordered list.
sub iter
{
    my ($self) = @_;
    my $position = 0; # Iterator state
    return
	sub
	{
	    my $result = undef;
	    if ($position < $self->{_count})
	    {
		$result = ${$self->{_array}}[$position];
		$position += 1;
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
    while ($self->{_count} > 0)
    {
	$self->{_count} -= 1;
	${$self->{_array}}[$self->{_count}] = undef;
    }
}

# @method isFull
# IsFull predicate.
# @param self This ordered list.
# @return True if this list is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == @{$self->{_array}};
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "OrderedListAsArray test program.\n";
    my $list = Opus10::OrderedListAsArray->new(10);
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

=head1 MODULE C<Opus10::OrderedListAsArray>

=head2 CLASS C<Opus10::OrderedListAsArray>

=head3 Base Classes

=over

=item C<Opus10::OrderedList>

=back

An ordered list implemented using an array.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

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

Initializes an ordered list with the given size.

=head4 Parameters

=over

=item C<size>

The size of the list.

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

=head2 CLASS C<Opus10::OrderedListAsArray::Cursor>

=head3 Base Classes

=over

=item C<Opus10::Cursor>

=back

Represents a position in this list.

=head3 ATTRIBUTES

=over

=item C<_list>

An ordered list.

=item C<_offset>

An offset.

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
in the given list at the given offset.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<list>

An ordered list.

=item C<offset>

An offset.

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

