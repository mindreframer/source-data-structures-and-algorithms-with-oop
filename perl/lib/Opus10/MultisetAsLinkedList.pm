#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MultisetAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MultisetAsLinkedList.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MultisetAsLinkedList
# Multiset implemented using a linked list of elements.
# @attr _list The linked list.
package Opus10::MultisetAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Multiset;
use Opus10::LinkedList;
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
    $self->declare qw(_list);
    $self->{_list} = Opus10::LinkedList->new();
}

destructor qw(DESTROY);

# The array.
attr_accessor qw(_array);
#}>a

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
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsLinkedList->new($n);
    my $p = $self->{_list}->getHead();
    my $q = $set->{_list}->getHead();
    while (defined($p) && defined($q))
    {
	if ($p->getDatum() <= $q->getDatum())
	{
	    $result->{_list}->append($p->getDatum());
	    $p = $p->getSucc();
	}
	else
	{
	    $result->{_list}->append($q->getDatum());
	    $q = $q->getSucc();
	}
    }
    while (defined($p))
    {
	$result->{_list}->append($p->getDatum());
	$p = $p->getSucc();
    }
    while (defined($q))
    {
	$result->{_list}->append($q->getDatum());
	$q = $q->getSucc();
    }
    return $result;
}
#}>b

#{
# @method intersection
# Multiset intersection operator.
# Returns the intersection
# of this multiset and the given multiset.
# @param self This multiset.
# @param set The multiset to intersect with this multiset.
# @return The intersection.
sub intersection
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsLinkedList->new($n);
    my $p = $self->{_list}->getHead();
    my $q = $set->{_list}->getHead();
    while (defined($p) && defined($q))
    {
	my $diff = $p->getDatum() - $q->getDatum();
	if ($diff == 0)
	{
	    $result->{_list}->append($p->getDatum());
	}
	if ($diff <= 0)
	{
	    $p = $p->getSucc();
	}
	if ($diff >= 0)
	{
	    $q = $q->getSucc();
	}
    }
    return $result;
}
#}>c

use Opus10::Box;

# @method insert
# Inserts the given item into this multiset.
# @param self This multiset.
# @param item An integer.
sub insert
{
    my ($self, $item) = @_;
    $item = box($item);
    my $ptr = $self->{_list}->getHead();
    my $prevPtr = undef;
    while (defined($ptr))
    {
	last if ($ptr->getDatum() >= $item);
	$prevPtr = $ptr;
	$ptr = $ptr->getSucc();
    }
    if (defined($prevPtr))
    {
	$prevPtr->insertAfter($item);
    }
    else
    {
	$self->{_list}->prepend($item);
    }
}

# @method withdraw
# Withdraws the given item from this multiset.
# @param self This multiset.
# @param item An integer.
sub withdraw
{
    my ($self, $item) = @_;
    $item = box($item);
    my $ptr = $self->{_list}->getHead();
    while (defined($ptr))
    {
	if ($ptr->getDatum() == $item)
	{
	    $self->{_list}->extract($ptr->getDatum());
	    return;
	}
	$ptr = $ptr->getSucc();
    }
}

# @method contains
# True if the given item is in this multiset.
# @param self This multiset.
# @param item An integer.
sub contains
{
    my ($self, $item) = @_;
    $item = box($item);
    my $ptr = $self->{_list}->getHead();
    while (defined($ptr))
    {
	if ($ptr->getDatum() == $item)
	{
	    return 1;
	}
	$ptr = $ptr->getSucc();
    }
    return 0;
}

# @method purge
# Purges this multiset.
# @param self This multiset.
sub purge
{
    my ($self) = @_;
    $self->{_list} = Opus10::LinkedList->new();
}

# @method getCount
# Returns the number of items in this multiset.
# @param self This multiset.
sub getCount
{
    my ($self) = @_;
    my $result = 0;
    my $ptr = $self->{_list}->getHead();
    while (defined($ptr))
    {
	$result += 1;
	$ptr = $ptr->getSucc();
    }
    return $result;
}

# @method each
# Calls the given visitor method for each item in this multiset.
# @param self This multiset.
# @param visitor A visitor method.
sub each
{
    my ($self, $visitor) = @_;
    my $ptr = $self->{_list}->getHead();
    while (defined($ptr))
    {
	&$visitor($ptr->getDatum()->getValue());
	$ptr = $ptr->getSucc();
    }
}

