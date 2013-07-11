#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SparseMatrix.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SparseMatrix.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

# @class Opus10::SparseMatrix
# Abstract base class from which all sparse matrix classes are derived.
package Opus10::SparseMatrix;
use Opus10::Declarators;
use Opus10::Matrix;
our @ISA = qw(Opus10::Matrix);

our $VERSION = 1.00;

# @method initialize
# Initializes this matrix with the given number of rows and columns.
# @param class The class of the matrix.
# @param numberOfRows The number of rows.
# @param numberOfColumns The number of columns.
sub initialize
{
    my ($self, $numberOfRows, $numberOfColumns) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($numberOfRows, $numberOfColumns);
}

destructor qw(DESTROY);

# @method putZero
# Sets the entry at the given row and column in this sparse matrix to zero.
# @param self This sparse matrix.
# @param i Row index.
# @param j Column index.
abstract_method qw(putZero);

1;
__DATA__

=head1 MODULE C<Opus10::SparseMatrix>

=head2 CLASS C<Opus10::SparseMatrix>

=head3 Base Classes

=over

=item C<Opus10::Matrix>

=back

Abstract base class from which all sparse matrix classes are derived.

=head3 METHOD C<initialize>

Initializes this matrix with the given number of rows and columns.

=head4 Parameters

=over

=item C<class>

The class of the matrix.

=item C<numberOfRows>

The number of rows.

=item C<numberOfColumns>

The number of columns.

=back

=head3 METHOD C<putZero>

Sets the entry at the given row and column in this sparse matrix to zero.

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

