#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: Solution.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Solution.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Solution
# Represents a node in the solution-space of a problem.
package Opus10::Solution;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

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

# @method isFeasible
# Returns true if this node represents a feasible solution.
# @param self This solution.
# @return True if this node represents a feasible solution.
abstract_method qw(isFeasible);

# @method isComplete
# Returns true if this node represents a complete solution.
# @param self This solution.
# @return True if this node represents a complete solution.
abstract_method qw(isComplete);

# @method getObjective
# Returns the value of objective function for this node.
# @param self This solution.
# @return The value of objective function.
abstract_method qw(getObjective);

# @method getBound
# Returns an upper bound on the value of objective function for this node
# and all it successors in the solution space.
# @param self This solution.
# @return An upper bound.
abstract_method qw(getBound);

# @method successors
# Returns an iterator that enumerates
# the immediate successors of this node.
# @param self This solution.
# @return An iterator.
abstract_method qw(successors);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Solution>

=head2 CLASS C<Opus10::Solution>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Represents a node in the solution-space of a problem.

=head3 METHOD C<getBound>

Returns an upper bound on the value of objective function for this node
and all it successors in the solution space.

=head4 Parameters

=over

=item C<self>

This solution.

=back

=head4 Return

An upper bound.

=head3 METHOD C<getObjective>

Returns the value of objective function for this node.

=head4 Parameters

=over

=item C<self>

This solution.

=back

=head4 Return

The value of objective function.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<isComplete>

Returns true if this node represents a complete solution.

=head4 Parameters

=over

=item C<self>

This solution.

=back

=head4 Return

True if this node represents a complete solution.

=head3 METHOD C<isFeasible>

Returns true if this node represents a feasible solution.

=head4 Parameters

=over

=item C<self>

This solution.

=back

=head4 Return

True if this node represents a feasible solution.

=head3 METHOD C<successors>

Returns an iterator that enumerates
the immediate successors of this node.

=head4 Parameters

=over

=item C<self>

This solution.

=back

=head4 Return

An iterator.

=cut

