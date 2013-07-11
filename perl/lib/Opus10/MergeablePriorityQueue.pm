#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: MergeablePriorityQueue.pm,v $
#   $Revision: 1.2 $
#
#   $Id: MergeablePriorityQueue.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::MergeablePriorityQueue
# Abstract base class from which all mergeable priority queue classes
# are derived.
package Opus10::MergeablePriorityQueue;
use Opus10::Declarators;
use Opus10::PriorityQueue;
our @ISA = qw(Opus10::PriorityQueue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this mergeable priority queue.
# @param self This mergeable priority queue.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method merge
# Merges this priority queue with the given priority queue.
# @param self This mergeable priority queue.
# @param pqueue A mergeable priority queue.
abstract_method qw(merge);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::MergeablePriorityQueue>

=head2 CLASS C<Opus10::MergeablePriorityQueue>

=head3 Base Classes

=over

=item C<Opus10::PriorityQueue>

=back

Abstract base class from which all mergeable priority queue classes
are derived.

=head3 METHOD C<initialize>

Initializes this mergeable priority queue.

=head4 Parameters

=over

=item C<self>

This mergeable priority queue.

=back

=head3 METHOD C<merge>

Merges this priority queue with the given priority queue.

=head4 Parameters

=over

=item C<self>

This mergeable priority queue.

=item C<pqueue>

A mergeable priority queue.

=back

=cut

