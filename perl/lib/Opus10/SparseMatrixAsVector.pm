#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SparseMatrixAsVector.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SparseMatrixAsVector.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

# @class Opus10::SparseMatrixAsVector::Entry
# Represents an entry in the sparse matrix.
# @attr _row A row index.
# @attr _column A column index.
# @attr _value A value.
package Opus10::SparseMatrixAsVector::Entry;
use Carp;
use Opus10::Object;
use Opus10::Array;
use Opus10::Declarators;
our @ISA = qw(Opus10::Object);

our $VERSION = 1.00;

# @method initialize
# Initializes this entry with the given row and column indices
# and data value.
# @param self This entry.
# @param row Row index.
# @param column Column index.
# @param datum A value.
sub initialize
{
    my ($self, $row, $column, $datum) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_row _column _datum);
    $self->{_row} = $row;
    $self->{_column} = $column;
    $self->{_datum} = $datum;
}

destructor qw(DESTROY);

attr_accessor qw(_row);
attr_accessor qw(_column);
attr_accessor qw(_datum);

# @class Opus10::SparseMatrixAsVector
# Sparse matrix implemented as a vector of non-zero entries.
# @attr _fill The row fill.
# @attr _values 2D array of non-zero values.
package Opus10::SparseMatrixAsVector;
use Carp;
use Opus10::Declarators;
use Opus10::Matrix;
use Opus10::SparseMatrix;
use Opus10::Array;
our @ISA = qw(Opus10::SparseMatrix);

our $VERSION = 1.00;

our $END_OF_ROW = -1;

# @method initialize
# Initializes this sparse matrix with the given number of
# rows, columns, and non-zero elements.
# @param self This matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
# @param numberOfElements The number of non-zero elements.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns, $numberOfElements) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($numberOfRows, $numberOfColumns);
    $self->declare qw(_array _numberOfElements);
    $self->{_numberOfElements} = $numberOfElements;
    tie (@{$self->{_array}}, 'Opus10::Array', $numberOfElements);
    for (my $i = 0; $i < $self->{_numberOfElements}; ++$i)
    {
	${$self->{_array}}[$i] =
	    Opus10::SparseMatrixAsVector::Entry->new(0, 0, 0);
    }
}

destructor qw(DESTROY);

attr_accessor qw(_array);

attr_accessor qw(_numberOfElements);

# @method findPosition
# Returns the position in the vector of the entry with the given indices.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub findPosition
{
    my ($self, $i, $j) = @_;
    my $target = $i * $self->{_numberOfColumns} + $j;
    my $left = 0;
    my $right = $self->{_numberOfElements} - 1;
    while ($left <= $right)
    {
	my $middle = int(($left + $right) / 2);
	my $probe = ${$self->{_array}}[$middle]->getRow()
	    * $self->{_numberOfColumns}
		+ ${$self->{_array}}[$middle]->getColumn();
	if ($target > $probe)
	{
	    $left = $middle + 1;
	}
	elsif ($target < $probe)
	{
	    $right = $middle - 1;
	}
	else
	{
	    return $middle
	}
    }
    return -1;
}

# @method getItem
# Returns the value in this sparse matrix at the given indices.
# @param self This sparse matrix.
# @param i The row index.
# @param j The column index.
# @return The value at the given indices.
sub getItem
{
    my ($self, $i, $j) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_numberOfRows});
    croak 'IndexError' if ($j < 0 || $j >= $self->{_numberOfColumns});
    my $position = $self->findPosition($i, $j);
    if ($position >= 0)
    {
	return ${$self->{_array}}[$position]->getDatum();
    }
    else
    {
	return 0;
    }
}

