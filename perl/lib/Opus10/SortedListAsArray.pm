#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SortedListAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SortedListAsArray.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SortedListAsArray::Cursor
# Represents a position in this list.
package Opus10::SortedListAsArray::Cursor;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedListAsArray;
our @ISA = qw(Opus10::OrderedListAsArray::Cursor);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a cursor that represents the position
# in the given list at the given offset.
# @param self This cursor.
# @param list An sorted list.
# @param offset An offset.
sub initialize
{
    my ($self, $list, $offset) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($list, $offset);
}

destructor qw(DESTROY);

# @method insertAfter
# Not supported.
# @param self This cursor.
sub insertAfter
{
    croak 'OperationNotSupported';
}

# @method insertBefore
# Not supported.
# @param self This cursor.
sub insertBefore
{
    croak 'OperationNotSupported';
}
#}>e

#{
# @class Opus10::SortedListAsArray
# An sorted list implemented using an array.
package Opus10::SortedListAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::OrderedListAsArray;
use Opus10::SortedList;
our @ISA = qw(Opus10::OrderedListAsArray Opus10::SortedList);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an sorted list with the given size.
# @param size The size of the list.
# @param self This queue.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->Opus10::OrderedListAsArray::initialize($size);
    $self->Opus10::SortedList::initialize();
}

destructor qw(DESTROY);
#}>a

#{
# @method insert
# Inserts the given object into this sorted list (at the end of the list).
# @param self This sorted list.
# @param obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    croak 'ContainerFull'
	if @{$self->{_array}} == $self->{_count};
    my $i = $self->{_count};
    while ($i > 0 && ${$self->{_array}}[$i - 1] > $obj)
    {
	${$self->{_array}}[$i] = ${$self->{_array}}[$i - 1];
	$i -= 1;
    }
    ${$self->{_array}}[$i] = $obj;
    $self->{_count} += 1;
}
#}>b

#{
# @method findOffset
# Returns the offset of the object in this sorted list
# that is equal to the given object.
# @param self This sorted list.
# @param obj The object to find.
# @return An offset
sub findOffset
{
    my ($self, $obj) = @_;
    my $left = 0;
    my $right = $self->{_count} - 1;
    while ($left <= $right)
    {
	my $middle = ($left + $right) / 2;
	if ($obj > ${$self->{_array}}[$middle])
	{
	    $left = $middle + 1;
	}
	elsif ($obj < ${$self->{_array}}[$middle])
	{
	    $right = $middle - 1;
	}
	else
	{
	    return $middle;
	}
    }
    return -1;
}

# @method find
# Returns an object in this sorted list that is equal to the given object.
# @param self This sorted list.
# @param obj An object.
# @return An object in this sorted list that is equal to the given object.
sub find
{
    my ($self, $obj) = @_;
    my $offset = $self->findOffset($obj);
    return $offset < 0 ? undef :
	${$self->{_array}}[$offset];
}
#}>c

#{
# @method withdraw
# Withdraws the given object from this sorted list.
# @param self This sorted list.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    my $offset = $self->findOffset($obj);
    croak 'ArgumentError' if $offset < 0;
    my $i = $offset;
    while ($i < $self->{_count})
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
    return Opus10::SortedListAsArray::Cursor->new(
	$self, $self->findOffset($obj));
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "SortedListAsArray test program.\n";
    my $list = Opus10::SortedListAsArray->new(10);
    Opus10::SortedList::test($list);
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

=head1 MODULE C<Opus10::SortedListAsArray>

=head2 CLASS C<Opus10::SortedListAsArray>

=head3 Base Classes

=over

=item C<Opus10::OrderedListAsArray>

=item C<Opus10::SortedList>

=back

An sorted list implemented using an array.

=head3 METHOD C<find>

Returns an object in this sorted list that is equal to the given object.

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

An object.

=back

=head4 Return

An object in this sorted list that is equal to the given object.

=head3 METHOD C<findOffset>

Returns the offset of the object in this sorted list
that is equal to the given object.

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

The object to find.

=back

=head4 Return

An offset

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

=head3 METHOD C<initialize>

Initializes an sorted list with the given size.

=head4 Parameters

=over

=item C<size>

The size of the list.

=item C<self>

This queue.

=back

=head3 METHOD C<insert>

Inserts the given object into this sorted list (at the end of the list).

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

The object to insert.

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

=head3 METHOD C<withdraw>

Withdraws the given object from this sorted list.

=head4 Parameters

=over

=item C<self>

This sorted list.

=item C<obj>

The object to withdraw.

=back

=head2 CLASS C<Opus10::SortedListAsArray::Cursor>

=head3 Base Classes

=over

=item C<Opus10::OrderedListAsArray::Cursor>

=back

Represents a position in this list.

=head3 METHOD C<initialize>

Initializes a cursor that represents the position
in the given list at the given offset.

=head4 Parameters

=over

=item C<self>

This cursor.

=item C<list>

An sorted list.

=item C<offset>

An offset.

=back

=head3 METHOD C<insertAfter>

Not supported.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=head3 METHOD C<insertBefore>

Not supported.

=head4 Parameters

=over

=item C<self>

This cursor.

=back

=cut

