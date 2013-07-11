#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: SetAsBitVector.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SetAsBitVector.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SetAsBitVector
# Set implemented using a bit vector.
# @attr _vector The bit vector.
package Opus10::SetAsBitVector;
use Carp;
use Opus10::Declarators;
use Opus10::Set;
use Opus10::Array;
our @ISA = qw(Opus10::Set);

#}>head

our $VERSION = 1.00;

#{
use constant BITS => 32;

# @method initialize
# Initializes this set with the given universal set size.
# @param self This set.
# @param n The universe size.
sub initialize
{
    my ($self, $n) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($n);
    $self->declare qw(_vector);
    my $length = int(($n + BITS - 1) / BITS);
    tie (@{$self->{_vector}}, 'Opus10::Array', $length);
    for (my $i = 0; $i < $length; ++$i)
    {
	${$self->{_vector}}[$i] = 0;
    }
}

destructor qw(DESTROY);

# The bit vector.
attr_accessor qw(_vector);
#}>a

#{
# @method insert
# Inserts the given item into this set.
# @param self This set.
# @param item An integer.
sub insert
{
    my ($self, $item) = @_;
    ${$self->{_vector}}[$item / BITS] |= (1 << ($item % BITS));
}

# @method withdraw
# Withdraws the given item from this set.
# @param self This set.
# @param item An integer.
sub withdraw
{
    my ($self, $item) = @_;
    ${$self->{_vector}}[$item / BITS] &= ~(1 << ($item % BITS));
}

# @method contains
# True if the given item is in this set.
# @param self This set.
# @param item An integer.
sub contains
{
    my ($self, $item) = @_;
    return ${$self->{_vector}}[$item / BITS] &
	(1 << ($item % BITS));
}
#}>b

#{
# @method union
# Set union operator.
# Returns the union of this set and the given set.
# @param self This set.
# @param set The set to add to this set.
# @return The union.
sub union
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::SetAsBitVector->new($n);
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	${$result->{_vector}}[$i] =
	    ${$self->{_vector}}[$i] | ${$set->{_vector}}[$i];
    }
    return $result;
}
#}>c

#{
# @method intersection
# Set intersection operator.
# Returns the intersection of this set and the given set.
# @param self This set.
# @param set The set to intersect with this set.
# @return The intersection.
sub intersection
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::SetAsBitVector->new($n);
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	${$result->{_vector}}[$i] =
	    ${$self->{_vector}}[$i] & ${$set->{_vector}}[$i];
    }
    return $result;
}
#}>d

#{
# @method difference
# Set difference operator.
# Returns the difference of this set and the given set.
# @param self This set.
# @param set The set to subtract from this set.
# @return The difference.
sub difference
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::SetAsBitVector->new($n);
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	${$result->{_vector}}[$i] =
	    ${$self->{_vector}}[$i] & ~${$set->{_vector}}[$i];
    }
    return $result;
}
#}>e

# @method isEqualTo
# Set equality operator.
# Returns true if this set equals the given set.
# @param self This set.
# @param set The set to compare with this set.
# @return True if this set equals the given set.
sub isEqualTo
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	if (${$self->{_vector}}[$i] == ${$set->{_vector}}[$i])
	{
	    return 0;
	}
    }
    return 1;
}

# @method isSubsetOf
# Subset operator.
# Returns true if this set is a subset of the given set.
# @param self This set.
# @param set The set to compare with this set.
# @return True if this set is a subset of the given set.
sub isSubsetOf
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	if ((${$self->{_vector}}[$i] & ~${$set->{_vector}}[$i]) != 0)
	{
	    return 0;
	}
    }
    return 1;
}

# @method isEmpty
# Returns true if this set is empty.
# @param self This set.
# @return True if this set is empty.
sub isEmpty
{
    my ($self) = @_;
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	if (${$self->{_vector}}[$i] != 0)
	{
	    return 0;
	}
    }
    return 1;
}

