#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: DenseMatrix.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DenseMatrix.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DenseMatrix
# A dense matrix implemented as a multi-dimensional array with 2 dimensions.
# @attr array The multi-dimensional array.
package Opus10::DenseMatrix;
use Carp;
use Opus10::Declarators;
use Opus10::Matrix;
use Opus10::MultiDimensionalArray;
our @ISA = qw(Opus10::Matrix);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this dense matrix
# with the given number of rows and columns.
# @param class The class of the matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
# @return A reference to the new matrix.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($numberOfRows, $numberOfColumns);
    $self->declare qw(_array);
    $self->{_array} = Opus10::MultiDimensionalArray->new(
	    [$numberOfRows, $numberOfColumns]);
}

destructor qw(DESTROY);

# @method getItem
# Returns the item in this dense matrix at the given indices.
# @param self This matrix.
# @param row The row index.
# @param col The column index.
# @return The item at the given indices.
sub getItem
{
    my ($self, $row, $col) = @_;
    return $self->{_array}->getItem([$row, $col]);
}

# @method setItem
# Sets the item in this dense matrix at the given indices to the given value.
# @param self This matrix.
# @param row The row index.
# @param col The column index.
# @param value The value to set.
sub setItem
{
    my ($self, $row, $col, $value) = @_;
    return $self->{_array}->setItem([$row, $col], $value);
}
#}>a

#{
# @method mul
# Returns the product of this dense matrix and the given dense matrix.
# @param self This matrix.
# @param mat The given matrix.
# @return The product.
sub mul
{
    my ($self, $mat) = @_;
    croak 'DomainError' if $self->getNumberOfColumns()
			!= $mat->getNumberOfRows();
    my $result = Opus10::DenseMatrix->new(
	$self->getNumberOfRows(), $mat->getNumberOfColumns());
    for (my $i = 0; $i < $self->getNumberOfRows(); ++$i)
    {
	for (my $j = 0; $j < $mat->getNumberOfColumns(); ++$j)
	{
	    my $sum = 0;
	    for (my $k = 0; $k<$self->getNumberOfColumns(); ++$k)
	    {
		$sum += $self->getItem($i, $k) *
		    $mat->getItem($k, $j);
	    }
	    $result->setItem($i, $j, $sum)
	}
    }
    return $result;
}
#}>b

# @method add
# Returns the sum of this dense matrix and the given dense matrix.
# @param self This matrix.
# @param mat The given matrix.
# @return The sum.
sub add
{
    my ($self, $mat) = @_;
    croak 'DomainError' if
	($self->getNumberOfRows() != $mat->getNumberOfRows() ||
	$self->getNumberOfColumns() != $mat->getNumberOfColumns());
    my $result = Opus10::DenseMatrix->new(
	$self->getNumberOfRows(), $self->getNumberOfColumns());
    for (my $i = 0; $i < $self->getNumberOfRows(); ++$i)
    {
	for (my $j = 0; $j < $self->getNumberOfColumns(); ++$j)
	{
	    $result->setItem($i, $j,
		$self->getItem($i, $j) + $mat->getItem($i, $j));
	}
    }
    return $result;
}

# @method transpose
# Returns the transpose of this dense matrix.
# @param self This matrix.
# @return The transpose.
sub transpose
{
    my ($self) = @_;
    my $result = Opus10::DenseMatrix->new(
	$self->getNumberOfColumns(), $self->getNumberOfRows());
    for (my $i = 0; $i < $self->getNumberOfRows(); ++$i)
    {
	for (my $j = 0; $j < $self->getNumberOfColumns(); ++$j)
	{
	    $result->setItem($j, $i, $self->getItem($i, $j));
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
    print "DenseMatrix test program.\n";
    my $mat = Opus10::DenseMatrix->new(6, 6);
    Opus10::Matrix::test($mat);
    Opus10::Matrix::testTranspose($mat);
    Opus10::Matrix::testTimes($mat, $mat);
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

=head1 MODULE C<Opus10::DenseMatrix>

=head2 CLASS C<Opus10::DenseMatrix>

=head3 Base Classes

=over

=item C<Opus10::Matrix>

=back

A dense matrix implemented as a multi-dimensional array with 2 dimensions.

=head3 ATTRIBUTES

=over

=item C<array>

The multi-dimensional array.

=back

=head3 METHOD C<add>

Returns the sum of this dense matrix and the given dense matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<mat>

The given matrix.

=back

=head4 Return

The sum.

=head3 METHOD C<getItem>

Returns the item in this dense matrix at the given indices.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<row>

The row index.

=item C<col>

The column index.

=back

=head4 Return

The item at the given indices.

=head3 METHOD C<initialize>

Initializes this dense matrix
with the given number of rows and columns.

=head4 Parameters

=over

=item C<class>

The class of the matrix.

=item C<numberOfRows>

The number of rows.

=item C<numberOfColumns>

The number of columns.

=back

=head4 Return

A reference to the new matrix.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<mul>

Returns the product of this dense matrix and the given dense matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<mat>

The given matrix.

=back

=head4 Return

The product.

=head3 METHOD C<setItem>

Sets the item in this dense matrix at the given indices to the given value.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<row>

The row index.

=item C<col>

The column index.

=item C<value>

The value to set.

=back

=head3 METHOD C<transpose>

Returns the transpose of this dense matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=back

=head4 Return

The transpose.

=cut