# @method setItem
# Sets the entry in this sparse matrix at the given indices
# to the given (non-zero) value.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
# @param value A value.
sub setItem
{
    my ($self, $i, $j, $value) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_numberOfRows});
    croak 'IndexError' if ($j < 0 || $j >= $self->{_numberOfColumns});
    my $position = $self->findPosition($i, $j);
    if ($position >= 0)
    {
	${$self->{_array}}[$position]->setDatum($value);
    }
    else
    {
	my $len = @{$self->{_array}};
	if ($len == $self->{_numberOfElements})
	{
	    $#{$self->{_array}} = 2 * $len - 1;
	    for (my $p = $len; $p < 2 * $len; ++$p)
	    {
		${$self->{_array}}[$p] =
		    Opus10::SparseMatrixAsVector::Entry->new(0, 0, 0);
	    }
	}
	my $k = $self->{_numberOfElements};
	while ($k > 0 && (${$self->{_array}}[$k - 1]->getRow() > $i ||
		${$self->{_array}}[$k - 1]->getRow() == $i &&
		${$self->{_array}}[$k - 1]->getColumn() >= $j))
	{
	    ${$self->{_array}}[$k] = ${$self->{_array}}[$k - 1];
	    $k = $k - 1;
	}
	${$self->{_array}}[$k] =
	    Opus10::SparseMatrixAsVector::Entry->new($i, $j, $value);
	$self->{_numberOfElements} += 1;
    }
}

# @method putZero
# Sets the entry at the given indices of this sparse matrix to zero.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub putZero
{
    my ($self, $i, $j) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_numberOfRows});
    croak 'IndexError' if ($j < 0 || $j >= $self->{_numberOfColumns});
    my $position = $self->findPosition($i, $j);
    if ($position >= 0)
    {
	$self->{_numberOfElements} -= 1;
	my $k;
	for ($k = $position; $k < $self->{_numberOfElements}; ++$k)
	{
	    ${$self->{_array}}[$k] = ${$self->{_array}}[$k + 1];
	}
	${$self->{_array}}[$k] =
	    Opus10::SparseMatrixAsVector::Entry->new($i, $j, 0);
    }
}

# @method transpose
# Returns the transpose of this sparse matrix.
# @param self This sparse matrix.
sub transpose
{
    my ($self) = @_;
    my $cols = $self->{_numberOfColumns};
    my $rows = $self->{_numberOfRows};
    my $elems = $self->{_numberOfElements};
    my $result  = Opus10::SparseMatrixAsVector->new($rows, $cols, $elems);
    tie (my @offset, 'Opus10::Array', $self->{_numberOfColumns});
    for (my $i = 0; $i < $self->{_numberOfColumns}; ++$i)
    {
	$offset[$i] = 0
    }
    for (my $i = 0; $i < $self->{_numberOfElements}; ++$i)
    {
	$offset[${$self->{_array}}[$i]->getColumn()] += 1;
    }
    my $sum = 0;
    for (my $ i = 0; $i < $self->{_numberOfColumns}; ++$i)
    {
	my $tmp = $offset[$i];
	$offset[$i] = $sum;
	$sum = $sum + $tmp;
    }
    for (my $i = 0; $i < $self->{_numberOfElements}; ++$i)
    {
	${$result->{_array}}[$offset[${$self->{_array}}[$i]->getColumn()]] =
	    Opus10::SparseMatrixAsVector::Entry->new(
		${$self->{_array}}[$i]->getColumn(),
		${$self->{_array}}[$i]->getRow(),
		${$self->{_array}}[$i]->getDatum());
	$offset[${$self->{_array}}[$i]->getColumn()] =
	    $offset[${$self->{_array}}[$i]->getColumn()] + 1;
    }
    $result->{_numberOfElements} = $self->{_numberOfElements};
    return $result;
}

