#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: OpenScatterTable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: OpenScatterTable.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::OpenScatterTable::Entry
# Represents an entry in a open scatter table.
# @attr _state A state.
# @attr _obj An object.
package Opus10::OpenScatterTable::Entry;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes the given entry in a open scatter table
# with the given object and state.
# @param self This scatter table.
# @param state A state.
# @param obj An object.
sub initialize
{
    my ($self, $state, $obj) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_obj _state);
    $self->{_state} = $state;
    $self->{_obj} = $obj;
}

destructor qw(DESTROY);

attr_accessor qw(_state);
attr_accessor qw(_obj);
#}>a

#{
# @class Opus10::OpenScatterTable
# Open scatter table implemented using an array.
# @attr array The array.
package Opus10::OpenScatterTable;
use Carp;
use Opus10::Declarators;
use Opus10::HashTable;
use Opus10::Array;
our @ISA = qw(Opus10::HashTable);

#}>head

our $VERSION = 1.00;

#{
# Used to indicate the } of a chain.
our $EMPTY = 0;
our $OCCUPIED = 1;
our $DELETED = 2;

# @method initialize
# Initializes a open scatter table with the given size.
# @param self This scatter table.
# @param size The size of the hash table.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array);
    tie (@{$self->{_array}}, qw(Opus10::Array), $size);
    for (my $i = 0; $i < $size; ++$i)
    {
	${$self->{_array}}[$i] =
	    Opus10::OpenScatterTable::Entry->new(
		$EMPTY, undef);
    }
}

destructor qw(DESTROY);

# @method getLength
# Returns the length of the open scatter table array.
# @param self This scatter table.
# @return The length of the array.
sub getLength
{
    my ($self) = @_;
    return scalar(@{$self->{_array}});
}
#}>b

#{
# @method purge
# Purges this scatter table.
# @param self This scatter table.
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < @{$self->{_array}}; ++$i)
    {
	${$self->{_array}}[$i] =
	    Opus10::OpenScatterTable::Entry->new(
		$EMPTY, undef);
    }
    $self->{_count} = 0;
}
#}>c

#{
# @method c
# The probing sequence function.
# @param self This scatter table.
# @param i The probe number.
# @return The position to probe.
sub c
{
    my ($self, $i) = @_;
    return $i;
}

# @method findUnoccupied
# Returns the index of an unoccupied entry
# where the given object may be inserted.
# The state of an unoccupied entry is either EMPTY or DELETED.
# @param self This scatter table.
# @param obj The object to be inserted.
# @return The index of an unoccupied entry.
sub findUnoccupied
{
    my ($self, $obj) = @_;
    my $hash = $self->h($obj);
    for (my $i = 0; $i < $self->getLength(); ++$i)
    {
	my $probe = ($hash + $self->c($i)) % $self->getLength();
	if (${$self->{_array}}[$probe]->getState() != $OCCUPIED)
	{
	    return $probe;
	}
    }
    croak 'ContainerFull';
}

# @method insert
# Inserts the given object into this scatter table.
# @param self This scatter table.
# @param obj An object.
sub insert
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if $self->{_count} == $self->getLength();
    my $offset = $self->findUnoccupied($obj);
    ${$self->{_array}}[$offset] =
	Opus10::OpenScatterTable::Entry->new($OCCUPIED, $obj);
    $self->{_count} += 1;
}
#}>d

#{
# @method findMatch
# Returns the index of the entry that contains an object
# that equals the given object.
# @param self This scatter table.
# @param obj An object.
# @return The index of the entry that contains a match.
sub findMatch
{
    my ($self, $obj) = @_;
    my $hash = $self->h($obj);
    for (my $i = 0; $i < $self->getLength(); ++$i)
    {
	my $probe = ($hash + $self->c($i)) % $self->getLength();
	last if ${$self->{_array}}[$probe]->getState() == $EMPTY;
	if (${$self->{_array}}[$probe]->getState() == $OCCUPIED
	    && ${$self->{_array}}[$probe]->getObj() == $obj)
	{
	    return $probe;
	}
    }
    return -1;
}

# @method find
# Returns the object in this scatter table
# that equals the given object.
# @param self This scatter table.
# @param obj An object.
# @return The object in this scatter table that equals the given object.
sub find
{
    my ($self, $obj) = @_;
    my $offset = $self->findMatch($obj);
    if ($offset >= 0)
    {
	return ${$self->{_array}}[$offset]->getObj();
    }
    else
    {
	return undef;
    }
}
#}>e

#{
# @method withdraw
# Withdraws the given object from this scatter table.
# @param self This scatter table.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $offset = $self->findInstance($obj);
    croak 'ArgumentError' if $offset < 0;
    ${$self->{_array}}[$offset] =
	Opus10::OpenScatterTable::Entry->new($DELETED, undef);
    $self->{_count} -= 1;
}
#}>f