# @method isFull
# True if this set is full.
# @param self This set.
# @return True if this set is full.
sub isFull
{
    my ($self) = @_;
    my $div = int($self->{_universeSize} / BITS);
    my $rem = $self->{_universeSize} % BITS;
    for (my $i = 0; $i < $div; ++$i)
    {
	if (${$self->{_vector}}[$i] != -1)
	{
	    return 0;
	}
    }
    if ($rem > 0)
    {
	my $mask = (1 << $rem) - 1;
	if (${$self->{_vector}}[$div] != $mask)
	{
	    return 0;
	}
    }
    return 1;
}

# @method purge
# Purges this set.
# @param self This set.
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < @{$self->{_vector}}; ++$i)
    {
	${$self->{_vector}}[$i] = 0;
    }
}

# @method each
# Calls the given visitor function for each object in this set.
# @param self This set.
# @param visitor A visitor method.
sub each
{
    my ($self, $visitor) = @_;
    for (my $item = 0; $item < $self->{_universeSize}; ++$item)
    {
	if ($self->contains($item))
	{
	    &$visitor($item);
	}
    }
}

# @method getCount
# Returns the number of items in this set.
# @param self This set.
# @return The number of items in this set.
sub getCount
{
    my ($self) = @_;
    my $result = 0;
    for (my $item = 0; $item < $self->{_universeSize}; ++$item)
    {
	if ($self->contains($item))
	{
	    $result += 1;
	}
    }
    return $result;
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "SetAsBitVector test program.\n";
    Opus10::Set::test(
	Opus10::SetAsBitVector->new(57),
	Opus10::SetAsBitVector->new(57),
	Opus10::SetAsBitVector->new(57));
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

=head1 MODULE C<Opus10::SetAsBitVector>

=head2 CLASS C<Opus10::SetAsBitVector>

=head3 Base Classes

=over

=item C<Opus10::Set>

=back

Set implemented using a bit vector.

=head3 ATTRIBUTES

=over

=item C<_vector>

The bit vector.

=back

=head3 METHOD C<contains>

True if the given item is in this set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<item>

An integer.

=back

=head3 METHOD C<difference>

Set difference operator.
Returns the difference of this set and the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

The set to subtract from this set.

=back

=head4 Return

The difference.

=head3 METHOD C<each>

Calls the given visitor function for each object in this set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<visitor>

A visitor method.

=back

=head3 METHOD C<getCount>

Returns the number of items in this set.

=head4 Parameters

=over

=item C<self>

This set.

=back

=head4 Return

The number of items in this set.

=head3 METHOD C<initialize>

Initializes this set with the given universal set size.

=head4 Parameters

=over

=item C<self>

This set.

=item C<n>

The universe size.

=back

=head3 METHOD C<insert>

Inserts the given item into this set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<item>

An integer.

=back

=head3 METHOD C<intersection>

Set intersection operator.
Returns the intersection of this set and the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

The set to intersect with this set.

=back

=head4 Return

The intersection.

=head3 METHOD C<isEmpty>

Returns true if this set is empty.

=head4 Parameters

=over

=item C<self>

This set.

=back

=head4 Return

True if this set is empty.

=head3 METHOD C<isEqualTo>

Set equality operator.
Returns true if this set equals the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

The set to compare with this set.

=back

=head4 Return

True if this set equals the given set.

=head3 METHOD C<isFull>

True if this set is full.

=head4 Parameters

=over

=item C<self>

This set.

=back

=head4 Return

True if this set is full.

=head3 METHOD C<isSubsetOf>

Subset operator.
Returns true if this set is a subset of the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

The set to compare with this set.

=back

=head4 Return

True if this set is a subset of the given set.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this set.

=head4 Parameters

=over

=item C<self>

This set.

=back

=head3 METHOD C<union>

Set union operator.
Returns the union of this set and the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

The set to add to this set.

=back

=head4 Return

The union.

=head3 METHOD C<withdraw>

Withdraws the given item from this set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<item>

An integer.

=back

=cut

