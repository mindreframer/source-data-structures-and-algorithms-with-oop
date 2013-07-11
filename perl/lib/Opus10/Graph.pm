#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: Graph.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Graph.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Graph::Vertex
# Represents a vertex in a graph.
# @attr _graph The graph for this vertex.
# @attr _number The number of this vertex.
# @attr _weight The weight on this vertex.
package Opus10::Graph::Vertex;
use Carp;
use Opus10::Declarators;
use Opus10::Vertex;
our @ISA = qw(Opus10::Vertex);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this vertex in the given graph
# with the given number and (optional) weight.
# @param self This vertex.
# @param graph The graph of this vertex.
# @param number The number of this vertex.
# @param weight The weight on this vertex. (Optional).
sub initialize
{
    my ($self, $graph, $number, $weight) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_graph _number _weight);
    $self->{_graph} = $graph;
    $self->{_number} = $number;
    $self->{_weight} = $weight;
}

destructor qw(DESTROY);
#}>a

# The number of this vertex.
attr_reader qw(_number);
# The weight of this vertex.
attr_reader qw(_weight);

# @method hash
# Returns the hash value of this vertex.
# @param self This vertex.
# @return An integer.
sub hash
{
    my ($self) = @_;
    my $result = $self->{_number};
    if (defined($self->{_weight}))
    {
	$result += $self->{_weight}->hash();
    }
    return $result;
}

# @method toString
# Returns a string representation of this vertex.
# @param self This vertex.
# @return A string.
sub toString
{
    my ($self) = @_;
    if ($self->{_weight})
    {
	return sprintf("Vertex {%d, weight = %s}",
	    $self->{_number}, $self->{_weight});
    }
    else
    {
	return sprintf("Vertex {%d}", $self->{_number});
    }
}

# @method incidentEdges
# Returns an iterator that enumerates
# the edges incident upon this vertex.
# @param self This vertex.
# @return An iterator.
sub incidentEdges
{
    my ($self) = @_;
    return $self->{_graph}->incidentEdges($self);
}

# @method emanatingEdges
# Returns an iterator that enumerates
# the edges emanating from this vertex.
# @param self This vertex
# @return An iterator.
sub emanatingEdges
{
    my ($self) = @_;
    return $self->{_graph}->emanatingEdges($self);
}

# @method predecessors
# Returns an iterator that enumerates
# the predecessors of this vertex.
# @param self This vertex.
# @return An iterator.
sub predecessors
{
    my ($self) = @_;
    my $f = $self->incidentEdges(); # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    my $e = $f->();
	    if (defined($e))
	    {
		my $n = $self->{_number};
		$result = $e->mateOf(
		    $self->{_graph}->getVertex($n));
	    }
	    return $result;
	};
}

# @method successors
# Returns an iterator that enumerates
# the successors of this vertex.
# @param self This vertex.
# @return An iterator.
sub successors
{
    my ($self) = @_;
    my $f = $self->emanatingEdges(); # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    my $e = $f->();
	    if (defined($e))
	    {
		my $n = $self->{_number};
		$result = $e->mateOf(
		    $self->{_graph}->getVertex($n));
	    }
	    return $result;
	}
}

#{
# @class Opus10::Graph::Edge
# Represents an edge in a graph.
# @attr _graph The graph of this edge.
# @attr _v0 A vertex number.
# @attr _v1 A vertex number.
# @attr _weight The weight on this edge.
package Opus10::Graph::Edge;
use Carp;
use Opus10::Declarators;
use Opus10::Edge;
our @ISA = qw(Opus10::Edge);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this edge in the given graph
# between the given vertices and with the given (optional) weight.
# @param self This edge.
# @param graph The graph of this vertex.
# @param v0 The number of vertex v0.
# @param v1 The number of vertex v1.
# @param weight The weight on this vertex. (Optional).
sub initialize
{
    my ($self, $graph, $v0, $v1, $weight) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_graph _v0 _v1 _weight);
    $self->{_graph} = $graph;
    $self->{_v0} = $v0;
    $self->{_v1} = $v1;
    $self->{_weight} = $weight;
}

