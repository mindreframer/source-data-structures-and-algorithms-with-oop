#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: DigraphAsLists.pm,v $
#   $Revision: 1.2 $
#
#   $Id: DigraphAsLists.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::DigraphAsLists
# Directed graph implemented using adjacency lists.
package Opus10::DigraphAsLists;
use Carp;
use Opus10::Declarators;
use Opus10::Digraph;
use Opus10::GraphAsLists;
our @ISA = qw(Opus10::GraphAsLists Opus10::Digraph);

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
    $self->Opus10::GraphAsLists::initialize($size);
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
    ${$self->{_adjacencyList}}[$v]->append(
	Opus10::Graph::Edge->new($self, $v, $w, $weight));
    $self->{_numberOfEdges} += 1;
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
    printf "DigraphAsLists test program.\n";
    my $dg = Opus10::DigraphAsLists->new(4);
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

=head1 MODULE C<Opus10::DigraphAsLists>

=head2 CLASS C<Opus10::DigraphAsLists>

=head3 Base Classes

=over

=item C<Opus10::GraphAsLists>

=item C<Opus10::Digraph>

=back

Directed graph implemented using adjacency lists.

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