# @method mul
# Multiplication operator.
# @param self This parse matrix.
# @param mat The given sparse matrix.
# @return The product of this sparse matrix and the given sparse matrix.
sub mul
{
    my ($self, $mat) = @_;
    croak 'DomainError' if $self->{_numberOfColumns} != $mat->{_numberOfRows};
    my $matT = $mat->transpose();
    my $rows = $self->{_numberOfRows};
    my $cols = $matT->{_numberOfRows};
    my $elems = $self->{_numberOfRows} + $matT->{_numberOfRows};
    my $result = Opus10::SparseMatrixAsVector->new($rows, $cols, $elems);
    my $iPosition = 0;
    while ($iPosition < $self->{_numberOfElements})
    {
	my $i = ${$self->{_array}}[$iPosition]->getRow();
	my $jPosition = 0;
	while ($jPosition < $matT->{_numberOfElements})
	{
	    my $j = ${$matT->{_array}}[$jPosition]->getRow();
	    my $sum = 0;
	    my $k1 = $iPosition;
	    my $k2 = $jPosition;
	    while ($k1 < $self->{_numberOfElements}
		    && ${$self->{_array}}[$k1]->getRow() == $i
		    && $k2 < $matT->{_numberOfElements}
		    && ${$matT->{_array}}[$k2]->getRow() == $j)
	    {
		if (${$self->{_array}}[$k1]->getColumn()
			< ${$matT->{_array}}[$k2]->getColumn())
		{
		    $k1 += 1;
		}
		elsif (${$self->{_array}}[$k1]->getColumn()
			> ${$matT->{_array}}[$k2]->getColumn())
		{
		    $k2 += 1;
		}
		else
		{
		    $sum = $sum + ${$self->{_array}}[$k1]->getDatum()
			    * ${$matT->{_array}}[$k2]->getDatum();
		    $k1 += 1;
		    $k2 += 1;
		}
	    }
	    if ($sum != 0)
	    {
		$result->setItem($i, $j, $sum);
	    }
	    while ($jPosition < $matT->{_numberOfElements} &&
		    ${$matT->{_array}}[$jPosition]->getRow() == $j)
	    {
		$jPosition += 1;
	    }
	}
	while ($iPosition < $self->{_numberOfElements} &&
		${$self->{_array}}[$iPosition]->getRow() == $i)
	{
	    $iPosition += 1;
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
    printf "SparseMatrixAsVector test program.\n";
    my $mat = Opus10::SparseMatrixAsVector->new(6, 6, 3);
    #Opus10::Matrix::test($mat);
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

=head1 MODULE C<Opus10::SparseMatrixAsVector>

=head2 CLASS C<Opus10::SparseMatrixAsVector>

=head3 Base Classes

=over

=item C<Opus10::SparseMatrix>

=back

Sparse matrix implemented as a vector of non-zero entries.

=head3 ATTRIBUTES

=over

=item C<_fill>

The row fill.

=item C<_values>

2D array of non-zero values.

=back

=head3 METHOD C<findPosition>

Returns the position in the vector of the entry with the given indices.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=back

=head3 METHOD C<getItem>

Returns the value in this sparse matrix at the given indices.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

The row index.

=item C<j>

The column index.

=back

=head4 Return

The value at the given indices.

=head3 METHOD C<initialize>

Initializes this sparse matrix with the given number of
rows, columns, and non-zero elements.

=head4 Parameters

=over

=item C<self>

This matrix.

=item C<numberOfRows>

The number of rows.

=item C<numberOfColumns>

The number of columns.

=item C<numberOfElements>

The number of non-zero elements.

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

=head3 METHOD C<mul>

Multiplication operator.

=head4 Parameters

=over

=item C<self>

This parse matrix.

=item C<mat>

The given sparse matrix.

=back

=head4 Return

The product of this sparse matrix and the given sparse matrix.

=head3 METHOD C<putZero>

Sets the entry at the given indices of this sparse matrix to zero.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=back

=head3 METHOD C<setItem>

Sets the entry in this sparse matrix at the given indices
to the given (non-zero) value.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=item C<value>

A value.

=back

=head3 METHOD C<transpose>

Returns the transpose of this sparse matrix.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=back

=head2 CLASS C<Opus10::SparseMatrixAsVector::Entry>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents an entry in the sparse matrix.

=head3 ATTRIBUTES

=over

=item C<_column>

A column index.

=item C<_row>

A row index.

=item C<_value>

A value.

=back

=head3 METHOD C<initialize>

Initializes this entry with the given row and column indices
and data value.

=head4 Parameters

=over

=item C<self>

This entry.

=item C<row>

Row index.

=item C<column>

Column index.

=item C<datum>

A value.

=back

=cut

