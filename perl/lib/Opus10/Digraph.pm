#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Digraph.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Digraph.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Digraph
# Abstract base class from which all digraph classes are derived.
package Opus10::Digraph;
use Carp;
use Opus10::Declarators;
use Opus10::Graph;
use Opus10::Array;
use Opus10::QueueAsLinkedList;
our @ISA = qw(Opus10::Graph);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this graph with the given maximum number of vertices.
# @param self This graph.
# @param size The maximum number of vertices.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($size);
    $self->{_directed} = 1;
}

destructor qw(DESTROY);
#}>a

#{
# @method topologicalOrderTraversal
# Calls the given visitor function for
# the vertices of this digraph in topological traversal order.
# @param self This digraph.
# @param visitor A visitor function.
sub topologicalOrderTraversal
{
    my ($self, $visitor) = @_;
    tie(my @inDegree, 'Opus10::Array',
	$self->{_numberOfVertices});
    for (my $v = 0; $v < $self->{_numberOfVertices}; ++$v)
    {
	$inDegree[$v] = 0;
    }
    my $edges = $self->edges();
    while (defined(my $e = $edges->()))
    {
	$inDegree[$e->getV1()->getNumber()] += 1;
    }
    my $queue = Opus10::QueueAsLinkedList->new();
    for (my $v = 0; $v < $self->{_numberOfVertices}; ++$v)
    {
	if ($inDegree[$v] == 0)
	{
	    $queue->enqueue($self->getVertex($v));
	}
    }
    while (!$queue->isEmpty())
    {
	my $v = $queue->dequeue();
	&$visitor($v);
	my $successors = $v->successors();
	while (defined(my $to = $successors->()))
	{
	    $inDegree[$to->getNumber()] -= 1;
	    if ($inDegree[$to->getNumber()] == 0)
	    {
		$queue->enqueue($to);
	    }
	}
    }
}
#}>b

#{
# @method isStronglyConnected
# Returns true if this digraph is strongly connected.
# @param self This digraph.
# @return True if this digraph is strongly connected.
sub isStronglyConnected
{
    my ($self) = @_;
    for (my $v = 0; $v < $self->{_numberOfVertices}; ++$v)
    {
	my $count = 0;
	$self->depthFirstTraversal(0,
	    sub
	    {
		my ($obj, $mode) = @_;
		if ($mode == Opus10::Graph::PREVISIT)
		{
		    $count += 1;
		}
	    }
	);
	if ($count != $self->{_numberOfVertices})
	{
	    return 0;
	}
    }
    return 1;
}
#}>c

#{
# @method isCyclic
# Returns true if this digraph is cyclic.
# @param self This digraph.
# @return True if this digraph is cyclic.
sub isCyclic
{
    my ($self) = @_;
    my $count = 0;
    $self->topologicalOrderTraversal(
	sub
	{
	    $count += 1;
	}
    );
    return $count != $self->{_numberOfVertices} ? 1 : 0;
}
#}>d

# @function test
# Digraph test program.
# @param g The digraph to test.
sub test
{
    my ($g) = @_;
    printf "Digraph test program.\n";
    Opus10::Graph::test($g);

    printf "TopologicalOrderTraversal\n";
    $g->topologicalOrderTraversal(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );

    printf "isCyclic returns %d\n", $g->isCyclic();
    printf "isStronglyConnected returns %d\n", $g->isStronglyConnected();
}

# @function testWeighted
# Weighted digraph test program.
# @param g The weighted digraph to test.
sub testWeighted
{
    my ($g) = @_;
    printf "Weighted digraph test program.\n";
    Opus10::Graph::testWeighted($g);
}

1;
__DATA__

=head1 MODULE C<Opus10::Digraph>

=head2 CLASS C<Opus10::Digraph>

=head3 Base Classes

=over

=item C<Opus10::Graph>

=back

Abstract base class from which all digraph classes are derived.

=head3 METHOD C<initialize>

Initializes this graph with the given maximum number of vertices.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<size>

The maximum number of vertices.

=back

=head3 METHOD C<isCyclic>

Returns true if this digraph is cyclic.

=head4 Parameters

=over

=item C<self>

This digraph.

=back

=head4 Return

True if this digraph is cyclic.

=head3 METHOD C<isStronglyConnected>

Returns true if this digraph is strongly connected.

=head4 Parameters

=over

=item C<self>

This digraph.

=back

=head4 Return

True if this digraph is strongly connected.

=head3 FUNCTION C<test>

Digraph test program.

=head4 Parameters

=over

=item C<g>

The digraph to test.

=back

=head3 FUNCTION C<testWeighted>

Weighted digraph test program.

=head4 Parameters

=over

=item C<g>

The weighted digraph to test.

=back

=head3 METHOD C<topologicalOrderTraversal>

Calls the given visitor function for
the vertices of this digraph in topological traversal order.

=head4 Parameters

=over

=item C<self>

This digraph.

=item C<visitor>

A visitor function.

=back

=cut

