#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: Set.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Set.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Set
# Abstract base class from which all set classes are derived.
# @attr _universeSize The size of the universal set.
package Opus10::Set;
use Opus10::Declarators;
use Opus10::SearchableContainer;
our @ISA = qw(Opus10::SearchableContainer);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this set with the given universal set size.
# @param universeSize The size of the universal set.
# @method initialize
# @param self This set.
# @param size The size of the universal set.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_universeSize);
    $self->{_universeSize} = $size;
}

destructor qw(DESTROY);

# The size of the universal set.
attr_reader qw(_universeSize);

# method union
# Union operator.
# Returns the union of this set and the given set.
# @param self This set.
# @param set A set.
# @return The union.
abstract_method qw(union);

# @method intersection
# Intersection operator.
# Returns the intersection of this set and the given set.
# @param self This set.
# @param set A set.
# @return The intersection.
abstract_method qw(intersection);

# @method difference
# Difference operator.
# Returns the difference of this set and the given set.
# @param self This set.
# @param set A set.
# @return The difference.
abstract_method qw(difference);

# @method isEqualTo
# Equality operator.
# Returns true if this set equals the given set.
# @param self This set.
# @param set A set.
# @return True if this set equals the given set.
abstract_method qw(isEqualTo);

# @method isSubsetOf
# Subset operator.
# Returns true if this set is a subset of the given set.
# @param self This set.
# @param set A set.
# @return True if this set is a subset of the given set.
abstract_method qw(isSubsetOf);

# @method isProperSubsetOf
# Proper subset operator.
# Returns true if this set is a proper subset of the given set.
# @param self This set.
# @param set A set.
# @return True if this set is a proper subset of the given set.
sub isProperSubsetOf
{
    my ($self, $set) = @_;
    return $self->isSubsetOf($set) && !$self->isEqualTo($set);
}
#}>a

#{
# @function order
# Returns the first two arguments in the order specified by the third argument.
# @param x A value.
# @param y A value.
# @param reversed True if x and y should be reversed.
# @return Either (y, x) or (x, y).
sub order
{
    my ($x, $y, $reversed) = @_;
    return $reversed ? ($y, $x) : ($x, $y);
}

use overload
    '+' => qw(union),
    '*' => qw(intersection),
    '-' => sub
	    {
		my ($s, $t) = order(@_);
		return $s->difference($t);
	    },
    '==' => qw(isEqualTo),
    '<=' => sub
	    {
		my ($s, $t) = order(@_);
		return $s->isSubsetOf($t);
	    },
    '<' => sub
	    {
		my ($s, $t) = order(@_);
		return $s->isProperSubsetOf($t);
	    };
#}>b

#{
# @method find
# Returns the integer i if i is contained in this set.
# @param self This set
# @param i An integer.
# @return i if i is contained in this set.
sub find
{
    my ($self, $i) = @_;
    if ($self->contains($i))
    {
	return $i;
    }
    else
    {
	return undef;
    }
}
#}>c

# @method iter
# Returns an iterator that enumerates the elements of a set.
# @param self This set.
# @return An iterator
sub iter
{
    my ($self) = @_;
    my $item = 0; # Iterator state.
    while ($item < $self->{_universeSize} &&
	!$self->contains($item))
    {
	$item += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($item < $self->{_universeSize})
	    {
		$result = $item;
		$item += 1;
		while ($item < $self->{_universeSize} &&
		    !$self->contains($item))
		{
		    $item += 1;
		}
	    }
	    return $result;
	}
}

# @function test
# Set test function.
# @param s1 A set to test.
# @param s2 A set to test.
# @param s3 A set to test.
sub test
{
    my ($s1, $s2, $s3) = @_;
    printf "Set test program.\n";
    for (my $i = 0; $i < 4; ++$i)
    {
	$s1->insert($i);
    }
    for (my $i = 2; $i < 6; ++$i)
    {
	$s2->insert($i);
    }
    $s3->insert(0);
    $s3->insert(2);
    printf "%s\n", $s1;
    printf "%s\n", $s2;
    printf "%s\n", $s3;
    printf "%s\n", $s1 + $s2; # union
    printf "%s\n", $s1 * $s3; # intersection
    printf "%s\n", $s1 - $s3; # difference
    printf "Using each\n";
    $s3->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $s3->iter();
    while (defined(my $obj = $iter->()))
    {
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Set>

=head2 CLASS C<Opus10::Set>

=head3 Base Classes

=over

=item C<Opus10::SearchableContainer>

=back

Abstract base class from which all set classes are derived.

=head3 ATTRIBUTES

=over

=item C<_universeSize>

The size of the universal set.

=back

=head3 METHOD C<difference>

Difference operator.
Returns the difference of this set and the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

The difference.

=head3 METHOD C<find>

Returns the integer i if i is contained in this set.

=head4 Parameters

=over

=item C<self>

This set

=item C<i>

An integer.

=back

=head4 Return

i if i is contained in this set.

=head3 METHOD C<initialize>


=head4 Parameters

=over

=item C<self>

This set.

=item C<size>

The size of the universal set.

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

The union.

=head3 METHOD C<intersection>

Intersection operator.
Returns the intersection of this set and the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

The intersection.

=head3 METHOD C<isEqualTo>

Equality operator.
Returns true if this set equals the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

True if this set equals the given set.

=head3 METHOD C<isProperSubsetOf>

Proper subset operator.
Returns true if this set is a proper subset of the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

True if this set is a proper subset of the given set.

=head3 METHOD C<isSubsetOf>

Subset operator.
Returns true if this set is a subset of the given set.

=head4 Parameters

=over

=item C<self>

This set.

=item C<set>

A set.

=back

=head4 Return

True if this set is a subset of the given set.

=head3 METHOD C<iter>

Returns an iterator that enumerates the elements of a set.

=head4 Parameters

=over

=item C<self>

This set.

=back

=head4 Return

An iterator

=head3 FUNCTION C<order>

Returns the first two arguments in the order specified by the third argument.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=item C<reversed>

True if x and y should be reversed.

=back

=head4 Return

Either (y, x) or (x, y).

=head3 FUNCTION C<test>

Set test function.

=head4 Parameters

=over

=item C<s1>

A set to test.

=item C<s2>

A set to test.

=item C<s3>

A set to test.

=back

=cut

