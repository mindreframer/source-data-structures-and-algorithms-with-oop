#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: ZeroOneKnapsackProblem.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ZeroOneKnapsackProblem.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

# @class Opus10::ZeroOneKnapsackProblem::Node
# Represents a node in the solutions space of a 0-1 knapsack problem.
# @attr _problem The 0-1 knapsack problem.
# @attr _totalWeight The total weight.
# @attr _totalProfit The total profit.
# @attr _unplacedProfit The unplaced profit.
# @attr _numberPlaced The number of items placed.
# @attr _x Array indicating placement of items.
package Opus10::ZeroOneKnapsackProblem::Node;
use Carp;
use Opus10::Declarators;
use Opus10::Solution;
our @ISA = qw(Opus10::Solution);

# @method initialize
# Initializes this node in the solution space
# of the given scales balancing problem.
# @param self This node.
# @param problem A 0-1 knapsack problem.
sub initialize
{
    my ($self, $problem) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_problem _totalWeight _totalProfit
	_unplacedProfit _numberPlaced _x);
    $self->{_problem} = $problem;
    $self->{_totalWeight} = 0;
    $self->{_totalProfit} = 0;
    $self->{_unplacedProfit} = 0;
    $self->{_numberPlaced} = 0;
    tie(@{$self->{_x}}, 'Opus10::Array', $problem->getNumberOfItems());
    for (my $i = 0; $i < $self->{_problem}->getNumberOfItems(); ++$i)
    {
	$self->{_unplacedProfit} += $self->{_problem}->getProfit($i);
    }
}

destructor qw(DESTROY);

# The total weight of the weights in the knapsack.
attr_accessor qw(_totalWeight);

# The total profit of the weights in the knapsack.
attr_accessor qw(_totalProfit);

# The total profit of the weights not yet placed.
attr_accessor qw(_unplacedProfit);

# The number of weights placed in or out of the knapsack.
attr_accessor qw(_numberPlaced);

# An array of 0/1 values indicating the placement of weights.
# The value 1 indicates the weight is placed in the knapsack.
attr_accessor qw(_x);

# @method clone
# Returns a clone of this node.
# @param self This node.
# @return A clone of this node.
sub clone
{
    my ($self) = @_;
    my $problem = $self->{_problem};
    my $result = Opus10::ZeroOneKnapsackProblem::Node->new($problem);
    $result->{_totalWeight} = $self->{_totalWeight};
    $result->{_totalProfit} = $self->{_totalProfit};
    $result->{_numberPlaced} = $self->{_numberPlaced};
    for (my $i = 0; $i < $self->{_problem}->getNumberOfItems(); ++$i)
    {
	${$result->{_x}}[$i] = ${$self->{_x}}[$i];
    }
    $result->{_unplacedProfit} = $self->{_unplacedProfit};
    return $result;
}

# @method getObjective
# Returns the value of the objective function for this node.
# @param self This node.
# @return The value of the objective function.
sub getObjective
{
    my ($self) = @_;
    return -$self->{_totalProfit};
}

# @method getBound
# Returns an lower bound on the value of the objective function
# for all the successors of this node in the solution space.
# @param self This node.
# @return A lower bound on the value of the objective function.
sub getBound
{
    my ($self) = @_;
    return -($self->{_totalProfit} + $self->{_unplacedProfit});
}

# @method isFeasible
# IsFeasible predicate.
# @param self This node.
# @return True if this node represents a feasible solution.
sub isFeasible
{
    my ($self) = @_;
    return $self->{_totalWeight} <= $self->{_problem}->getCapacity();
}

# @method isComplete
# IsComplete predicate.
# @param self This node.
# @return True if this node represents a complete solution.
sub isComplete
{
    my ($self) = @_;
    return $self->{_numberPlaced} == $self->{_problem}->getNumberOfItems();
}

# @method placeNext
# Places the next unplaced weight in or out of the knapsack
# according to the given value.
# @param self This node.
# @param value 0 indicate the weight is left out of the knapsack;
#              1 indicates the weight is placed into the knapsack.
sub placeNext
{
    my ($self, $value) = @_;
    my $numberPlaced = $self->{_numberPlaced};
    ${$self->{_x}}[$numberPlaced] = $value;
    if ($value == 1)
    {
	$self->{_totalWeight} +=
	    $self->{_problem}->getWeight($numberPlaced);
	$self->{_totalProfit} +=
	    $self->{_problem}->getProfit($numberPlaced);
	$self->{_unplacedProfit} -=
	    $self->{_problem}->getProfit($numberPlaced);
    }
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
	$s .= ${$self->{_x}}[$i];
    }
    $s .= ', total weight = ' . $self->{_totalWeight};
    $s .= ', total profit = ' . $self->{_totalProfit};
    return $s;
}

