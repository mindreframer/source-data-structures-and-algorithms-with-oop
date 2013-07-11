#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: SortedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SortedList.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SortedList
# Abstract base class from which all sorted lists are derived.
package Opus10::SortedList;
use Opus10::Declarators;
use Opus10::OrderedList;
our @ISA = qw(Opus10::OrderedList);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this queue.
# @param self This queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);
#}>a

use Opus10::Box;

# @function test
# SortedList test program.
# @param list The sorted list to test.
sub test
{
    my ($list) = @_;
    printf "SortedList test program.\n";
    $list->insert(box(4));
    $list->insert(box(3));
    $list->insert(box(2));
    $list->insert(box(1));
    printf "%s\n", $list;
    my $obj = $list->find(box(2));
    $list->withdraw($obj);
    printf "%s\n", $list;
    my $iter = $list->iter();
    while (defined(my $item = $iter->()))
    {
	printf "%s\n", $item;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::SortedList>

=head2 CLASS C<Opus10::SortedList>

=head3 Base Classes

=over

=item C<Opus10::OrderedList>

=back

Abstract base class from which all sorted lists are derived.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 FUNCTION C<test>

SortedList test program.

=head4 Parameters

=over

=item C<list>

The sorted list to test.

=back

=cut

