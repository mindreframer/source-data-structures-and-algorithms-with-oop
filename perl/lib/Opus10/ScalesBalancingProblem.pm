#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: ScalesBalancingProblem.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ScalesBalancingProblem.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

# @class Opus10::ScalesBalancingProblem::Node
# Represents a node in the solution space of a scales balancing problem.
package Opus10::ScalesBalancingProblem::Node;
use Carp;
use Opus10::Declarators;
use Opus10::Solution;
our @ISA = qw(Opus10::Solution);

# @method initialize
# Initializes this node in the solution space
# of the given scales balancing problem.
# @param self This node.
# @param problem A scales balancing problem.
sub initialize
{
    my ($self, $problem) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_problem _diff _unplacedTotal _numberPlaced _pan);
    $self->{_problem} = $problem;
    $self->{_diff} = 0;
    $self->{_unplacedTotal} = 0;
    $self->{_numberPlaced} = 0;
    tie(@{$self->{_pan}}, 'Opus10::Array',
	$self->{_problem}->getNumberOfWeights());
    for (my $i = 0; $i < $self->{_problem}->getNumberOfWeights(); ++$i)
    {
	$self->{_unplacedTotal} += $self->{_problem}->getWeight($i);
    }
}

destructor qw(DESTROY);

# The difference in weights between the left and right pans.
attr_accessor qw(_diff);

# The number of weights placed in pans.
attr_accessor qw(_numberPlaced);

# The total weight of the weights not yet placed in pans.
attr_accessor qw(_unplacedTotal);

# Array of 0/1 values indicating
# the pan in which each weight has been placed.
attr_accessor qw(_pan);

# @method clone
# Returns a clone of this node.
# @param self This node.
# @return A clone of this node.
sub clone
{
    my ($self) = @_;
    my $problem = $self->{_problem};
    my $result = Opus10::ScalesBalancingProblem::Node->new($problem);
    $result->{_diff} = $self->{_diff};
    $result->{_numberPlaced} = $self->{_numberPlaced};
    for (my $i = 0; $i < $self->{_problem}->getNumberOfWeights(); ++$i)
    {
	${$result->{_pan}}[$i] = ${$self->{_pan}}[$i];
    }
    $result->{_unplacedTotal} = $self->{_unplacedTotal};
    return $result;
}

# @method getObjective
# Returns the value of the objective function for this node.
# @param self This node.
# @return The value of the objective function.
sub getObjective
{
    my ($self) = @_;
    return abs($self->{_diff});
}

# @method getBound
# Returns the lower-bound on the objective function value
# for all the successors of this node in the solution space.
# @param self This node.
# @return A lower bound on the objective function.
sub getBound
{
    my ($self) = @_;
    if (abs($self->{_diff}) > $self->{_unplacedTotal})
    {
	return abs($self->{_diff}) - $self->{_unplacedTotal};
    }
    else
    {
	return 0;
    }
}

# @method isFeasible
# IsFeasible predicate.
# @param self This node.
# @return True if this node is a feasible solution.
sub isFeasible
{
    my ($self) = @_;
    return 1;
}

# @method isComplete
# IsComplete predicate.
# @param self This node.
# @return True if this node is a complete solution.
sub isComplete
{
    my ($self) = @_;
    return $self->{_numberPlaced} == $self->{_problem}->getNumberOfWeights();
}

# @method placeNext
# Places the next unplaced weight in the specified pan.
# @param self This node.
# @param pan The pan in which to place the next weight.
sub placeNext
{
    my ($self, $pan) = @_;
    my $numberPlaced = $self->{_numberPlaced};
    ${$self->{_pan}}[$numberPlaced] = $pan;
    if ($pan == 0)
    {
	$self->{_diff} += $self->{_problem}->getWeight($numberPlaced);
    }
    else
    {
	$self->{_diff} -= $self->{_problem}->getWeight($numberPlaced);
    }
    $self->{_unplacedTotal} -=
	$self->{_problem}->getWeight($numberPlaced);
    $self->{_numberPlaced} += 1;
    return $self;
}

