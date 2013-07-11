#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: HashTable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: HashTable.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::HashTable
# Abstract base class from which all hash table classes are derived.
package Opus10::HashTable;
use Opus10::Declarators;
use Opus10::SearchableContainer;
our @ISA = qw(Opus10::SearchableContainer);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this hash table.
# @param self This hash table.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method getLength
# Length getter.
# @param self This hash table.
# @return The length of this hash table.
abstract_method qw(getLength);

# @method loadFactor
# Return the load factor of this hash table.
# @param self This hash table.
# @return The load factor.
sub loadFactor
{
    my ($self) = @_;
    return 1.0 * $self->getCount() / $self->getLength();
}
#}>a

#{
# @method f
# Return the hash of the given object.
# @param self This hash table.
# @return An integer.
sub f
{
    my ($self, $obj) = @_;
    return $obj->hash();
}

# @method g
# Hashes an integer using the division method.
# @param self This hash table.
# @param x An integer.
# @return An integer.
sub g
{
    my ($self, $x) = @_;
    return abs($x) % $self->getLength();
}

# @method h
# Composition of g and f.
# @param obj The object to hash.
# @return An integer.
sub h
{
    my ($self, $obj) = @_;
    return $self->g($self->f($obj));
}
#}>b

use Opus10::Association;
use Opus10::Box;

# @function test
# HashTable test function.
# @param hash table The hash table to test.
sub test
{
    my ($hashTable) = @_;
    printf "HashTable test program.\n";
    printf "%s\n", $hashTable;
    $hashTable->insert(Opus10::Association->new(box("foo"), box(12)));
    $hashTable->insert(Opus10::Association->new(box("bar"), box(34)));
    $hashTable->insert(Opus10::Association->new(box("foo"), box(56)));
    printf "%s\n", $hashTable;
    my $obj = $hashTable->find(Opus10::Association->new(box("foo")));
    printf "%s\n", $obj;
    $hashTable->withdraw($obj);
    printf "%s\n", $hashTable;
    printf "Using each\n";
    $hashTable->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $hashTable->iter();
    while (defined(my $obj = $iter->()))
    {
	printf "%s\n", $obj;
    }
    $hashTable->purge();
    printf "%s\n", $hashTable;
}

1;
__DATA__

=head1 MODULE C<Opus10::HashTable>

=head2 CLASS C<Opus10::HashTable>

=head3 Base Classes

=over

=item C<Opus10::SearchableContainer>

=back

Abstract base class from which all hash table classes are derived.

=head3 METHOD C<f>

Return the hash of the given object.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head4 Return

An integer.

=head3 METHOD C<g>

Hashes an integer using the division method.

=head4 Parameters

=over

=item C<self>

This hash table.

=item C<x>

An integer.

=back

=head4 Return

An integer.

=head3 METHOD C<getLength>

Length getter.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head4 Return

The length of this hash table.

=head3 METHOD C<h>

Composition of g and f.

=head4 Parameters

=over

=item C<obj>

The object to hash.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head3 METHOD C<loadFactor>

Return the load factor of this hash table.

=head4 Parameters

=over

=item C<self>

This hash table.

=back

=head4 Return

The load factor.

=head3 FUNCTION C<test>

HashTable test function.

=head4 Parameters

=over

=item C<hash>

table The hash table to test.

=back

=cut

