#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: Array.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Array.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Array
# Provides a basic array class.
# @attr _length The length of the array.
# @attr _baseIndex The base index of the array.
# @attr _data The array data.
package Opus10::Array;
use Carp;
use Opus10::Object;
use Opus10::Declarators;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this array instance with the given size and base index.
# @param self This array.
# @param size The size of the array. Optional.
# @param baseIndex The base index of the array. Optional.
sub initialize
{
    my ($self, $length, $baseIndex) = @_;
    $length = $length || 0;
    $baseIndex = $baseIndex || 0;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_length _baseIndex _data);
    $self->{_length} = $length;
    $self->{_baseIndex} = $baseIndex;
    $self->{_data} = [];
    $#{$self->{_data}} = $length-1;
}

destructor qw(DESTROY);
#}>a

#{
# @method getOffset
# Returns the offset in this array for the given index.
# @param self This array.
# @param index The given index.
# @return The offset for the given index.
sub getOffset
{
    my ($self, $index) = @_;
    croak 'IndexError' if ($index < $self->{_baseIndex}
	|| $index >= $self->{_length} + $self->{_baseIndex});
    return $index - $self->{_baseIndex};
}

# @method getItem
# Returns the item in this array at the given index.
# @param self This array.
# @param index An index.
# @return The item at the given index.
sub getItem
{
    my ($self, $index) = @_;
    return $self->{_data}[$self->getOffset($index)];
}

# @method setItem
# Stores the given item at the given index in this array.
# @param self This array.
# @param index An index.
# @param item The item to store.
sub setItem
{
    my ($self, $index, $value) = @_;
    $self->{_data}[$self->getOffset($index)] = $value;
}
#}>b

#{
attr_accessor qw(_baseIndex);
#}>c

#{
# @method getLength
# Length getter.
# @param self This array.
# @return The length of this array.
sub getLength
{
    my ($self) = @_;
    return $self->{_length};
}

# @method setLength
# Length setter.
# @param self This array.
# @param value The new length of this array.
sub setLength
{
    my ($self, $value) = @_;
    my $min = $self->{_length} < $value ?
	$self->{_length} : $value;
    my @tmp = [];
    @tmp = $min;
    for (my $i = 0; $i < $min; ++$i)
    {
	$tmp[$i] = $self->{_data}[$i];
    }
    $self->{_data} = \@tmp;
    $self->{_length} = $value;
}
#}>d

# @method each
# Calls the given visitor function for each item in this array.
# @param self This array.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 0; $i < $self->{_length}; ++$i)
    {
	$visitor->($self->{_data}[$i]);
    }
}

# @method toString
# Returns a string representation of this array.
# @param self This array.
# @return A string representation of this array.
sub toString
{
    my ($self) = @_;
    my $s = '';
    $self->each(
	sub
	{
	    my ($obj) = @_;
	    $s .= ', ';
	    if (defined($obj))
	    {
		$s .= $obj;
	    }
	    else
	    {
		$s .= 'undef';
	    }
	}
    );
    return ref($self) . '{_baseIndex=' . $self->{_baseIndex} . $s . '}';
}

# @method clone
# Returns a clone of this array.
# @param self This array.
# @return A clone of this array.
sub clone
{
    my ($self) = @_;
    my $result = Opus10::Array->new($self->getLength(), $self->getBaseIndex());
    for (my $i = 0; $i < $self->{_length}; ++$i)
    {
	$result->{_data}[$i] = $self->{_data}[$i];
    }
    return $result;
}

#{
# @classmethod TIEARRAY
# Creates a new array instance with the given size and base index.
# As a special case, if there are exactly two arguments
# and the second argument refers to an Opus10::Array,
# this method just returns the second argument.
# @param class The class of the array.
# @param size The size of the array. Optional.
# @param baseIndex The base index of the array. Optional.
# @return A reference to the new array.
sub TIEARRAY
{
    my ($class, @args) = @_;
    if (@args == 1 && ref($args[0]) eq __PACKAGE__)
    {
	return $args[0];
    }
    else
    {
	return $class->new(@args);
    }
}

# @method FETCH
# Returns the item in this array at the given index.
# @param self This array.
# @param index An index.
# @return The item at the given index.
sub FETCH
{
    my ($self, $index) = @_;
    return $self->getItem($index);
}

# @method STORE
# Stores the given item at the given index in this array.
# @param self This array.
# @param index An index.
# @param item The item to store.
sub STORE
{
    my ($self, $index, $item) = @_;
    return $self->setItem($index, $item);
}

# @method FETCHSIZE
# Returns the size of this array.
# @param self This array.
# @return The size of this array.
sub FETCHSIZE
{
    my ($self) = @_;
    return $self->getLength();
}

# @method STORESIZE
# Sets the size of this array.
# @param self This array.
# @param size The new size of this array.
sub STORESIZE
{
    my ($self, $size) = @_;
    return $self->setLength($size);
}
#}>e

# @method EXTEND
# Unsupported.
sub EXTEND
{
    croak 'OperationNotSupported';
}

# @method CLEAR
# Unsupported.
sub CLEAR
{
    croak 'OperationNotSupported';
}