destructor qw(DESTROY);
#}>b

# @method getV0
# Returns vertex v0 of this edge.
# @param self This edge.
# @return Vertex v0.
sub getV0
{
    my ($self) = @_;
    my $v0 = $self->{_v0};
    return $self->{_graph}->getVertex($v0);
}

# @method getV1
# Returns vertex v1 of this edge.
# @param self This edge.
# @return Vertex v1.
sub getV1
{
    my ($self) = @_;
    my $v1 = $self->{_v1};
    return $self->{_graph}->getVertex($v1);
}

attr_reader qw(_weight);

# @method mateOf
# Returns the mate of the given vertex of this edge.
# @param self This edge.
# @param v A vertex of this edge.
# @return The mate of v.
sub mateOf
{
    my ($self, $v) = @_;
    if ($v->getNumber() == $self->{_v0})
    {
	my $v1 = $self->{_v1};
	return $self->{_graph}->getVertex($v1);
    }
    elsif ($v->getNumber() == $self->{_v1})
    {
	my $v0 = $self->{_v0};
	return $self->{_graph}->getVertex($v0);
    }
    else
    {
	croak 'ArgumentError';
    }
}

# @method isDirected
# Returns true if this edge is directed.
# @param self This edge
# @return True if this edge is directed.
sub isDirected
{
    my ($self) = @_;
    return $self->{_graph}->isDirected();
}

# @method hash
# Returns the hash value of this edge.
# @param self This edge.
# @return An integer.
sub hash
{
    my ($self) = @_;
    my $result = $self->{_v0} *
	$self->{_graph}->getNumberOfVertices() + $self->{_v1};
    if (defined($self->{_weight}))
    {
	$result += $self->{_weight}->hash();
    }
    return $result;
}

# @method toString
# Returns a string representation of this edge.
# @param self This edge.
# @return A string
sub toString
{
    my ($self) = @_;
    my $s = '' . $self->{_v0};
    if ($self->isDirected())
    {
	$s .= '->' . $self->{_v1};
    }
    else
    {
	$s .= '--' . $self->{_v1};
    }
    if (defined($self->{_weight}))
    {
	$s .= ', weight = ' . $self->{_weight};
    }
    return 'Edge {' . $s . '}';
}

#{
# @class Opus10::Graph
# Abstract base class from which all graph classes are derived.
# @attr _numberOfVertices The number of vertices.
# @attr _numberOfEdges The number of edges.
# @attr _vertex The array of vertices.
# @attr _directed True if the graph is directed.
package Opus10::Graph;
use Carp;
use Opus10::Declarators;
use Opus10::Container;
use Opus10::Vertex;
use Opus10::Edge;
use Opus10::Array;
use Opus10::QueueAsLinkedList;
our @ISA = qw(Opus10::Container);

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
    $self->SUPER::initialize();
    $self->declare qw(_numberOfVertices _numberOfEdges
	_vertex _directed);
    $self->{_numberOfVertices} = 0;
    $self->{_numberOfEdges} = 0;
    tie(@{$self->{_vertex}}, 'Opus10::Array', $size);
    $self->{_directed} = 0;
}

destructor qw(DESTROY);

# The number of vertices.
attr_reader qw(_numberOfVertices);
# The number of edges.
attr_reader qw(_numberOfEdges);

# @method isDirected
# IsDirected predicate.
# @param self This graph.
# @return True if this graph is directed.
sub isDirected
{
    my ($self) = @_;
    return $self->{_directed};
}

# @method getLength
# The maximum number of vertices.
# @param self This graph.
# @return The maximum number of vertices.
sub getLength
{
    my ($self) = @_;
    return scalar(@{$self->{_vertex}});
}

