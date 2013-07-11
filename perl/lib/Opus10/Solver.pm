#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: Solver.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Solver.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Solver
# Abstract base class from which all problem solver classes are derived.
# @attr _bestSolution The best solution so far.
# @attr _bestObjective The value of the objective function
# for the best solution.
package Opus10::Solver;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::Solution;
use Opus10::Integer;
our @ISA = qw(Opus10::Object);

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
    $self->declare qw(_bestSolution _bestObjective);
    $self->{_bestSolution} = undef;
    $self->{_bestObjective} = Opus10::Integer::MAXINT;
}

destructor qw(DESTROY);

# @method search
# Searches the solution space.
# @param self This solver.
abstract_method qw(search);

# @method solve
# Solves a problem by searching its solution space starting from
# the given initial node.
# @param self This solver.
# @param initial A node in the solution space of a problem.
# @return The best solution.
sub solve
{
    my ($self, $initial) = @_;
    croak 'TypeError' if !$initial->isa('Opus10::Solution');
    $self->{_bestSolution} = undef;
    $self->{_bestObjective} = Opus10::Integer::MAXINT;
    $self->search($initial);
    return $self->{_bestSolution};
}

# @method updateBest
# Updates the current best solution with the given solution
# if the given solution is complete, feasible,
# and the value of its objective function is better than
# the current best solution.
# @param self This solver.
# @param solution A node in the solution space of a problem.
sub updateBest
{
    my ($self, $solution) = @_;
    if ($solution->isComplete() && $solution->isFeasible() &&
	    $solution->getObjective() < $self->{_bestObjective})
    {
	$self->{_bestSolution} = $solution;
	$self->{_bestObjective} = $solution->getObjective();
    }
}
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Solver>

=head2 CLASS C<Opus10::Solver>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Abstract base class from which all problem solver classes are derived.

=head3 ATTRIBUTES

=over

=item C<_bestObjective>

The value of the objective function
for the best solution.

=item C<_bestSolution>

The best solution so far.

=back

=head3 METHOD C<initialize>

Initializes this sorter.

=head4 Parameters

=over

=item C<self>

This sorter.

=back

=head3 METHOD C<search>

Searches the solution space.

=head4 Parameters

=over

=item C<self>

This solver.

=back

=head3 METHOD C<solve>

Solves a problem by searching its solution space starting from
the given initial node.

=head4 Parameters

=over

=item C<self>

This solver.

=item C<initial>

A node in the solution space of a problem.

=back

=head4 Return

The best solution.

=head3 METHOD C<updateBest>

Updates the current best solution with the given solution
if the given solution is complete, feasible,
and the value of its objective function is better than
the current best solution.

=head4 Parameters

=over

=item C<self>

This solver.

=item C<solution>

A node in the solution space of a problem.

=back

=cut

