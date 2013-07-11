#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: Edge.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Edge.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Edge
# Abstract base class from which all graph edge classes are derived.
package Opus10::Edge;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this edge.
# @param self This edge.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method getV0
# Returns the vertex at the tail of this edge.
# @param self This edge.
# @return A vertex.
abstract_method qw(getV0);

# @method getV1
# Returns the vertex at the head of this edge.
# @param self This edge
# @return A vertex.
abstract_method qw(getV1);

# @method getWeight
# Returns the weight on this edge.
# @param self Thise edge
# @return The weight.
abstract_method qw(getWeight);

# @method isDirectod
# IsDirected predicate.
# @param sefl This edge
# @return True if this edge is directed.
abstract_method qw(isDirected);

# @method mateOf
# Returns the mate of the given vertex of this edge
# @param self This edge.
# @param v A vertex of this edge.
# @return The mate of the given vertex.
abstract_method qw(mateOf);
#}>a

1;
__DATA__

=head1 MODULE C<Opus10::Edge>

=head2 CLASS C<Opus10::Edge>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Abstract base class from which all graph edge classes are derived.

=head3 METHOD C<getV0>

Returns the vertex at the tail of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head4 Return

A vertex.

=head3 METHOD C<getV1>

Returns the vertex at the head of this edge.

=head4 Parameters

=over

=item C<self>

This edge

=back

=head4 Return

A vertex.

=head3 METHOD C<getWeight>

Returns the weight on this edge.

=head4 Parameters

=over

=item C<self>

Thise edge

=back

=head4 Return

The weight.

=head3 METHOD C<initialize>

Initializes this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head3 METHOD C<isDirectod>

IsDirected predicate.

=head4 Parameters

=over

=item C<sefl>

This edge

=back

=head4 Return

True if this edge is directed.

=head3 METHOD C<mateOf>

Returns the mate of the given vertex of this edge

=head4 Parameters

=over

=item C<self>

This edge.

=item C<v>

A vertex of this edge.

=back

=head4 Return

The mate of the given vertex.

=cut