# @method getVertex
# Returns the specified vertex.
# @param self This graph.
# @param v A vertex number.
# @return A vertex.
sub getVertex
{
    my ($self, $v) = @_;
    return ${$self->{_vertex}}[$v];
}
#}>c

#{
# @method isCyclic
# IsCyclic predicate.
# @param self This graph;
# @return True if this graph is cyclic.
abstract_method qw(isCyclic);

# @method edges
# Returns an iterator that enumerates
# the edges of this graph.
# @param self This graph.
# @return An iterator.
abstract_method qw(edges);

# @method addEdge
# Adds an edge to this graph between the given vertices
# and with the (optional) weight.
# @param self This graph.
# @param v0 A vertex number.
# @param v1 A vertex number.
# @param weight The weight of the edge. (Optional).
abstract_method qw(addEdge);

# @method getEdge
# Returns the specified edge of this graph.
# @param self This graph
# @param v0 A vertex number.
# @param v1 A vertex number.
abstract_method qw(getEdge);

# @method isEdge
# Returns true if there is an edge in this graph connecting the given vertices.
# @param self This graph
# @param v0 A vertex number.
# @param v1 A vertex number.
abstract_method qw(isEdge);

# @method incidentEdges
# Returns an iterator that enumerates
# the edges incident upon the given vertex in this graph.
# @param self This graph.
# @param v A vertex in this graph.
# @return An iterator.
abstract_method qw(incidentEdges);

# Returns an iterator that enumerates
# the edges emanating from the given vertex in this graph.
# @param self This graph.
# @param v A vertex in this graph.
# @return An iterator.
abstract_method qw(emanatingEdges);
#}>d

#{
# Pre-visit mode.
use constant PREVISIT => -1;
# Post-visit mode.
use constant POSTVISIT => 1;

# @method depthFirstTraversal
# Calls the given visitor function for the vertices in this graph
# in depth-first traversal order
# starting from the given vertex.
# @param self This graph.
# @param start A vertex in this graph.
# @param visitor A visitor function.
sub depthFirstTraversal
{
    my ($self, $start, $visitor) = @_;
    tie(my @visited, 'Opus10::Array',
	$self->{_numberOfVertices});
    for (my $v = 0; $v < $self->{_numberOfVertices}; ++$v)
    {
	$visited[$v] = 0;
    }
    $self->doDepthFirstTraversal(
	$self->getVertex($start), tied(@visited), $visitor);
}

# @method doDepthFirstTraversal
# Calls the given visitor function for the vertices in this graph
# in depth-first traversal order
# @param self This graph.
# @param start A vertex in this graph.
# @param visitor Boolean array used to keep track of the visited vertices.
# @param visitor A visitor function.
sub doDepthFirstTraversal
{
    my ($self, $v, $visited, $visitor) = @_;
    tie(my @visited, 'Opus10::Array', $visited);
    &$visitor($v, PREVISIT);
    $visited[$v->getNumber()] = 1;
    my $successors = $v->successors();
    while (defined(my $to = $successors->()))
    {
	if (!$visited[$to->getNumber()])
	{
	    $self->doDepthFirstTraversal(
		$to, $visited, $visitor);
	}
    }
    &$visitor($v, POSTVISIT);
}
#}>e

#{
# @method breadthFirstTraversal
# Calls the given visitor function for the vertices in this graph
# this graph in breadth-first traversal order
# @param self This graph.
# @param start A vertex in this graph.
# @param visitor A visitor function.
sub breadthFirstTraversal
{
    my ($self, $start, $visitor) = @_;
    tie(my @enqueued, 'Opus10::Array',
	$self->{_numberOfVertices});
    for (my $v = 0; $v < $self->{_numberOfVertices}; ++$v)
    {
	$enqueued[$v] = 0;
    }
    my $queue = Opus10::QueueAsLinkedList->new();
    $queue->enqueue($self->getVertex($start));
    $enqueued[$start] = 1;
    while (!$queue->isEmpty())
    {
	my $v = $queue->dequeue();
	&$visitor($v);
	my $successors = $v->successors();
	while (defined(my $to = $successors->()))
	{
	    if (!$enqueued[$to->getNumber()])
	    {
		$queue->enqueue($to);
		$enqueued[$to->getNumber()] = 1;
	    }
	}
    }
}
#}>f