# @method toString
# Returns a string representation of this node.
# @param self This node.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    for (my $i = 0; $i < $self->{_numberPlaced}; ++$i)
    {
	if ($s ne '')
	{
	    $s .= ', ';
	}
	$s .= ${$self->{_pan}}[$i];
    }
    $s = $s . ', diff = ' . $self->{_diff};
    return $s;
}

# @method successors
# Returns an iterator that enumerates
# the immediate successors
# of this node in the solution space.
# @param self This node.
# @return An iterator.
sub successors
{
    my ($self) = @_;
    my $pan = 0; # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if ($pan <= 1)
	    {
		$result = $self->clone()->placeNext($pan);
		$pan += 1;
	    }
	    return $result;
	};
}

#{
# @class Opus10::ScalesBalancingProblem
# Represents a scales-balancing problem.
# @attr _weight The array of weights.
# @attr _numberOfWeights the number of weights.
package Opus10::ScalesBalancingProblem;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::Solution;
use Opus10::Solver;
use Opus10::Array;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this scales balancing problem with the given array of weights.
# @param self This scales balancing problem.
# @param weight An array of weights.
# @param self This sorter.
sub initialize
{
    my ($self, $weight) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_weight _numberOfWeights);
    tie(@{$self->{_weight}}, 'Opus10::Array', $weight);
    $self->{_numberOfWeights} = @{$self->{_weight}};
}

destructor qw(DESTROY);

# @method getWeight
# Return the specified weight of this problem.
# @param self This problem.
# @param i An index.
# @return The specified weight.
sub getWeight
{
    my ($self, $i) = @_;
    return $self->{_weight}[$i];
}

# The number of weights.
attr_reader qw(_numberOfWeights);

# @method solve
# Solves this scales balancing problem using the given problem solver.
# @param self This problem.
# @param solver A problem solver.
sub solve
{
    my ($self, $solver) = @_;
    croak 'TypeError' if !$solver->isa('Opus10::Solver');
    return $solver->solve(Opus10::ScalesBalancingProblem::Node->new($self));
}

1;
__DATA__

=head1 MODULE C<Opus10::ScalesBalancingProblem>

=head2 CLASS C<Opus10::ScalesBalancingProblem>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents a scales-balancing problem.

=head3 ATTRIBUTES

=over

=item C<_numberOfWeights>

the number of weights.

=item C<_weight>

The array of weights.

=back

=head3 METHOD C<getWeight>

Return the specified weight of this problem.

=head4 Parameters

=over

=item C<self>

This problem.

=item C<i>

An index.

=back

=head4 Return

The specified weight.

=head3 METHOD C<initialize>

Initializes this scales balancing problem with the given array of weights.

=head4 Parameters

=over

=item C<self>

This scales balancing problem.

=item C<weight>

An array of weights.

=item C<self>

This sorter.

=back

=head3 METHOD C<solve>

Solves this scales balancing problem using the given problem solver.

=head4 Parameters

=over

=item C<self>

This problem.

=item C<solver>

A problem solver.

=back

=head2 CLASS C<Opus10::ScalesBalancingProblem::Node>

=head3 Base Classes

=over

=item C<Opus10::Solution>

=back

Represents a node in the solution space of a scales balancing problem.

=head3 METHOD C<clone>

Returns a clone of this node.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

A clone of this node.

=head3 METHOD C<getBound>

Returns the lower-bound on the objective function value
for all the successors of this node in the solution space.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

A lower bound on the objective function.

=head3 METHOD C<getObjective>

Returns the value of the objective function for this node.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

The value of the objective function.

=head3 METHOD C<initialize>

Initializes this node in the solution space
of the given scales balancing problem.

=head4 Parameters

=over

=item C<self>

This node.

=item C<problem>

A scales balancing problem.

=back

=head3 METHOD C<isComplete>

IsComplete predicate.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

True if this node is a complete solution.

=head3 METHOD C<isFeasible>

IsFeasible predicate.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

True if this node is a feasible solution.

=head3 METHOD C<placeNext>

Places the next unplaced weight in the specified pan.

=head4 Parameters

=over

=item C<self>

This node.

=item C<pan>

The pan in which to place the next weight.

=back

=head3 METHOD C<successors>

Returns an iterator that enumerates
the immediate successors
of this node in the solution space.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

An iterator.

=head3 METHOD C<toString>

Returns a string representation of this node.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

A string.

=cut

