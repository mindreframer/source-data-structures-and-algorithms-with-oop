#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SparseMatrixAsLinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SparseMatrixAsLinkedList.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

# @class Opus10::SparseMatrixAsLinkedList::Entry
# Represents an entry in the sparse matrix.
# @attr _row A row index.
# @attr _column A column index.
# @attr _value A value.
package Opus10::SparseMatrixAsLinkedList::Entry;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
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

# @class Opus10::SparseMatrixAsLinkedList
# Sparse matrix implemented as an array of linked lists.
# @attr _lists Array of linked lists.
package Opus10::SparseMatrixAsLinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Matrix;
use Opus10::SparseMatrix;
use Opus10::Array;
use Opus10::LinkedList;
our @ISA = qw(Opus10::SparseMatrix);

our $VERSION = 1.00;

our $END_OF_ROW = -1;

# @method initialize
# Initializes this sparse matrix with the given number of rows and columns.
# @param self This matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($numberOfRows, $numberOfColumns);
    $self->declare qw(_lists);
    tie (@{$self->{_lists}}, 'Opus10::Array', $self->{_numberOfRows});
    for (my $i = 0; $i < $self->{_numberOfRows}; ++$i)
    {
	${$self->{_lists}}[$i] = Opus10::LinkedList->new();
    }
}

destructor qw(DESTROY);

attr_accessor qw(_lists);

# @method getItem
# Returns the value at the given indices in this sparse matrix.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
# @return The value at the given indices.
sub getItem
{
    my ($self, $i, $j) = @_;
    croak 'IndexError' if $i < 0 || $i >= $self->{_numberOfRows};
    croak 'IndexError' if $j < 0 || $j >= $self->{_numberOfColumns};
    my $ptr = ${$self->{_lists}}[$i]->getHead();
    while (defined($ptr))
    {
	my $entry = $ptr->getDatum();
	if ($entry->getColumn() == $j)
	{
	    return $entry->getDatum();
	}
	last if $entry->getColumn() > $j;
	$ptr = $ptr->getSucc();
    }
    return 0;
}

# @method setItem
# Sets the entry at the given indices in this sparse matrix
# to the given value.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
# @param value A value.
sub setItem
{
    my ($self, $i, $j, $value) = @_;
    croak 'IndexError' if $i < 0 || $i >= $self->{_numberOfRows};
    croak 'IndexError' if $j < 0 || $j >= $self->{_numberOfColumns};
    my $ptr = ${$self->{_lists}}[$i]->getHead();
    while (defined($ptr))
    {
	my $entry = $ptr->getDatum();
	if ($entry->getColumn() == $j)
	{
	    $entry->setDatum($value);
	    return;
	}
	elsif ($entry->getColumn() > $j)
	{
	    $ptr->insertBefore(
		Opus10::SparseMatrixAsLinkedList::Entry->new($i, $j, $value));
	    return;
	}
	$ptr = $ptr->getSucc();
    }
    ${$self->{_lists}}[$i]->append(
	Opus10::SparseMatrixAsLinkedList::Entry->new($i, $j, $value));
}

# @method putZero
# Sets the entry at the given indices in this sparse matrix to zero.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
sub putZero
{
    my ($self, $i, $j, $value) = @_;
    croak 'IndexError' if $i < 0 || $i >= $self->{_numberOfRows};
    croak 'IndexError' if $j < 0 || $j >= $self->{_numberOfColumns};
    my $ptr = ${$self->{_lists}}[$i]->getHead();
    while (defined($ptr))
    {
	my $entry = $ptr->getDatum();
	if ($entry->getColumn() == $j)
	{
	    ${$self->{_lists}}[$i]->extract($entry);
	    return;
	}
	$ptr = $ptr->getSucc();
    }
}

# @method transpose
# Returns the transpose of this sparse matrix.
# @param self This sparse matrix.
# @return The transpose of this matrix.
sub transpose
{
    my ($self) = @_;
    my $rows = $self->{_numberOfRows};
    my $cols = $self->{_numberOfColumns};
    my $result = Opus10::SparseMatrixAsLinkedList->new($cols, $rows);
    for (my $i = 0; $i < $self->{_numberOfColumns}; $i++)
    {
	my $ptr = ${$self->{_lists}}[$i]->getHead();
	while (defined($ptr))
	{
	    my $entry = $ptr->getDatum();
	    ${$result->{_lists}}[$entry->getColumn()]->append(
		Opus10::SparseMatrixAsLinkedList::Entry->new(
		    $entry->getColumn(), $entry->getRow(),
		    $entry->getDatum()));
	    $ptr = $ptr->getSucc();
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
    printf "SparseMatrixAsLinkedList test program.\n";
    my $mat = Opus10::SparseMatrixAsLinkedList->new(6, 6);
    #Opus10::Matrix::test($mat);
    Opus10::Matrix::testTranspose($mat);
    #Opus10::Matrix::testTimes($mat, $mat);
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

=head1 MODULE C<Opus10::SparseMatrixAsLinkedList>

=head2 CLASS C<Opus10::SparseMatrixAsLinkedList>

=head3 Base Classes

=over

=item C<Opus10::SparseMatrix>

=back

Sparse matrix implemented as an array of linked lists.

=head3 ATTRIBUTES

=over

=item C<_lists>

Array of linked lists.

=back

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

=head4 Return

The value at the given indices.

=head3 METHOD C<initialize>

Initializes this sparse matrix with the given number of rows and columns.

=head4 Parameters

=over

=item C<self>

This matrix.

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

=head4 Return

The transpose of this matrix.

=head2 CLASS C<Opus10::SparseMatrixAsLinkedList::Entry>

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