#{
# @method isConnected
# IsConnected predicate.
# @param self This graph.
# @return True if this graph is connected.
sub isConnected
{
    my ($self) = @_;
    my $count = 0;
    $self->depthFirstTraversal(0,
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == PREVISIT)
	    {
		$count += 1;
	    }
	}
    );
    return $count == $self->{_numberOfVertices} ? 1 : 0;
}
#}>g

# @method purge
# Purges this graph.
# @param self This graph
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < $self->{_numberOfVertices}; ++$i)
    {
	${$self->{_vertex}}[$i] = undef;
    }
    $self->{_numberOfVertices} = 0;
    $self->{_numberOfEdges} = 0;
}

# @method addVertex
# Adds a vertex to this graph with the (optional) weight.
# @param self This graph.
# @param v The number of the vertex.
# @param w The weight of the vertex.
sub addVertex
{
    my ($self, $v, $weight) = @_;
    croak 'ContainerFull'
	if @{$self->{_vertex}} == $self->{_numberOfVertices};
    croak 'ArgumentError' if $v != $self->{_numberOfVertices};
    ${$self->{_vertex}}[$self->{_numberOfVertices}] =
	Opus10::Graph::Vertex->new($self, $v, $weight);
    $self->{_numberOfVertices} += 1;
}

# @method each
# Calls the given visitor function for each vertex in this graph.
# @param self This graph.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    my $vertices = $self->vertices();
    while (defined(my $v = $vertices->()))
    {
	&$visitor($v);
    }
}

# @method vertices
# Returns an interator that enumerates the vertices of this graph.
# @param self This graph.
# @return An iterator
sub vertices
{
    my ($self) = @_;
    my $v = 0; # Iterator state.
    return
	sub
	{
	    my $result = undef;
	    if ($v < $self->{_numberOfVertices})
	    {
		$result = ${$self->{_vertex}}[$v];
		$v += 1;
	    }
	    return $result;
	}
}

# @method toString
# Returns a string representation of this graph.
# @param self This graph.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    my $vertices = $self->vertices();
    while (defined(my $v = $vertices->()))
    {
	my $emanatingEdges = $self->emanatingEdges($v);
	while (defined(my $e = $emanatingEdges->()))
	{
	    $s .= '    ' . $e . "\n";
	}
    }
    return ref($self) . "{\n" . $s . "}";
}

# @function preOrder
# Returns a preorder visitor that is composed with the given visitor function.
# @param visitor A visitor function.
sub preOrder
{
    my ($visitor) = @_;
    return
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == PREVISIT)
	    {
		&$visitor($obj);
	    }
	};
}

# @function postOrder
# Returns a postorder visitor that is composed with the given visitor function.
# @param visitor A visitor function.
sub postOrder
{
    my ($visitor) = @_;
    return
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == POSTVISIT)
	    {
		&$visitor($obj);
	    }
	}
}

