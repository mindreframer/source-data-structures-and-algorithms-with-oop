#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: Vertex.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Vertex.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Vertex
# Abstract base class from which all vertex classes are derived.
package Opus10::Vertex;
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

# @method getNumber
# Returns the number of this vertex.
# @param self This vertex.
# @return The number of this vertex.
abstract_method qw(getNumber);

# @method getWeight
# Returns the weight on this vertex.
# @param self This vertex.
# @return The weight on this vertex.
abstract_method qw(getWeight);

# @method incidentEdges
# Returns an iterator that enumerates
# the incident edges of of this vertex.
# @param self This vertex.
# @return An iterator.
abstract_method qw(incidentEdges);

# @method emanatingEdges
# Returns an iterator that enumerates
# the emanating edges of of this vertex.
# @param self This vertex.
# @return An iterator.
abstract_method qw(emanatingEdges);

# @method predecessors
# Returns an iterator that enumerates
# the predecessor vertices of of this vertex.
# @param self This vertex.
# @return An iterator.
abstract_method qw(predecessors);

# @method successors
# Returns an iterator that enumerates
# the successor vertices of of this vertex.
# @param self This vertex.
# @return An iterator.
abstract_method qw(successors);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Vertex>

=head2 CLASS C<Opus10::Vertex>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Abstract base class from which all vertex classes are derived.

=head3 METHOD C<emanatingEdges>

Returns an iterator that enumerates
the emanating edges of of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<getNumber>

Returns the number of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

The number of this vertex.

=head3 METHOD C<getWeight>

Returns the weight on this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

The weight on this vertex.

=head3 METHOD C<incidentEdges>

Returns an iterator that enumerates
the incident edges of of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<initialize>

Initializes this queue.

=head4 Parameters

=over

=item C<self>

This queue.

=back

=head3 METHOD C<predecessors>

Returns an iterator that enumerates
the predecessor vertices of of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<successors>

Returns an iterator that enumerates
the successor vertices of of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=cut