# @method PUSH
sub PUSH
{
    croak 'OperationNotSupported';
}

# @method UNSHIFT
sub UNSHIFT
{
    croak 'OperationNotSupported';
}

# @method POP
sub POP
{
    croak 'OperationNotSupported';
}

# @method SHIFT
sub SHIFT
{
    croak 'OperationNotSupported';
}

# @method SPLICE
sub SPLICE
{
    croak 'OperationNotSupported';
}

# Overload various operators.
use overload
    '""' => qw(toString),
    fallback => 1;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    print "Array test program.\n";

    tie(my @a1, 'Opus10::Array', 3);
    printf "a1 = %s\n", tied(@a1);
    $a1[0] = 2;
    $a1[1] = $a1[0] + 2;
    $a1[2] = $a1[1] + 2;
    printf "a1 = %s\n", tied(@a1);
    printf "baseIndex = %d\n", tied(@a1)->getBaseIndex();
    printf "length = %d\n", scalar(@a1);

    tie(my @a2, 'Opus10::Array', 2, 10);
    $a2[10] = 57;
    printf "a2 = %s\n", tied(@a2);
    printf "baseIndex = %d\n", tied(@a2)->getBaseIndex();
    printf "length = %d\n", scalar(@a2);
    $#a2 = 5 - 1;
    printf "a2 = %s\n", tied(@a2);
    printf "length = %d\n", scalar(@a2);
    $#a2 = 3 - 1;
    printf "a2 = %s\n", tied(@a2);
    printf "length = %d\n", scalar(@a2);
    tie(my @a3, 'Opus10::Array', tied(@a2)->clone());
    printf "a3 = %s\n", tied(@a3);

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

=head1 MODULE C<Opus10::Array>

=head2 CLASS C<Opus10::Array>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Provides a basic array class.

=head3 ATTRIBUTES

=over

=item C<_baseIndex>

The base index of the array.

=item C<_data>

The array data.

=item C<_length>

The length of the array.

=back

=head3 METHOD C<CLEAR>

Unsupported.

=head3 METHOD C<EXTEND>

Unsupported.

=head3 METHOD C<FETCH>

Returns the item in this array at the given index.

=head4 Parameters

=over

=item C<self>

This array.

=item C<index>

An index.

=back

=head4 Return

The item at the given index.

=head3 METHOD C<FETCHSIZE>

Returns the size of this array.

=head4 Parameters

=over

=item C<self>

This array.

=back

=head4 Return

The size of this array.

=head3 METHOD C<POP>


=head3 METHOD C<PUSH>


=head3 METHOD C<SHIFT>


=head3 METHOD C<SPLICE>


=head3 METHOD C<STORE>

Stores the given item at the given index in this array.

=head4 Parameters

=over

=item C<self>

This array.

=item C<index>

An index.

=item C<item>

The item to store.

=back

=head3 METHOD C<STORESIZE>

Sets the size of this array.

=head4 Parameters

=over

=item C<self>

This array.

=item C<size>

The new size of this array.

=back

=head3 CLASS METHOD C<TIEARRAY>

Creates a new array instance with the given size and base index.
As a special case, if there are exactly two arguments
and the second argument refers to an Opus10::Array,
this method just returns the second argument.

=head4 Parameters

=over

=item C<class>

The class of the array.

=item C<size>

The size of the array. Optional.

=item C<baseIndex>

The base index of the array. Optional.

=back

=head4 Return

A reference to the new array.

=head3 METHOD C<UNSHIFT>


=head3 METHOD C<clone>

Returns a clone of this array.

=head4 Parameters

=over

=item C<self>

This array.

=back

=head4 Return

A clone of this array.

=head3 METHOD C<each>

Calls the given visitor function for each item in this array.

=head4 Parameters

=over

=item C<self>

This array.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<getItem>

Returns the item in this array at the given index.

=head4 Parameters

=over

=item C<self>

This array.

=item C<index>

An index.

=back

=head4 Return

The item at the given index.

=head3 METHOD C<getLength>

Length getter.

=head4 Parameters

=over

=item C<self>

This array.

=back

=head4 Return

The length of this array.

=head3 METHOD C<getOffset>

Returns the offset in this array for the given index.

=head4 Parameters

=over

=item C<self>

This array.

=item C<index>

The given index.

=back

=head4 Return

The offset for the given index.

=head3 METHOD C<initialize>

Initializes this array instance with the given size and base index.

=head4 Parameters

=over

=item C<self>

This array.

=item C<size>

The size of the array. Optional.

=item C<baseIndex>

The base index of the array. Optional.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<setItem>

Stores the given item at the given index in this array.

=head4 Parameters

=over

=item C<self>

This array.

=item C<index>

An index.

=item C<item>

The item to store.

=back

=head3 METHOD C<setLength>

Length setter.

=head4 Parameters

=over

=item C<self>

This array.

=item C<value>

The new length of this array.

=back

=head3 METHOD C<toString>

Returns a string representation of this array.

=head4 Parameters

=over

=item C<self>

This array.

=back

=head4 Return

A string representation of this array.

=cut

