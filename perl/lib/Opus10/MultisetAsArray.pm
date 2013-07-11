#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MultisetAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MultisetAsArray.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MultisetAsArray
# Multiset implemented using an array of counters.
# @attr _array The array.
package Opus10::MultisetAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::Multiset;
use Opus10::Array;
our @ISA = qw(Opus10::Multiset);

#}>head

our $VERSION = 1.00;

#{
# Initializes this multiset with the given universal set size.
# @method initialize
# @param self This multiset.
# @param n The universe size.
sub initialize
{
    my ($self, $n) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($n);
    $self->declare qw(_array);
    tie (@{$self->{_array}}, 'Opus10::Array', $n);
    for (my $item = 0; $item < $n; ++$item)
    {
	${$self->{_array}}[$item] = 0;
    }
}

destructor qw(DESTROY);

# The array.
attr_accessor qw(_array);
#}>a

#{
# @method insert
# Inserts the given item into this multiset.
# @param self This multiset
# @param item An integer.
sub insert
{
    my ($self, $item) = @_;
    ${$self->{_array}}[$item] = ${$self->{_array}}[$item] + 1;
}

# @method withdraw
# Withdraws the given item from this multiset.
# @param self This multiset.
# @param item An integer.
sub withdraw
{
    my ($self, $item) = @_;
    croak 'ArgumentEerror' if ${$self->{_array}}[$item] == 0;
    ${$self->{_array}}[$item] = ${$self->{_array}}[$item] - 1;
}

# @method contains
# Returns true if the given item is in this multiset.
# @param self This multiset.
# @param item An integer.
# @return True if the given item is in this multiset.
sub contains
{
    my ($self, $item) = @_;
    return ${$self->{_array}}[$item] > 0;
}
#}>b

# @method min
# Returns the smaller of two values.
# @param x A value.
# @param y A value.
# @return The smaller value.
sub min
{
    my ($x, $y) = @_;
    return $x < $y ? $x : $y;
}

#{
# @method union
# Multiset union operator.
# Returns the union of this multiset and the given multiset.
# @param self This multiset.
# @param set The multiset to add to this multiset.
# @return The union.
sub union
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$self->isa(__PACKAGE__);
    croak 'DomainError'
	if ($self->{_universeSize} != $set->{_universeSize});
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsArray->new($n);
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	${$result->{_array}}[$i] =
	    ${$self->{_array}}[$i] + ${$set->{_array}}[$i];
    }
    return $result;
}
#}>c

#{
# @method intersection
# Multiset intersection operator.
# Returns the intersection of this multiset and the given multiset.
# @param self This multiset
# @param set The multiset to intersect with this multiset.
# @return The intersection.
sub intersection
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$self->isa(__PACKAGE__);
    croak 'DomainError'
	if ($self->{_universeSize} != $set->{_universeSize});
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsArray->new($n);
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	${$result->{_array}}[$i] =
	    min(${$self->{_array}}[$i], ${$set->{_array}}[$i]);
    }
    return $result;
}
#}>d

#{
# @method difference
# Multiset difference operator.
# Returns the difference of this multiset and the given multiset.
# @param self This multiset.
# @param set The multiset to subtract from this multiset.
# @return The difference.
sub difference
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$self->isa(__PACKAGE__);
    croak 'DomainError'
	if ($self->{_universeSize} != $set->{_universeSize});
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsArray->new($n);
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	${$result->{_array}}[$i] =
	    ${$self->{_array}}[$i] - ${$set->{_array}}[$i];
    }
    return $result;
}
#}>e

# @method isEqualTo
# Multiset equality operator.
# Returns true if this multiset equals the given multiset.
# @param self This multiset.
# @param set The multiset to compare with this multiset.
# @return True if this multiset equals the given multiset.
sub isEqualTo
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$self->isa(__PACKAGE__);
    croak 'DomainError'
	if ($self->{_universeSize} != $set->{_universeSize});
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	if (${$self->{_array}}[$i] != ${$set->{_array}}[$i])
	{
	    return 0;
	}
    }
    return 1;
}

