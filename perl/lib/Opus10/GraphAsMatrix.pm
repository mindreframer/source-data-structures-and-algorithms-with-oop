#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: GraphAsMatrix.pm,v $
#   $Revision: 1.2 $
#
#   $Id: GraphAsMatrix.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::GraphAsMatrix
# Graph implemented using an adjacency matrix.
# @attr _matrix The adjacency matrix.
package Opus10::GraphAsMatrix;
use Carp;
use Opus10::Declarators;
use Opus10::Graph;
use Opus10::DenseMatrix;
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
    $self->declare qw(_matrix);
    $self->{_matrix} = Opus10::DenseMatrix->new($size, $size);
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
	for (my $j = 0; $j < $self->{_numberOfVertices}; ++$j)
	{
	    $self->{_matrix}->setItem($i, $j, undef);
	}
    }
    $self->SUPER::purge();
}

# @method addEdge
# Adds an edge to this graph connecting the given vertices
# and with the given weight.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @param weight A weight.
sub addEdge
{
    my ($self, $v, $w, $weight) = @_;
    croak 'ArgumentError' if (!defined($v) or !defined($w));
    croak 'ArgumentError' if defined($self->{_matrix}->getItem($v, $w));
    my $edge = Opus10::Graph::Edge->new($self, $v, $w, $weight);
    $self->{_matrix}->setItem($v, $w, $edge);
    $self->{_matrix}->setItem($w, $v, $edge);
    $self->{_numberOfEdges} += 1;
}

# @method getEdge
# Returns the edge connecting the given vertices.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @return The edge connecting the given vertices.
sub getEdge
{
    my ($self, $v, $w) = @_;
    my $result = $self->{_matrix}->getItem($v, $w);
    croak 'ArgumentError' if !defined($result);
    return $result;
}

# @method isEdge
# Returns true if there is an edge connecting the given vertices.
# @param self This graph.
# @param v A vertex number.
# @param w A vertex number.
# @return True if there is an edge connecting the given vertices.
sub isEdge
{
    my ($self, $v, $w) = @_;
    return defined($self->{_matrix}->getItem($v, $w));
}

# @method edges
# Returns an iterator that enumerates
# the edges of this graph.
# @param self This graph.
# @return An iterator.
sub edges
{
    my ($self) = @_;
    my $v = 0; # Iterator state.
    my $w = 0; # Iterator state.
    while ($v < $self->{_numberOfVertices} &&
	$w < $self->{_numberOfVertices})
    {
	last if defined($self->{_matrix}->getItem($v, $w));
	$w += 1;
	if ($w == $self->{_numberOfVertices})
	{
	    $v += 1;
	    $w = $v;
	}
    }
    return
	sub
	{
	    my $result = undef;
	    if ($v < $self->{_numberOfVertices} &&
		$w < $self->{_numberOfVertices})
	    {
		$result = $self->{_matrix}->getItem($v, $w);
		$w += 1;
		if ($w == $self->{_numberOfVertices})
		{
		    $v += 1;
		    $w = $v;
		}
		while ($v < $self->{_numberOfVertices} &&
		    $w < $self->{_numberOfVertices})
		{
		    last if defined($self->{_matrix}->getItem($v, $w));
		    $w += 1;
		    if ($w == $self->{_numberOfVertices})
		    {
			$v += 1;
			$w = $v;
		    }
		}
	    }
	    return $result;
	};
}

# @method emanatingEdges
# Returns an iterator that enumerates
# the edges emanating from the given vertex of this graph.
# @param self This graph.
# @param v A vertex number.
# @return An iterator.
sub emanatingEdges
{
    my ($self, $v) = @_;
    $v = $v->getNumber();
    my $w = $v; # Iterator state.
    while ($w < $self->{_numberOfVertices})
    {
	last if defined($self->{_matrix}->getItem($v, $w));
	$w += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($w < $self->{_numberOfVertices})
	    {
		$result = $self->{_matrix}->getItem($v, $w);
		$w += 1;
		while ($w < $self->{_numberOfVertices})
		{
		    last if defined($self->{_matrix}->getItem($v, $w));
		    $w += 1;
		}
	    }
	    return $result;
	};
}

# @method incidentEdges
# Returns an interator that enumerates
# the edges incident upon the given vertex of this graph.
# @param self This graph.
# @param w A vertex number.
# @return An iterator.
sub incidentEdges
{
    my ($self, $w) = @_;
    $w = $w->getNumber();
    my $v = 0; # Iterator state.
    while ($v <= $w)
    {
	last if defined($self->{_matrix}->getItem($v, $w));
	$v += 1;
    }
    return
	sub
	{
	    my $result = undef;
	    if ($v <= $w)
	    {
		$result = $self->{_matrix}->getItem($v, $w);
		$v += 1;
		while ($v <= $w)
		{
		    last if defined($self->{_matrix}->getItem($v, $w));
		    $v += 1;
		}
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
    printf "GraphAsMatrix test program.\n";
    my $g = Opus10::GraphAsMatrix->new(4);
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

=head1 MODULE C<Opus10::GraphAsMatrix>

=head2 CLASS C<Opus10::GraphAsMatrix>

=head3 Base Classes

=over

=item C<Opus10::Graph>

=back

Graph implemented using an adjacency matrix.

=head3 ATTRIBUTES

=over

=item C<_matrix>

The adjacency matrix.

=back

=head3 METHOD C<addEdge>

Adds an edge to this graph connecting the given vertices
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

Returns an iterator that enumerates
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
the edges emanating from the given vertex of this graph.

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

Returns the edge connecting the given vertices.

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

=head3 METHOD C<incidentEdges>

Returns an interator that enumerates
the edges incident upon the given vertex of this graph.

=head4 Parameters

=over

=item C<self>

This graph.

=item C<w>

A vertex number.

=back

=head4 Return

An iterator.

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

Returns true if there is an edge connecting the given vertices.

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

