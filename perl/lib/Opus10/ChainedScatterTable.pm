#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: ChainedScatterTable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ChainedScatterTable.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::ChainedScatterTable::Entry
# Represents an entry in a chained scatter table.
# @attr _obj An object.
# @attr _succ Index of the successor.
package Opus10::ChainedScatterTable::Entry;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes the given entry in a chained scatter table
# with the given object and successor index.
# @param self This scatter table.
# @param obj An object.
# @param succ Index of the successor.
sub initialize
{
    my ($self, $obj, $succ) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_obj _succ);
    $self->{_obj} = $obj;
    $self->{_succ} = $succ;
}

destructor qw(DESTROY);

attr_accessor qw(_obj);
attr_accessor qw(_succ);
#}>a

#{
# @class Opus10::ChainedScatterTable
# Chained scatter table implemented using an array.
# @attr array The array.
package Opus10::ChainedScatterTable;
use Carp;
use Opus10::Declarators;
use Opus10::HashTable;
use Opus10::Array;
our @ISA = qw(Opus10::HashTable);

#}>head

our $VERSION = 1.00;

#{
# Used to indicate the end of a chain.
our $NULL = -1;

# @method initialize
# Initializes a chained scatter table with the given size.
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
	    Opus10::ChainedScatterTable::Entry->new(
		undef, $NULL);
    }
}

destructor qw(DESTROY);

# @method getLength
# Returns the length of the chained scatter table array.
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
	    Opus10::ChainedScatterTable::Entry->new(
		undef, $NULL);
    }
    $self->{_count} = 0;
}
#}>c

#{
# @method insert
# Inserts the given object into this scatter table.
# @param self This scatter table.
# @param obj An object.
sub insert
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if $self->{_count} == @{$self->{_array}};
    my $probe = $self->h($obj);
    if (defined(${$self->{_array}}[$probe]->getObj()))
    {
	while (${$self->{_array}}[$probe]->getSucc() != $NULL)
	{
	    $probe = ${$self->{_array}}[$probe]->getSucc();
	}
	my $tail = $probe;
	$probe = ($probe + 1) % $self->getLength();
	while (defined(${$self->{_array}}[$probe]->getObj()))
	{
	    $probe = ($probe + 1) % $self->getLength();
	}
	${$self->{_array}}[$tail]->setSucc($probe);
    }
    ${$self->{_array}}[$probe] =
	Opus10::ChainedScatterTable::Entry->new($obj, $NULL);
    $self->{_count} += 1;
}
#}>d

#{
# @method find
# Returns the object in this chained scatter table
# that equals the given object.
# @param self This scatter table.
# @param obj An object.
# @return The object in this scatter table that equals the given object.
sub find
{
    my ($self, $obj) = @_;
    my $probe = $self->h($obj);
    while ($probe != $NULL)
    {
	if (${$self->{_array}}[$probe]->getObj() == $obj)
	{
	    return ${$self->{_array}}[$probe]->getObj();
	}
	$probe = ${$self->{_array}}[$probe]->getSucc();
    }
    return undef;
}
#}>e

#{
# @method withdraw
# Withdraws the given object from this scatter table.
# @param self This scatter table.
# @param obj The object to withdraw.
sub withdraw {
    my ($self, $obj) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $i = $self->h($obj);
    while ($i != $NULL &&
	    ${$self->{_array}}[$i]->getObj()->isNot($obj)) {
	$i = ${$self->{_array}}[$i]->getSucc();
    }
    croak 'ArgumentError' if $i == $NULL;
    while (1) {
	my $j = ${$self->{_array}}[$i]->getSucc();
	while ($j != $NULL) {
	    my $h = $self->h(${$self->{_array}}[$j]->getObj());
	    my $contained = 0;
	    my $k = ${$self->{_array}}[$i]->getSucc();
	    while ($k != ${$self->{_array}}[$j]->getSucc()
		    && !$contained) {
		$contained = 1 if $k == $h;
		$k = ${$self->{_array}}[$k]->getSucc();
	    }
	    last if !$contained;
	    $j = ${$self->{_array}}[$j]->getSucc();
	}
	last if $j == $NULL;
	${$self->{_array}}[$i]->setObj(
	    ${$self->{_array}}[$j]->getObj());
	$i = $j;
    }
    ${$self->{_array}}[$i] =
	Opus10::ChainedScatterTable::Entry->new(undef, $NULL);
    my $j = ($i + $self->getLength() - 1) % $self->getLength();
    while ($j != $i) {
	if (${$self->{_array}}[$j]->getSucc() == $i) {
	    last if ${$self->{_array}}[$j] == $NULL;
	}
	$j = ($j + $self->getLength() - 1) % $self->getLength();
    }
    $self->{_count} -= 1;
}
#}>f

