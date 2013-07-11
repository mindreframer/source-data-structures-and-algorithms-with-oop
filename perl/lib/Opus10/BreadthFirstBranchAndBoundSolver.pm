#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BreadthFirstBranchAndBoundSolver.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BreadthFirstBranchAndBoundSolver.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BreadthFirstBranchAndBoundSolver
# Breadth-first branch-and-bound problem solver.
package Opus10::BreadthFirstBranchAndBoundSolver;
use Carp;
use Opus10::Declarators;
use Opus10::Solver;
use Opus10::QueueAsLinkedList;
our @ISA = qw(Opus10::Solver);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this sorter.
# @param self This sorter.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method search
# Does a breadth-first traversal of the solution space
# starting from the given initial node.
# @param self This solver.
# @param initial A node in the solution space of a problem.
sub search
{
    my ($self, $initial) = @_;
    my $queue = Opus10::QueueAsLinkedList->new();
    if ($initial->isFeasible())
    {
	$queue->enqueue($initial);
    }
    while (!$queue->isEmpty())
    {
	my $current = $queue->dequeue();
	if ($current->isComplete())
	{
	    $self->updateBest($current);
	}
	else
	{
	    my $successors = $current->successors();
	    while (defined(my $succ = $successors->()))
	    {
		if ($succ->isFeasible() &&
		    $succ->getBound() < $self->{_bestObjective})
		{
		    $queue->enqueue($succ);
		}
	    }
	}
    }
}
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::BreadthFirstBranchAndBoundSolver>

=head2 CLASS C<Opus10::BreadthFirstBranchAndBoundSolver>

=head3 Base Classes

=over

=item C<Opus10::Solver>

=back

Breadth-first branch-and-bound problem solver.

=head3 METHOD C<initialize>

Initializes this sorter.

=head4 Parameters

=over

=item C<self>

This sorter.

=back

=head3 METHOD C<search>

Does a breadth-first traversal of the solution space
starting from the given initial node.

=head4 Parameters

=over

=item C<self>

This solver.

=item C<initial>

A node in the solution space of a problem.

=back

=cut

