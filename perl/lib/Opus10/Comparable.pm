#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Comparable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Comparable.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Comparable
# Abstract base class from which all comparable objects are derived.
# @attr __id A unique object identifier.
package Opus10::Comparable;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
our $__nextId = 1;

# @method initialize
# Initializes this object.
# @param self This object.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(__id);
    $self->{__id} = $__nextId++;
}

destructor qw(DESTROY);
#}>a

#{
# @method is
# Returns true if this object is the given object.
# @param self This object.
# @param obj The given object.
# @return True if this object is the given object.
sub is
{
    my ($self, $obj) = @_;
    my $result = 0;
    if ($self->isa(ref($obj)))
    {
	$result = ($self->{__id} == $obj->{__id}) ? 1 : 0;
    }
    return $result;
}

# @method isNot
# Returns true if this object is not the given object.
# @param self This object.
# @param obj The given object.
# @return True if this object is not the given object.
sub isNot
{
    my ($self, $obj) = @_;
    return !$self->is($obj);
}
#}>b

#{
# @method compare
# Compares this object with a given object.
# @param self This object.
# @param obj Another object.
# @param reversed True if the comparsion is reversed.
# @return a negative number if this object is less than the given object,
# zero if this object equals the given object, and
# a positive number if this object is greather than the given object.
sub compare
{
    my ($self, $obj, $reversed) = @_;
    my $result = 0;
    if ($self->isa(ref($obj)))
    {
	$result = $self->compareTo($obj);
    }
    elsif ($obj->isa(ref($self)))
    {
	$result = -$obj->compareTo($self);
    }
    else
    {
	$result = ref($self) <=> ref($obj);
    }
    return $reversed ? -$result : $result;
}

# @method compareTo
# Compares this object to the given object.
# This object and the given object are instances of the same class.
# @param self This object.
# @param obj The given object.
# @return a negative number if this object is less than the given object,
# zero if this object equals the given object, and
# a positive number if this object is greater than the given object.
abstract_method qw(compareTo);
#}>c

#{
# @method toString
# Returns a textual representation of this object.
# @param self This object.
# @return A string.
abstract_method qw(toString);

# @method toNumeric
# Returns a numeric representation of this object.
# @param self This object.
# @return A number.
abstract_method qw(toNumeric);

# @method toBoolean
# Returns a Boolean representation of this object.
# @param self This object.
# @return True or false.
abstract_method qw(toBoolean);

abstract_method qw(hash);

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
# Overload various operators.
use overload
    '""' => qw(toString),
    '0+'  => qw(toNumeric),
    'bool' => qw(toBoolean),
    '<=>'  => sub
		{
		    my ($x, $y) = order(@_);
		    return $x->compare($y);
		},
    fallback => 1;
#}>d

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "Comparable test program.\n";
    eval
    {
	my $object = Opus10::Comparable->new();
	$object->compareTo(undef);
    };
    if ($@)
    {
	printf "Caught exception: $@\n";
    };
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

=head1 MODULE C<Opus10::Comparable>

=head2 CLASS C<Opus10::Comparable>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Abstract base class from which all comparable objects are derived.

=head3 ATTRIBUTES

=over

=item C<__id>

A unique object identifier.

=back

=head3 METHOD C<compare>

Compares this object with a given object.

=head4 Parameters

=over

=item C<self>

This object.

=item C<obj>

Another object.

=item C<reversed>

True if the comparsion is reversed.

=back

=head4 Return

a negative number if this object is less than the given object,
zero if this object equals the given object, and
a positive number if this object is greather than the given object.

=head3 METHOD C<compareTo>

Compares this object to the given object.
This object and the given object are instances of the same class.

=head4 Parameters

=over

=item C<self>

This object.

=item C<obj>

The given object.

=back

=head4 Return

a negative number if this object is less than the given object,
zero if this object equals the given object, and
a positive number if this object is greater than the given object.

=head3 METHOD C<initialize>

Initializes this object.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head3 METHOD C<is>

Returns true if this object is the given object.

=head4 Parameters

=over

=item C<self>

This object.

=item C<obj>

The given object.

=back

=head4 Return

True if this object is the given object.

=head3 METHOD C<isNot>

Returns true if this object is not the given object.

=head4 Parameters

=over

=item C<self>

This object.

=item C<obj>

The given object.

=back

=head4 Return

True if this object is not the given object.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

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

=head3 METHOD C<toBoolean>

Returns a Boolean representation of this object.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head4 Return

True or false.

=head3 METHOD C<toNumeric>

Returns a numeric representation of this object.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head4 Return

A number.

=head3 METHOD C<toString>

Returns a textual representation of this object.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head4 Return

A string.

=cut

