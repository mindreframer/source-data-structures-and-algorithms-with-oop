#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: GraphAsLists.pm,v $
#   $Revision: 1.2 $
#
#   $Id: GraphAsLists.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::GraphAsLists
# Graph implemented using adjacency lists.
# @attr _adjacencyList Array of adjacency lists.
package Opus10::GraphAsLists;
use Carp;
use Opus10::Declarators;
use Opus10::Graph;
use Opus10::Array;
use Opus10::LinkedList;
our @ISA = qw(Opus10::Graph);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this graph with the given maximum number of vertices.
# @param self This queue.
# @param size The size of the graph.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($size);
    $self->declare qw(_adjacencyList);
    tie(@{$self->{_adjacencyList}}, 'Opus10::Array', $size);
    for (my $i = 0; $i < $size; ++$i)
    {
	${$self->{_adjacencyList}}[$i] =
	    Opus10::LinkedList->new();
    }
}

destructor qw(DESTROY);
#}>a

# @method purge
# Purges this graph.
# @param self This graph.
sub purge
{
    my ($self) = @_;
    for (my $i = 0; $i < $self->{_numberOfVertices}; ++$i)
    {
	${$self->{_adjacencyList}}[$i]->purge();
    }
    $self->SUPER::purge();
}

# @method addEdge
# Adds an edge to this graph that connects the given vertices
# and with the given weight.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @param weight A weight.
sub addEdge
{
    my ($self, $v, $w, $weight) = @_;
    croak 'ArgumentError' if !defined($v) || !defined($w);
    ${$self->{_adjacencyList}}[$v]->append(
	Opus10::Graph::Edge->new($self, $v, $w, $weight));
#    ${$self->{_adjacencyList}}[$w]->append(
#	Opus10::Graph::Edge->new($self, $w, $v, $weight));
    $self->{_numberOfEdges} += 1;
}

# @method getEdge
# Returns the edge connecting the given vertices in this graph.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @return The edge connecting the given vertices.
sub getEdge
{
    my ($self, $v, $w) = @_;
    croak 'IndexError' if $v < 0 || $v >= $self->{_numberOfVertices};
    croak 'IndexError' if $w < 0 || $w >= $self->{_numberOfVertices};
    my $ptr = ${$self->{_adjacencyList}}[$v]->getHead();
    while (defined($ptr))
    {
	my $edge = $ptr->getDatum();
	if ($edge->getV1()->getNumber() == $w)
	{
	    return $edge;
	}
	$ptr = $ptr->getSucc();
    }
    croak 'ArgumentError';
}

# @method isEdge
# Returns true if there is an the edge
# connecting the given vertices in this graph.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @return True if there is an edge connecting the given vertices.
sub isEdge
{
    my ($self, $v, $w) = @_;
    croak 'IndexError' if $v < 0 || $v >= $self->{_numberOfVertices};
    croak 'IndexError' if $w < 0 || $w >= $self->{_numberOfVertices};
    my $ptr = ${$self->{_adjacencyList}}[$v]->getHead();
    while (defined($ptr))
    {
	my $edge = $ptr->getDatum();
	if ($edge->getV1()->getNumber() == $w)
	{
	    return 1;
	}
	$ptr = $ptr->getSucc();
    }
    return 0;
}

# @method edges
# Returns an interator that enumerates
# the edges of this graph.
# @param self This graph.
# @return An iterator.
sub edges
{
    my ($self) = @_;
    my $v = 0; # Iterator state.
    my $ptr = ${$self->{_adjacencyList}}[$v]->getHead(); # Iterator state.
    while ($v < $self->{_numberOfVertices})
    {
	last if (defined($ptr));
	$v += 1;
	$ptr = ${$self->{_adjacencyList}}[$v]->getHead();
    }
    return
	sub
	{
	    my $result = undef;
	    if ($v < $self->{_numberOfVertices})
	    {
		$result = $ptr->getDatum();
		$ptr = $ptr->getSucc();
		while ($v < $self->{_numberOfVertices})
		{
		    last if (defined($ptr));
		    $v += 1;
		    $ptr = ${$self->{_adjacencyList}}[$v]->getHead();
		}
	    }
	    return $result;
	};
}

# @method emanatingEdges
# Returns an iterator that enumerates
# the edges emanating from the given vertex in this graph.
# @param self This graph.
# @param v A vertex number.
# @return An iterator.
sub emanatingEdges
{
    my ($self, $v) = @_;
    my $ptr = ${$self->{_adjacencyList}}[
	$v->getNumber()]->getHead(); # Iterator stat.
    return
	sub
	{
	    my $result = undef;
	    if (defined($ptr))
	    {
		$result = $ptr->getDatum();
		$ptr = $ptr->getSucc();
	    }
	    return $result;
	};
}

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "GraphAsLists test program.\n";
    my $g = Opus10::GraphAsLists->new(4);
    Opus10::Graph::test($g);
    $g->purge();
    Opus10::Graph::testWeighted($g);
    $g->purge();
    return $status;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::GraphAsLists>

=head2 CLASS C<Opus10::GraphAsLists>

=head3 Base Classes

=over

=item C<Opus10::Graph>

=back

Graph implemented using adjacency lists.

=head3 ATTRIBUTES

=over

=item C<_adjacencyList>

Array of adjacency lists.

=back

=head3 METHOD C<addEdge>

Adds an edge to this graph that connects the given vertices
and with the given weight.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex number.

=item C<w>

A vertex number.

=item C<weight>

A weight.

=back

=head3 METHOD C<edges>

Returns an interator that enumerates
the edges of this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=head4 Return

An iterator.

=head3 METHOD C<emanatingEdges>

Returns an iterator that enumerates
the edges emanating from the given vertex in this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex number.

=back

=head4 Return

An iterator.

=head3 METHOD C<getEdge>

Returns the edge connecting the given vertices in this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex number.

=item C<w>

A vertex number.

=back

=head4 Return

The edge connecting the given vertices.

=head3 METHOD C<initialize>

Initializes this graph with the given maximum number of vertices.

=head4 Parameters

=over

=item C<self>

This queue.

=item C<size>

The size of the graph.

=back

=head3 METHOD C<isEdge>

Returns true if there is an the edge
connecting the given vertices in this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<v>

A vertex number.

=item C<w>

A vertex number.

=back

=head4 Return

True if there is an edge connecting the given vertices.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=back

=cut