# @method isFull
# IsFull predicate.
# @param self This scatter table.
# @return True if this scatter table is full.
sub isFull
{
    my ($self) = @_;
    return $self->getCount() == $self->getLength();
}

# @method each
# Calls the given visitor function
# for each object in this chained scatter table.
# @param self This scatter table.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 0; $i < @{$self->{_array}}; ++$i)
    {
	if (defined(${$self->{_array}}[$i]->getObj()))
	{
	    &$visitor(${$self->{_array}}[$i]->getObj());
	}
    }
}

# @method iter
# Returns an iterator that enumerates
# the objects in a chained scatter table.
# @param self This scatter table.
# @return An iterator. 
sub iter
{
    my ($self) = @_;
    my $position = 0; # Iterator state.
    while ($position < @{$self->{_array}})
    {
	last if defined(${$self->{_array}}[$position]->getObj());
	$position += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($position < @{$self->{_array}})
	    {
		$result = ${$self->{_array}}[$position]->getObj();
		$position += 1;
		while ($position < @{$self->{_array}})
		{
		    last if defined(${$self->{_array}}[$position]->getObj());
		    $position += 1;
		}
	    }
	    return $result;
	}
}

# @method contains
# Returns true if the given object is in this scatter table.
# @param self This scatter table.
# @param obj An object.
# @return True if the given object is in this scatter table.
sub contains
{
    my ($self, $obj) = @_;
    my $probe = $self->h($obj);
    while ($probe != $NULL)
    {
	if (${$self->{_array}}[$probe]->getObj()->is($obj))
	{
	    return 1;
	}
	$probe = ${$self->{_array}}[$probe]->getSucc();
    }
    return 0;
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "ChainedScatterTable test program.\n";
    my $hashTable = Opus10::ChainedScatterTable->new(57);
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

=head1 MODULE C<Opus10::ChainedScatterTable>

=head2 CLASS C<Opus10::ChainedScatterTable>

=head3 Base Classes

=over

=item C<Opus10::HashTable>

=back

Chained scatter table implemented using an array.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

=back

=head3 METHOD C<contains>

Returns true if the given object is in this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=back

=head4 Return

True if the given object is in this scatter table.

=head3 METHOD C<each>

Calls the given visitor function
for each object in this chained scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<find>

Returns the object in this chained scatter table
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

=head3 METHOD C<getLength>

Returns the length of the chained scatter table array.

=head4 Parameters

=over

=item C<self>

This scatter table.

=back

=head4 Return

The length of the array.

=head3 METHOD C<initialize>

Initializes a chained scatter table with the given size.

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
the objects in a chained scatter table.

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

Zero on success; non-zero on failure.

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

=head2 CLASS C<Opus10::ChainedScatterTable::Entry>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents an entry in a chained scatter table.

=head3 ATTRIBUTES

=over

=item C<_obj>

An object.

=item C<_succ>

Index of the successor.

=back

=head3 METHOD C<initialize>

Initializes the given entry in a chained scatter table
with the given object and successor index.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

An object.

=item C<succ>

Index of the successor.

=back

=cut

