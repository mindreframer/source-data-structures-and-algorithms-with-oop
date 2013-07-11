#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MultiDimensionalArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MultiDimensionalArray.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MultiDimensionalArray
# Represents a multi-dimensional array.
# @attr dimensions The dimensions of the array.
# @attr factors Factors used to compute an offset in the array.
# @attr data The array data.
package Opus10::MultiDimensionalArray;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::Array;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this multi-dimensional array instance with the given dimensions.
# @param self This multi-dimensional array.
# @param args The dimensions of the array.
sub initialize
{
    my ($self, $dimensions) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_dimensions _factors _data);
    tie (@{$self->{_dimensions}}, 'Opus10::Array',
	scalar(@$dimensions));
    tie (@{$self->{_factors}}, 'Opus10::Array',
	scalar(@$dimensions));
    my $product = 1;
    my $i = @$dimensions - 1;
    while ($i >= 0)
    {
	${$self->{_dimensions}}[$i] = $$dimensions[$i];
	${$self->{_factors}}[$i] = $product;
	$product *= ${$self->{_dimensions}}[$i];
	$i -= 1;
    }
    tie(@{$self->{_data}}, 'Opus10::Array', $product);
}

destructor qw(DESTROY);
#}>a

#{
# @method getOffset
# Returns the offset in this multi-dimensional array for the given indices.
# @param self This multi-dimensional array.
# @param indices The given indices.
# @return The offset for the given indices.
sub getOffset
{
    my ($self, $indices) = @_;
    croak 'IndexError' if @$indices != @{$self->{_dimensions}};
    my $offset = 0;
    for (my $i = 0; $i < @{$self->{_dimensions}}; ++$i)
    {
	croak 'IndexError' if $$indices[$i] < 0 ||
	    $$indices[$i] >= ${$self->{_dimensions}}[$i];
	$offset += ${$self->{_factors}}[$i] * $$indices[$i];
    }
    return $offset;
}

# @method getItem
# Returns the item in this multi-dimensional array at the given indices.
# @param self This multi-dimensional array.
# @param indices The given indices.
# @return The item at the given indices.
sub getItem
{
    my ($self, $indices) = @_;
    return ${$self->{_data}}[$self->getOffset($indices)];
}

# @method setItem
# Stores the given item at the given indices in this multi-dimensional array.
# @param self This multi-dimensional array.
# @param indices The given indices.
# @param value The item to store.
sub setItem
{
    my ($self, $indices, $value) = @_;
    ${$self->{_data}}[$self->getOffset($indices)] = $value;
}
#}>b

# @method toString
# Returns a string representation of this multi-dimensional array.
# @param self This multi-dimensional array.
# @return A string representation of this multi-dimensional array.
sub toString
{
    my ($self) = @_;
    return sprintf "MultiDimensionalArray" .
	"{dimensions = %s, factors=%s, data=%s}",
	tied(@{$self->{_dimensions}}),
	tied(@{$self->{_factors}}),
	tied(@{$self->{_data}});
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
    my @args = @_;
    my $status = 0;
    print "MultiDimensionalArray test program.\n";
    my $m = Opus10::MultiDimensionalArray->new([2, 3, 4]);
    $m->setItem([1, 2, 3], 57);
    printf "%s\n", $m->getItem([1, 2, 3]);
    printf "%s\n", $m;
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

=head1 MODULE C<Opus10::MultiDimensionalArray>

=head2 CLASS C<Opus10::MultiDimensionalArray>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents a multi-dimensional array.

=head3 ATTRIBUTES

=over

=item C<data>

The array data.

=item C<dimensions>

The dimensions of the array.

=item C<factors>

Factors used to compute an offset in the array.

=back

=head3 METHOD C<getItem>

Returns the item in this multi-dimensional array at the given indices.

=head4 Parameters

=over

=item C<self>

This multi-dimensional array.

=item C<indices>

The given indices.

=back

=head4 Return

The item at the given indices.

=head3 METHOD C<getOffset>

Returns the offset in this multi-dimensional array for the given indices.

=head4 Parameters

=over

=item C<self>

This multi-dimensional array.

=item C<indices>

The given indices.

=back

=head4 Return

The offset for the given indices.

=head3 METHOD C<initialize>

Initializes this multi-dimensional array instance with the given dimensions.

=head4 Parameters

=over

=item C<self>

This multi-dimensional array.

=item C<args>

The dimensions of the array.

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

Stores the given item at the given indices in this multi-dimensional array.

=head4 Parameters

=over

=item C<self>

This multi-dimensional array.

=item C<indices>

The given indices.

=item C<value>

The item to store.

=back

=head3 METHOD C<toString>

Returns a string representation of this multi-dimensional array.

=head4 Parameters

=over

=item C<self>

This multi-dimensional array.

=back

=head4 Return

A string representation of this multi-dimensional array.

=cut