# @method successors
# Returns an iterator that enumerates
# the immediates successors of this node
# in the solution space.
# @param self This node.
# @return An iterator.
sub successors
{
    my ($self) = @_;
    my $x = 0; # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if ($x <= 1)
	    {
		$result = $self->clone()->placeNext($x);
		$x += 1;
	    }
	    return $result;
	};
}

#{
# @class Opus10::ZeroOneKnapsackProblem
# Represents a 0-1 knapsack problem.
package Opus10::ZeroOneKnapsackProblem;
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
# Initializes this 0-1 knapsack problem with the given
# arrays of weights and profits and the given knapsack capacity.
# @param self This problem.
# @param weight Array of weights.
# @param profit Array of profits.
# @param capacity Knapsack capacity.
# @method initialize
sub initialize
{
    my ($self, $weight, $profit, $capacity) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_weight _numberOfItems _profit _capacity);
    $self->{_numberOfItems} = $weight->getLength();
    tie(@{$self->{_weight}}, 'Opus10::Array', $weight);
    tie(@{$self->{_profit}}, 'Opus10::Array', $profit);
    $self->{_capacity} = $capacity;
}

destructor qw(DESTROY);

# The number of items.
attr_reader qw(_numberOfItems);

# @method getWeight
# Returns the specified weight.
# @param self This problem.
# @param i An index
# @return The specified weight.
sub getWeight
{
    my ($self, $i) = @_;
    return ${$self->{_weight}}[$i];
}

# @method getProfit
# Returns the specified profit.
# @param self This problem.
# @param i An index
# @return The specified profit.
sub getProfit
{
    my ($self, $i) = @_;
    return ${$self->{_profit}}[$i];
}

# The knapsack capacity.
attr_reader qw(_capacity);

# @method solve
# Solves this 0-1 knapsack problem using the given problem solver.
# @param self This problem.
# @param solver A problem solver.
sub solve
{
    my ($self, $solver) = @_;
    croak 'TypeError' if !$solver->isa('Opus10::Solver');
    return $solver->solve(Opus10::ZeroOneKnapsackProblem::Node->new($self));
}

1;
__DATA__

=head1 MODULE C<Opus10::ZeroOneKnapsackProblem>

=head2 CLASS C<Opus10::ZeroOneKnapsackProblem>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents a 0-1 knapsack problem.

=head3 METHOD C<getProfit>

Returns the specified profit.

=head4 Parameters

=over

=item C<self>

This problem.

=item C<i>

An index

=back

=head4 Return

The specified profit.

=head3 METHOD C<getWeight>

Returns the specified weight.

=head4 Parameters

=over

=item C<self>

This problem.

=item C<i>

An index

=back

=head4 Return

The specified weight.

=head3 METHOD C<initialize>


=head3 METHOD C<solve>

Solves this 0-1 knapsack problem using the given problem solver.

=head4 Parameters

=over

=item C<self>

This problem.

=item C<solver>

A problem solver.

=back

=head2 CLASS C<Opus10::ZeroOneKnapsackProblem::Node>

=head3 Base Classes

=over

=item C<Opus10::Solution>

=back

Represents a node in the solutions space of a 0-1 knapsack problem.

=head3 ATTRIBUTES

=over

=item C<_numberPlaced>

The number of items placed.

=item C<_problem>

The 0-1 knapsack problem.

=item C<_totalProfit>

The total profit.

=item C<_totalWeight>

The total weight.

=item C<_unplacedProfit>

The unplaced profit.

=item C<_x>

Array indicating placement of items.

=back

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

Returns an lower bound on the value of the objective function
for all the successors of this node in the solution space.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

A lower bound on the value of the objective function.

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

A 0-1 knapsack problem.

=back

=head3 METHOD C<isComplete>

IsComplete predicate.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

True if this node represents a complete solution.

=head3 METHOD C<isFeasible>

IsFeasible predicate.

=head4 Parameters

=over

=item C<self>

This node.

=back

=head4 Return

True if this node represents a feasible solution.

=head3 METHOD C<placeNext>

Places the next unplaced weight in or out of the knapsack
according to the given value.

=head4 Parameters

=over

=item C<self>

This node.

=item C<value>

0 indicate the weight is left out of the knapsack;
1 indicates the weight is placed into the knapsack.

=back

=head3 METHOD C<successors>

Returns an iterator that enumerates
the immediates successors of this node
in the solution space.

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

