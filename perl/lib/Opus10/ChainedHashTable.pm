#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: ChainedHashTable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ChainedHashTable.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::ChainedHashTable
# Hash table implemented as an array of linked lists.
# @attr array The array.
package Opus10::ChainedHashTable;
use Carp;
use Opus10::Declarators;
use Opus10::HashTable;
use Opus10::Array;
use Opus10::LinkedList;
our @ISA = qw(Opus10::HashTable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this hash table with the given size.
# @param self This hash table.
# @param size The size of the hash table.
sub initialize
{
    my ($self, $size) = @_;
    $size = $size || 0;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_array);
    tie (@{$self->{_array}}, qw(Opus10::Array), $size);
    for (my $i = 0; $i < $size; ++$i)
    {
	${$self->{_array}}[$i] = Opus10::LinkedList->new();
    }
}

destructor qw(DESTROY);

# @method getLength
# Returns the length of the chained hash table array.
# @param self This hash table.
# @return The length of the array.
sub getLength
{
    my ($self) = @_;
    return scalar(@{$self->{_array}});
}

# @method purge
# Purges this hash table.
# @param self This hash table.
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < @{$self->{_array}}; ++$i)
    {
	${$self->{_array}}[$i]->purge();
    }
    $self->{_count} = 0;
}
#}>a

#{
# @method insert
# Inserts the given object into this hash table.
# @param self This hash table.
# @param obj An object.
sub insert
{
    my ($self, $obj) = @_;
    ${$self->{_array}}[$self->h($obj)]->append($obj);
    $self->{_count} += 1;
}

# @method withdraw
# Withdraws the given object from this hash table.
# @param self This hash table.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    ${$self->{_array}}[$self->h($obj)]->extract($obj);
    $self->{_count} -= 1;
}
#}>b

#{
# @method find
# Returns the object in this hash table that equals the given object.
# @param self This hash table.
# @param obj An object.
# @return The object in this hash table that equals the given object.
sub find
{
    my ($self, $obj) = @_;
    my $ptr = ${$self->{_array}}[$self->h($obj)]->getHead();
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

# @method contains
# Returns true if the given object is in this hash table.
# @param self This hash table.
# @param obj An object.
# @return True if the given object is in this hash table.
sub contains
{
    my ($self, $obj) = @_;
    my $ptr = ${$self->{_array}}[$self->h($obj)]->getHead();
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

# @method each
# Calls the given visitor function for each object in this chained hash table.
# @param self This hash table.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 0; $i < @{$self->{_array}}; ++$i)
    {
	${$self->{_array}}[$i]->each($visitor);
    }
}

# @method iter
# Returns an iterator that enumerates the objects in this hash table.
# @param self This hash table.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $i = 0; # Iterator state.
    my $ptr = undef; # Iterator state.
    while ($i < @{$self->{_array}})
    {
	$ptr = ${$self->{_array}}[$i]->getHead();
	last if defined($ptr);
	$i += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if (defined($ptr))
	    {
		$result = $ptr->getDatum();
		$ptr = $ptr->getSucc();
		if (!defined($ptr))
		{
		    $i += 1;
		    while ($i < @{$self->{_array}})
		    {
			$ptr = ${$self->{_array}}[$i]->getHead();
			last if defined($ptr);
			$i += 1;
		    }
		}
	    }
	    return $result;
	}
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "ChainedHashTable test program.\n";
    my $hashTable = Opus10::ChainedHashTable->new(57);
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

=head1 MODULE C<Opus10::ChainedHashTable>

=head2 CLASS C<Opus10::ChainedHashTable>

=head3 Base Classes

=over

=item C<Opus10::HashTable>

=back

Hash table implemented as an array of linked lists.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

=back

=head3 METHOD C<contains>

Returns true if the given object is in this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<obj>

An object.

=back

=head4 Return

True if the given object is in this hash table.

=head3 METHOD C<each>

Calls the given visitor function for each object in this chained hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<find>

Returns the object in this hash table that equals the given object.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<obj>

An object.

=back

=head4 Return

The object in this hash table that equals the given object.

=head3 METHOD C<getLength>

Returns the length of the chained hash table array.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head4 Return

The length of the array.

=head3 METHOD C<initialize>

Initializes this hash table with the given size.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<size>

The size of the hash table.

=back

=head3 METHOD C<insert>

Inserts the given object into this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<obj>

An object.

=back

=head3 METHOD C<iter>

Returns an iterator that enumerates the objects in this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

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

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head3 METHOD C<withdraw>

Withdraws the given object from this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<obj>

The object to withdraw.

=back

=cut