# @function test
# Graph test program.
# @param g The graph to test.
sub test
{
    my ($g) = @_;
    printf "Graph test program.\n";
    $g->addVertex(0);
    $g->addVertex(1);
    $g->addVertex(2);
    $g->addEdge(0, 1);
    $g->addEdge(0, 2);
    $g->addEdge(1, 2);
    printf "%s\n", $g;
    printf "isDirected returns %s\n", $g->isDirected();
    printf "Using vertex iterator\n";
    my $vertices = $g->vertices();
    while (defined(my $v = $vertices->()))
    {
	printf "%s\n", $v;
    }
    printf "Using edge iterator\n";
    my $edges = $g->edges();
    while (defined(my $e = $edges->()))
    {
	printf "%s\n", $e;
    }

    printf "DepthFirstTraversal\n";
    $g->depthFirstTraversal(0, preOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "BreadthFirstTraversal\n";
    $g->breadthFirstTraversal(0,
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );

    printf "isConnected returns %s\n", $g->isConnected();
}

use Opus10::Box;

# @function testWeighted
# Weighted graph test program.
# @param g The weighted graph to test.
sub testWeighted
{
    my ($g) = @_;
    printf "Weighted graph test program.\n";
    $g->addVertex(0, box(123));
    $g->addVertex(1, box(234));
    $g->addVertex(2, box(345));
    $g->addEdge(0, 1, box(3));
    $g->addEdge(0, 2, box(1));
    $g->addEdge(1, 2, box(4));
    printf "%s\n", $g;
    printf "Using vertex iterator\n";
    my $vertices = $g->vertices();
    while (defined(my $v = $vertices->()))
    {
	printf "%s\n", $v;
    }
    printf "Using edge iterator\n";
    my $edges = $g->edges();
    while (defined(my $e = $edges->()))
    {
	printf "%s\n", $e;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Graph>

=head2 CLASS C<Opus10::Graph>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all graph classes are derived.

=head3 ATTRIBUTES

=over

=item C<_directed>

True if the graph is directed.

=item C<_numberOfEdges>

The number of edges.

=item C<_numberOfVertices>

The number of vertices.

=item C<_vertex>

The array of vertices.

=back

=head3 METHOD C<addEdge>

Adds an edge to this graph between the given vertices
and with the (optional) weight.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v0>

A vertex number.

=item C<v1>

A vertex number.

=item C<weight>

The weight of the edge. (Optional).

=back

=head3 METHOD C<addVertex>

Adds a vertex to this graph with the (optional) weight.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

The number of the vertex.

=item C<w>

The weight of the vertex.

=back

=head3 METHOD C<breadthFirstTraversal>

Calls the given visitor function for the vertices in this graph
this graph in breadth-first traversal order

=head4 Parameters

=over

=item C<self>

This graph.

=item C<start>

A vertex in this graph.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<depthFirstTraversal>

Calls the given visitor function for the vertices in this graph
in depth-first traversal order
starting from the given vertex.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<start>

A vertex in this graph.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<doDepthFirstTraversal>

Calls the given visitor function for the vertices in this graph
in depth-first traversal order

=head4 Parameters

=over

=item C<self>

This graph.

=item C<start>

A vertex in this graph.

=item C<visitor>

Boolean array used to keep track of the visited vertices.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<each>

Calls the given visitor function for each vertex in this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<edges>

Returns an iterator that enumerates
the edges of this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

An iterator.

=head3 METHOD C<getEdge>

Returns the specified edge of this graph.

=head4 Parameters

=over

=item C<self>

This graph

=item C<v0>

A vertex number.

=item C<v1>

A vertex number.

=back

=head3 METHOD C<getLength>

The maximum number of vertices.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

The maximum number of vertices.

=head3 METHOD C<getVertex>

Returns the specified vertex.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex number.

=back

=head4 Return

A vertex.

=head3 METHOD C<incidentEdges>

Returns an iterator that enumerates
the edges incident upon the given vertex in this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex in this graph.

=item C<self>

This graph.

=item C<v>

A vertex in this graph.

=back

=head4 Return

An iterator.

=head3 METHOD C<initialize>

Initializes this graph with the given maximum number of vertices.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<size>

The maximum number of vertices.

=back

=head3 METHOD C<isConnected>

IsConnected predicate.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

True if this graph is connected.

=head3 METHOD C<isCyclic>

IsCyclic predicate.

=head4 Parameters

=over

=item C<self>

This graph;

=back

=head4 Return

True if this graph is cyclic.

=head3 METHOD C<isDirected>

IsDirected predicate.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

True if this graph is directed.

=head3 METHOD C<isEdge>

Returns true if there is an edge in this graph connecting the given vertices.

=head4 Parameters

=over

=item C<self>

This graph

=item C<v0>

A vertex number.

=item C<v1>

A vertex number.

=back

=head3 FUNCTION C<postOrder>

Returns a postorder visitor that is composed with the given visitor function.

=head4 Parameters

=over

=item C<visitor>

A visitor function.

=back

=head3 FUNCTION C<preOrder>

Returns a preorder visitor that is composed with the given visitor function.

=head4 Parameters

=over

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<purge>

Purges this graph.

=head4 Parameters

=over

=item C<self>

This graph

=back

=head3 FUNCTION C<test>

Graph test program.

=head4 Parameters

=over

=item C<g>

The graph to test.

=back

=head3 FUNCTION C<testWeighted>

Weighted graph test program.

=head4 Parameters

=over

=item C<g>

The weighted graph to test.

=back

=head3 METHOD C<toString>

Returns a string representation of this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

A string.

=head3 METHOD C<vertices>

Returns an interator that enumerates the vertices of this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

An iterator

=head2 CLASS C<Opus10::Graph::Edge>

=head3 Base Classes

=over

=item C<Opus10::Edge>

=back

Represents an edge in a graph.

=head3 ATTRIBUTES

=over

=item C<_graph>

The graph of this edge.

=item C<_v0>

A vertex number.

=item C<_v1>

A vertex number.

=item C<_weight>

The weight on this edge.

=back

=head3 METHOD C<getV0>

Returns vertex v0 of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head4 Return

Vertex v0.

=head3 METHOD C<getV1>

Returns vertex v1 of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head4 Return

Vertex v1.

=head3 METHOD C<hash>

Returns the hash value of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this edge in the given graph
between the given vertices and with the given (optional) weight.

=head4 Parameters

=over

=item C<self>

This edge.

=item C<graph>

The graph of this vertex.

=item C<v0>

The number of vertex v0.

=item C<v1>

The number of vertex v1.

=item C<weight>

The weight on this vertex. (Optional).

=back

=head3 METHOD C<isDirected>

Returns true if this edge is directed.

=head4 Parameters

=over

=item C<self>

This edge

=back

=head4 Return

True if this edge is directed.

=head3 METHOD C<mateOf>

Returns the mate of the given vertex of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=item C<v>

A vertex of this edge.

=back

=head4 Return

The mate of v.

=head3 METHOD C<toString>

Returns a string representation of this edge.

=head4 Parameters

=over

=item C<self>

This edge.

=back

=head4 Return

A string

=head2 CLASS C<Opus10::Graph::Vertex>

=head3 Base Classes

=over

=item C<Opus10::Vertex>

=back

Represents a vertex in a graph.

=head3 ATTRIBUTES

=over

=item C<_graph>

The graph for this vertex.

=item C<_number>

The number of this vertex.

=item C<_weight>

The weight on this vertex.

=back

=head3 METHOD C<emanatingEdges>

Returns an iterator that enumerates
the edges emanating from this vertex.

=head4 Parameters

=over

=item C<self>

This vertex

=back

=head4 Return

An iterator.

=head3 METHOD C<hash>

Returns the hash value of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An integer.

=head3 METHOD C<incidentEdges>

Returns an iterator that enumerates
the edges incident upon this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<initialize>

Initializes this vertex in the given graph
with the given number and (optional) weight.

=head4 Parameters

=over

=item C<self>

This vertex.

=item C<graph>

The graph of this vertex.

=item C<number>

The number of this vertex.

=item C<weight>

The weight on this vertex. (Optional).

=back

=head3 METHOD C<predecessors>

Returns an iterator that enumerates
the predecessors of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<successors>

Returns an iterator that enumerates
the successors of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

An iterator.

=head3 METHOD C<toString>

Returns a string representation of this vertex.

=head4 Parameters

=over

=item C<self>

This vertex.

=back

=head4 Return

A string.

=cut

