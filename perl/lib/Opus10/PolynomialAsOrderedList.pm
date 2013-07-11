#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: PolynomialAsOrderedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: PolynomialAsOrderedList.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::PolynomialAsOrderedList
# Polynomial implemented as an ordered list of terms.
# @attr _list The list.
package Opus10::PolynomialAsOrderedList;
use Opus10::Declarators;
use Opus10::Polynomial;
use Opus10::OrderedListAsLinkedList;
our @ISA = qw(Opus10::Polynomial);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this polynomial.
# @param self This polynomial.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_list);
    $self->{_list} = Opus10::OrderedListAsLinkedList->new();
}

destructor qw(DESTROY);

delegate qw(addTerm _list insert);
delegate qw(each _list);
delegate qw(find _list);
delegate qw(withdraw _list);
#}>a

delegate qw(purge _list);
delegate qw(toString _list);

1;
__DATA__

=head1 MODULE C<Opus10::PolynomialAsOrderedList>

=head2 CLASS C<Opus10::PolynomialAsOrderedList>

=head3 Base Classes

=over

=item C<Opus10::Polynomial>

=back

Polynomial implemented as an ordered list of terms.

=head3 ATTRIBUTES

=over

=item C<_list>

The list.

=back

=head3 METHOD C<initialize>

Initializes this polynomial.

=head4 Parameters

=over

=item C<self>

This polynomial.

=back

=cut