# @method isSubsetOf
# Subset operator.
# Returns true if this multiset is a subset of the given multiset.
# @param self This subset.
# @param set The multiset to compare with this multiset.
# @return True if this multiset is a subset of the given multiset.
sub isSubsetOf
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$self->isa(__PACKAGE__);
    croak 'DomainError'
	if ($self->{_universeSize} != $set->{_universeSize});
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	if (${$self->{_array}}[$i] <= ${$set->{_array}}[$i])
	{
	    return 0;
	}
    }
    return 1;
}

# @method purge
# Purges this multiset.
# @param self This multiset.
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	${$self->{_array}}[$i] = 0;
    }
}

# @method getCount
# The number of items in this multiset.
# @param self This multiset
sub getCount
{
    my ($self) = @_;
    my $result = 0;
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	$result = $result + ${$self->{_array}}[$i];
    }
    return $result;
}

# @method each
# Calls the given visitor function for each item in this multiset.
# @param self This multiset
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $item = 0; $item < $self->{_universeSize}; ++$item)
    {
	for (my $i = 0; $i < ${$self->{_array}}[$item]; ++$i)
	{
	    &$visitor($item);
	}
    }
}

# @method iter
# Returns an iterator that enumerates the items of a multiset.
# @param self This multiset.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $count = 0; # Iterator state.
    my $item = 0; # Iterator state.
    while ($item < $self->{_universeSize})
    {
	last if (${$self->{_array}}[$item] > 0);
	$item += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($item < $self->{_universeSize})
	    {
		$result = $item;
		$count += 1;
		if ($count == ${$self->{_array}}[$item])
		{
		    $count = 0;
		    $item += 1;
		    while ($item < $self->{_universeSize})
		    {
			last if (${$self->{_array}}[$item] > 0);
			$item += 1;
		    }
		}
	    }
	    return $result;
	}
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "MultisetAsArray test program.\n";
    Opus10::Multiset::test(
	Opus10::MultisetAsArray->new(32),
	Opus10::MultisetAsArray->new(32),
	Opus10::MultisetAsArray->new(32));
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

=head1 MODULE C<Opus10::MultisetAsArray>

=head2 CLASS C<Opus10::MultisetAsArray>

=head3 Base Classes

=over

=item C<Opus10::Multiset>

=back

Multiset implemented using an array of counters.

=head3 ATTRIBUTES

=over

=item C<_array>

The array.

=back

=head3 METHOD C<contains>

Returns true if the given item is in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<item>

An integer.

=back

=head4 Return

True if the given item is in this multiset.

=head3 METHOD C<difference>

Multiset difference operator.
Returns the difference of this multiset and the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<set>

The multiset to subtract from this multiset.

=back

=head4 Return

The difference.

=head3 METHOD C<each>

Calls the given visitor function for each item in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<getCount>

The number of items in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset

=back

=head3 METHOD C<initialize>


=head4 Parameters

=over

=item C<self>

This multiset.

=item C<n>

The universe size.

=back

=head3 METHOD C<insert>

Inserts the given item into this multiset.

=head4 Parameters

=over

=item C<self>

This multiset

=item C<item>

An integer.

=back

=head3 METHOD C<intersection>

Multiset intersection operator.
Returns the intersection of this multiset and the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset

=item C<set>

The multiset to intersect with this multiset.

=back

=head4 Return

The intersection.

=head3 METHOD C<isEqualTo>

Multiset equality operator.
Returns true if this multiset equals the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<set>

The multiset to compare with this multiset.

=back

=head4 Return

True if this multiset equals the given multiset.

=head3 METHOD C<isSubsetOf>

Subset operator.
Returns true if this multiset is a subset of the given multiset.

=head4 Parameters

=over

=item C<self>

This subset.

=item C<set>

The multiset to compare with this multiset.

=back

=head4 Return

True if this multiset is a subset of the given multiset.

=head3 METHOD C<iter>

Returns an iterator that enumerates the items of a multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=back

=head4 Return

An iterator.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<min>

Returns the smaller of two values.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=back

=head4 Return

The smaller value.

=head3 METHOD C<purge>

Purges this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=back

=head3 METHOD C<union>

Multiset union operator.
Returns the union of this multiset and the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<set>

The multiset to add to this multiset.

=back

=head4 Return

The union.

=head3 METHOD C<withdraw>

Withdraws the given item from this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<item>

An integer.

=back

=cut

