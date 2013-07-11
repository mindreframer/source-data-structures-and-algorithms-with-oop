#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SparseMatrixAsArray.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SparseMatrixAsArray.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

# @class Opus10::SparseMatrixAsArray
# Sparse matrix implemented using a two-dimensional array.
# @attr _fill The row fill.
# @attr _values 2D array of non-zero values.
package Opus10::SparseMatrixAsArray;
use Carp;
use Opus10::Declarators;
use Opus10::Matrix;
use Opus10::SparseMatrix;
use Opus10::MultiDimensionalArray;
our @ISA = qw(Opus10::SparseMatrix);

our $VERSION = 1.00;

our $END_OF_ROW = -1;

# @method initialize
# Initializes this sparse matrix
# with the given number of rows and columns and the given row fill.
# @param self This sparse matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns, $fill) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($numberOfRows, $numberOfColumns);
    $self->declare qw(_fill _values _columns);
    $self->{_fill} = $fill;
    $self->{_values} = Opus10::MultiDimensionalArray->new(
	[$numberOfRows, $fill]);
    $self->{_columns} = Opus10::MultiDimensionalArray->new(
	[$numberOfRows, $fill]);
    for (my $i = 0; $i < $numberOfRows; ++$i)
    {
	$self->{_columns}->setItem([$i, 0], $END_OF_ROW);
    }
}

destructor qw(DESTROY);

# @method findPosition
# Returns the column index with the (i,j) element
# of this sparse matrix is stored.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
# @return Column index where (i,j) element is stored.
sub findPosition
{
    my ($self, $i, $j) = @_;
    my $k = 0;
    while ($k < $self->{_fill} &&
	$self->{_columns}->getItem([$i, $k]) != $END_OF_ROW)
    {
	return $k if $self->{_columns}->getItem([$i, $k]) == $j;
	$k += 1;
    }
    return -1;
}

# @method getItem
# Returns the value at the given indices in this sparse matrix.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub getItem
{
    my ($self, $i, $j) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_numberOfRows});
    croak 'IndexError' if ($j < 0 || $j >= $self->{_numberOfColumns});
    my $position = $self->findPosition($i, $j);
    return $position >= 0 ?
	$self->{_values}->getItem([$i, $position]) : 0;
}

# @method setItem
# Sets the entry at the given indices in this sparse matrix
# to the given value.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub setItem
{
    my ($self, $i, $j, $value) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_numberOfRows});
    croak 'IndexError' if ($j < 0 || $j >= $self->{_numberOfColumns});
    my $position = $self->findPosition($i, $j);
    if ($position >= 0)
    {
	$self->{_values}->setItem([$i, $position], $value);
    }
    else
    {
	my $k = 0;
	while ($k < $self->{_fill} &&
	    $self->{_columns}->getItem([$i, $k]) != $END_OF_ROW)
	{
	    $k += 1;
	}
	croak 'IndexError' if $k >= $self->{_fill};
	while ($k > 0 && $self->{_columns}->getItem([$i, $k]) >= $j)
	{
	    $self->{_values}->setItem([$i, $k],
		$self->{_values}->getItem([$k, $k - 1]));
	    $self->{_columns}->setItem([$i, $k],
		$self->{_columns}->getItem([$k, $k - 1]));
	    $k -= 1;
	}
	$self->{_values}->setItem([$i, $k], $value);
	$self->{_columns}->setItem([$i, $k], $j);
    }
}

# @method putZero
# Sets the entry at the given indices in this sparse matrix to zero.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub putZero
{
    my ($self, $i, $j) = @_;
    my $position = $self->findPosition($i, $j);
    if ($position >= 0)
    {
	my $k = $position;
	while ($i < $self->{_numberOfColumns} - 1 &&
	    $self->{_columns}->getItem([$i, $k + 1]) != $END_OF_ROW)
	{
	    $self->{_values}->setItem([$i, $k],
		$self->{_values}->getItem([$k, $k + 1]));
	    $self->{_columns}->setItem([$i, $k],
		$self->{_columns}->getItem([$k, $k + 1]));
	    $k += 1;
	}
	if ($k < $self->{_numberOfColumns})
	{
	    $self->{_columns}->setItem([$i, $k], $END_OF_ROW);
	}
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
    printf "SparseMatrixAsArray test program.\n";
    my $mat = Opus10::SparseMatrixAsArray->new(6, 6, 3);
    #Opus10::Matrix::test($mat);
    #Opus10::Matrix::testTranspose($mat);
    #Opus10::Matrix::testTimes($mat, $mat);
    printf "%s\n", $mat;
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

=head1 MODULE C<Opus10::SparseMatrixAsArray>

=head2 CLASS C<Opus10::SparseMatrixAsArray>

=head3 Base Classes

=over

=item C<Opus10::SparseMatrix>

=back

Sparse matrix implemented using a two-dimensional array.

=head3 ATTRIBUTES

=over

=item C<_fill>

The row fill.

=item C<_values>

2D array of non-zero values.

=back

=head3 METHOD C<findPosition>

Returns the column index with the (i,j) element
of this sparse matrix is stored.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=back

=head4 Return

Column index where (i,j) element is stored.

=head3 METHOD C<getItem>

Returns the value at the given indices in this sparse matrix.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=back

=head3 METHOD C<initialize>

Initializes this sparse matrix
with the given number of rows and columns and the given row fill.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<numberOfRows>

The number of rows.

=item C<numberOfColumns>

The number of columns.

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

=head3 METHOD C<putZero>

Sets the entry at the given indices in this sparse matrix to zero.

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

Sets the entry at the given indices in this sparse matrix
to the given value.

=head4 Parameters

=over

=item C<self>

This sparse matrix.

=item C<i>

Row index.

=item C<j>

Column index.

=back

=cut

