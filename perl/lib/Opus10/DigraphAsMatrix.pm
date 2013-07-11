#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: DigraphAsMatrix.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DigraphAsMatrix.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DigraphAsMatrix
# Directed graph implemented using an adjacency matrix.
package Opus10::DigraphAsMatrix;
use Carp;
use Opus10::Declarators;
use Opus10::Digraph;
use Opus10::GraphAsMatrix;
our @ISA = qw(Opus10::GraphAsMatrix Opus10::Digraph);

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
    $self->Opus10::GraphAsMatrix::initialize($size);
    $self->Opus10::Digraph::initialize($size);
    $self->{_directed} = 1;
}

destructor qw(DESTROY);
#}>a

# @method addEdge
# Adds an edge to this digraph connecting the given vertices
# and with the given weight.
# @param self This digraph.
# @param v A vertex number.
# @param w A vertex number.
# @param weight A weight.
sub addEdge
{
    my ($self, $v, $w, $weight) = @_;
    croak 'ArgumentError' if !defined($v) || !defined($w);
    croak 'ArgumentError'
	if defined($self->{_matrix}->getItem($v, $w));
    $self->{_matrix}->setItem($v, $w,
	Opus10::Graph::Edge->new($self, $v, $w, $weight));
    $self->{_numberOfEdges} += 1;
}

# @method edges
# Returns an iterator that enumerates
# the edges of this graph.
# @param self This digraph.
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
	$w  += 1;
	if ($w == $self->{_numberOfVertices})
	{
	    $v += 1;
	    $w = 0;
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
		    $w = 0;
		}
		while ($v < $self->{_numberOfVertices} &&
		    $w < $self->{_numberOfVertices})
		{
		    last if defined($self->{_matrix}->getItem($v, $w));
		    $w  += 1;
		    if ($w == $self->{_numberOfVertices})
		    {
			$v += 1;
			$w = 0;
		    }
		}
	    }
	    return $result;
	};
}

alias_method isCyclic =>
    qw(Opus10::Digraph::isCyclic);

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "DigraphAsMatrix test program.\n";
    my $dg = Opus10::DigraphAsMatrix->new(4);
    Opus10::Digraph::test($dg);
    $dg->purge();
    Opus10::Digraph::testWeighted($dg);
    $dg->purge();
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

=head1 MODULE C<Opus10::DigraphAsMatrix>

=head2 CLASS C<Opus10::DigraphAsMatrix>

=head3 Base Classes

=over

=item C<Opus10::GraphAsMatrix>

=item C<Opus10::Digraph>

=back

Directed graph implemented using an adjacency matrix.

=head3 METHOD C<addEdge>

Adds an edge to this digraph connecting the given vertices
and with the given weight.

=head4 Parameters

=over

=item C<self>

This digraph.

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

This digraph.

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

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=cut