# @method findInstance
# Returns the index of the entry that contains the given object instance.
# @param self This scatter table.
# @param obj An object.
# @return The index of the entry that contains the given instance.
sub findInstance
{
    my ($self, $obj) = @_;
    my $hash = $self->h($obj);
    for (my $i = 0; $i < $self->getLength(); ++$i)
    {
	my $probe = ($hash + $self->c($i)) % $self->getLength();
	last if ${$self->{_array}}[$probe]->getState() == $EMPTY;
	if (${$self->{_array}}[$probe]->getState() == $OCCUPIED
	    && ${$self->{_array}}[$probe]->getObj()->is($obj))
	{
	    return $probe;
	}
    }
    return -1;
}

# @method isFull
# IsFull predicate.
# @param self This scatter table.
# @return True if this scatter table is full.
sub isFull
{
    my ($self) = @_;
    return $self->{_count} == $self->getLength();
}

# @method each
# Calls the given visitor function
# for each object in this open scatter table.
# @param self This scatter table.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 0; $i < $self->getLength(); ++$i)
    {
	if (${$self->{_array}}[$i]->getState() == $OCCUPIED)
	{
	    &$visitor(${$self->{_array}}[$i]->getObj())
	}
    }
}

# @method iter
# Returns an iterator that enumerates
# the object contained in an open scatter table.
# @param self This scatter table.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $position = 0; # Iterator state.
    while ($position < @{$self->{_array}})
    {
	last if ${$self->{_array}}[$position]->getState() ==
	    $OCCUPIED;
	$position += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($position < @{$self->{_array}})
	    {
		$result =
		    ${$self->{_array}}[$position]->getObj();
		$position += 1;
		while ($position < @{$self->{_array}})
		{
		    last if ${$self->{_array}}[$position]->
			getState() == $OCCUPIED;
		    $position += 1;
		}
	    }
	    return $result;
	}
}

# @method contains
# True if the given object is in this scatter table.
# @param self This scatter table.
# @param obj An object.
# @return True if this scatter table contains the given object.
sub contains
{
    my ($self, $obj) = @_;
    return $self->findInstance($obj) >= 0;
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on stateess; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "OpenScatterTable test program.\n";
    my $hashTable = Opus10::OpenScatterTable->new(57);
    Opus10::HashTable::test($hashTable);
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

=head1 MODULE C<Opus10::OpenScatterTable>

=head2 CLASS C<Opus10::OpenScatterTable>

=head3 Base Classes

=over

=item C<Opus10::HashTable>

=back

Open scatter table implemented using an array.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

=back

=head3 METHOD C<c>

The probing sequence function.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<i>

The probe number.

=back

=head4 Return

The position to probe.

=head3 METHOD C<contains>

True if the given object is in this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head4 Return

True if this scatter table contains the given object.

=head3 METHOD C<each>

Calls the given visitor function
for each object in this open scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<find>

Returns the object in this scatter table
that equals the given object.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head4 Return

The object in this scatter table that equals the given object.

=head3 METHOD C<findInstance>

Returns the index of the entry that contains the given object instance.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head4 Return

The index of the entry that contains the given instance.

=head3 METHOD C<findMatch>

Returns the index of the entry that contains an object
that equals the given object.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head4 Return

The index of the entry that contains a match.

=head3 METHOD C<findUnoccupied>

Returns the index of an unoccupied entry
where the given object may be inserted.
The state of an unoccupied entry is either EMPTY or DELETED.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

The object to be inserted.

=back

=head4 Return

The index of an unoccupied entry.

=head3 METHOD C<getLength>

Returns the length of the open scatter table array.

=head4 Parameters

=over

=item C<self>

This scatter table.

=back

=head4 Return

The length of the array.

=head3 METHOD C<initialize>

Initializes a open scatter table with the given size.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<size>

The size of the hash table.

=back

=head3 METHOD C<insert>

Inserts the given object into this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This scatter table.

=back

=head4 Return

True if this scatter table is full.

=head3 METHOD C<iter>

Returns an iterator that enumerates
the object contained in an open scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=back

=head4 Return

An iterator.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on stateess; non-zero on failure.

=head3 METHOD C<purge>

Purges this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

The object to withdraw.

=back

=head2 CLASS C<Opus10::OpenScatterTable::Entry>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents an entry in a open scatter table.

=head3 ATTRIBUTES

=over

=item C<_obj>

An object.

=item C<_state>

A state.

=back

=head3 METHOD C<initialize>

Initializes the given entry in a open scatter table
with the given object and state.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<state>

A state.

=item C<obj>

An object.

=back

=cut

