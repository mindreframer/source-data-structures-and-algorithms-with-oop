#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: Matrix.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Matrix.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Matrix
# Abstract base class from which all matrix classes are derived.
# @attr numberOfRows The number of rows in this matrix.
# @attr numberOfColumns The number of columns in this matrix.
package Opus10::Matrix;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this matrix with the given number of rows and columns.
# @param self This matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_numberOfRows _numberOfColumns);
    croak 'DomainError' if $numberOfRows < 0;
    croak 'DomainError' if $numberOfColumns < 0;
    $self->{_numberOfRows} = $numberOfRows;
    $self->{_numberOfColumns} = $numberOfColumns;
}

destructor qw(DESTROY);

attr_reader qw(_numberOfRows);

attr_reader qw(_numberOfColumns);

# @method getItem
# Returns the item in this matrix at the given indices.
# @param self This matrix.
# @param row The row index.
# @param col The column index.
# @return The item at the given indices
abstract_method qw(getItem);

# @method setItem
# Sets the item in this matrix at the given indices to the given value.
# @param self This matrix.
# @param row The row index.
# @param col The column index.
# @param value The new value of the item at the given indices.
abstract_method qw(setItem);

# @method add
# Return the sum of this matrix and the given matrix.
# @param self This matrix.
# @param mat The given matrix.
# @return The sum of this matrix and the given matrix.
abstract_method qw(add);

# @method mul
# Return the product of this matrix and the given matrix.
# @param self This matrix.
# @param mat The given matrix.
# @return The product of this matrix and the given matrix.
abstract_method qw(mul);

# @method transpose
# Return the transpos of this matrix.
# @param self This matrix.
# @return The transpose fo this matrix
abstract_method qw(transpose);
#}>a

# @method toString
# Returns a textual representation of this matrix.
# @param self This matrix.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    for (my $i = 0; $i < $self->{_numberOfRows}; ++$i)
    {
	for (my $j = 0; $j < $self->{_numberOfColumns}; ++$j)
	{
	    $s .= $self->getItem($i, $j) . ' ';
	}
	$s .= "\n";
    }
    return $s;
}

use overload
    '""' => qw(toString),
    '+' => qw(add),
    '*' => sub
	    {
		my ($op1, $op2, $reversed) = @_;
		croak 'ArgumentError' if $reversed;
		return $op1->mul($op2);
	    },
    fallback => 1;

# @function test
# Matrix test program.
# @param mat Reference to matrix to test.
sub test
{
    my ($mat) = @_;
    printf "Matrix test program.\n";
    my $k = 0;
    for (my $i = 0; $i < $mat->getNumberOfRows(); ++$i)
    {
	for (my $j = 0; $j < $mat->getNumberOfColumns(); ++$j)
	{
	    $mat->setItem($i, $j, $k);
	    $k += 1;
	}
    }
    printf "%s\n", $mat;
    $mat = $mat + $mat;
    printf "%s\n", $mat;
}

# @function testTranspose
# Matrix transpose test program.
# @param mat Reference to matrix to test.
sub testTranspose
{
    my ($mat) = @_;
    printf "Matrix transpose test program.\n";
    $mat->setItem(0, 0, 31);
    $mat->setItem(0, 2, 41);
    $mat->setItem(0, 3, 59);
    $mat->setItem(1, 1, 26);
    $mat->setItem(2, 3, 53);
    $mat->setItem(2, 4, 58);
    $mat->setItem(4, 2, 97);
    $mat->setItem(5, 1, 93);
    $mat->setItem(5, 5, 23);
    printf "%s\n", $mat;
    $mat->setItem(2, 4, 0);
    $mat->setItem(5, 3, 0);
    $mat = $mat->transpose();
    printf "%s\n", $mat;
}

# @function testTimes
# Matrix transpose test program.
# @param mat1 Reference to matrix to test.
# @param mat2 Reference to matrix to test.
sub testTimes
{
    my ($mat1, $mat2) = @_;
    print "Matrix multiply test program.\n";
    $mat1->setItem(0, 0, 1);
    $mat1->setItem(0, 1, 2);
    $mat1->setItem(0, 2, 3);
    $mat2->setItem(0, 0, 1);
    $mat2->setItem(1, 0, 2);
    $mat2->setItem(2, 0, 3);
    printf "%s\n", $mat1;
    printf "%s\n", $mat2;
    $mat1 = $mat2 * $mat1;
    printf "%s\n", $mat1;
}

1;
__DATA__

=head1 MODULE C<Opus10::Matrix>

=head2 CLASS C<Opus10::Matrix>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Abstract base class from which all matrix classes are derived.

=head3 ATTRIBUTES

=over

=item C<numberOfColumns>

The number of columns in this matrix.

=item C<numberOfRows>

The number of rows in this matrix.

=back

=head3 METHOD C<add>

Return the sum of this matrix and the given matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<mat>

The given matrix.

=back

=head4 Return

The sum of this matrix and the given matrix.

=head3 METHOD C<getItem>

Returns the item in this matrix at the given indices.

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

The item at the given indices

=head3 METHOD C<initialize>

Initializes this matrix with the given number of rows and columns.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<numberOfRows>

The number of rows.

=item C<numberOfColumns>

The number of columns.

=back

=head3 METHOD C<mul>

Return the product of this matrix and the given matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<mat>

The given matrix.

=back

=head4 Return

The product of this matrix and the given matrix.

=head3 METHOD C<setItem>

Sets the item in this matrix at the given indices to the given value.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<row>

The row index.

=item C<col>

The column index.

=item C<value>

The new value of the item at the given indices.

=back

=head3 FUNCTION C<test>

Matrix test program.

=head4 Parameters

=over

=item C<mat>

Reference to matrix to test.

=back

=head3 FUNCTION C<testTimes>

Matrix transpose test program.

=head4 Parameters

=over

=item C<mat1>

Reference to matrix to test.

=item C<mat2>

Reference to matrix to test.

=back

=head3 FUNCTION C<testTranspose>

Matrix transpose test program.

=head4 Parameters

=over

=item C<mat>

Reference to matrix to test.

=back

=head3 METHOD C<toString>

Returns a textual representation of this matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=back

=head4 Return

A string.

=head3 METHOD C<transpose>

Return the transpos of this matrix.

=head4 Parameters

=over

=item C<self>

This matrix.

=back

=head4 Return

The transpose fo this matrix

=cut