# @method iter
# Returns an iterator that enumerates
# the items of this multiset.
# @param self This multiset.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $position = $self->{_list}->getHead(); # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if (defined($position))
	    {
		$result = $position->getDatum()->getValue();
		$position = $position->getSucc();
	    }
	    return $result;
	}
}

# @method difference
# Multiset difference operator.
# Returns the difference of this multiset
# and the given multiset.
# @param self This multiset.
# @param set The multiset to subtract from this multiset.
# @return The difference.
sub difference
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $n = $self->{_universeSize};
    my $result = Opus10::MultisetAsLinkedList->new($n);
    my $p = $self->{_list}->getHead();
    my $q = $set->{_list}->getHead();
    while (defined($p) && defined($q))
    {
	my $diff = $p->getDatum() - $q->getDatum();
	if ($diff < 0)
	{
	    $result->{_list}->append($p->getDatum());
	}
	if ($diff <= 0)
	{
	    $p = $p->getSucc();
	}
	if ($diff >= 0)
	{
	    $q = $q->getSucc();
	}
    }
    while (defined($p))
    {
	$result->{_list}->append($p->getDatum());
	$p = $p->getSucc();
    }
    return $result;
}

# @method isEqualTo
# Multiset equality operator.
# Returns true if this multiset equals the given multiset.
# @param self This multiset.
# @param set The multiset to compare with this multiset.
# @return True if this multiset equals the given multiset.
sub isEqualTo
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $p = $self->{_list}->getHead();
    my $q = $set->{_list}->getHead();
    while (defined($p) && defined($q))
    {
	if ($p->getDatum() != $q->getDatum())
	{
	    return 0;
	}
	$p = $p->getSucc();
	$q = $q->getSucc();
    }
    return !defined($p) && !defined($q);
}

# @method isSubsetOf
# Subset operator.
# Returns true if this multiset
# is a subset of the given multiset.
# @param self This multiset.
# @param set The multiset to compare with this multiset.
# @return True if this multiset is a subset of the given multiset.
sub isSubsetOf
{
    my ($self, $set) = @_;
    croak 'TypeError' if !$set->isa(__PACKAGE__);
    croak 'DomainError'
	if $self->{_universeSize} != $set->{_universeSize};
    my $p = $self->{_list}->getHead();
    my $q = $set->{_list}->getHead();
    while (defined($p) && defined($q))
    {
	my $diff = $p->getDatum() - $q->getDatum();
	if ($diff == 0)
	{
	    $p = $p->getSucc();
	    $q = $q->getSucc();
	}
	elsif ($diff > 0)
	{
	    $q = $q->getSucc();
	}
	else
	{
	    return 0;
	}
    }
    return !defined($p);
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "MultisetAsLinkedList test program.\n";
    Opus10::Multiset::test(
	Opus10::MultisetAsLinkedList->new(32),
	Opus10::MultisetAsLinkedList->new(32),
	Opus10::MultisetAsLinkedList->new(32));
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

=head1 MODULE C<Opus10::MultisetAsLinkedList>

=head2 CLASS C<Opus10::MultisetAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::Multiset>

=back

Multiset implemented using a linked list of elements.

=head3 ATTRIBUTES

=over

=item C<_list>

The linked list.

=back

=head3 METHOD C<contains>

True if the given item is in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<item>

An integer.

=back

=head3 METHOD C<difference>

Multiset difference operator.
Returns the difference of this multiset
and the given multiset.

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

Calls the given visitor method for each item in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<visitor>

A visitor method.

=back

=head3 METHOD C<getCount>

Returns the number of items in this multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

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

This multiset.

=item C<item>

An integer.

=back

=head3 METHOD C<intersection>

Multiset intersection operator.
Returns the intersection
of this multiset and the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

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
Returns true if this multiset
is a subset of the given multiset.

=head4 Parameters

=over

=item C<self>

This multiset.

=item C<set>

The multiset to compare with this multiset.

=back

=head4 Return

True if this multiset is a subset of the given multiset.

=head3 METHOD C<iter>

Returns an iterator that enumerates
the items of this multiset.

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

