#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: Algorithms.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Algorithms.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Algorithms::Entry
# Structure used in Dijkstra's and Prim's algorithms.
package Opus10::Algorithms::Entry;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

# @method initialize
# Initializes this entry.
# @param self This entry.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_known _distance _predecessor);
    $self->{_known} = 0;
    $self->{_distance} = 2147483647;
    $self->{_predecessor} = -1;
}

destructor qw(DESTROY);

# Distance known.
attr_accessor qw(_known);
# Distance.
attr_accessor qw(_distance);
# Predecessor node.
attr_accessor qw(_predecessor);
#}>a

# @class Opus10::Algorithms
# Provides a bunch of algorithms.
package Opus10::Algorithms;
use Carp;
use Opus10::Object;
use Opus10::Box;
use Opus10::Array;
use Opus10::DenseMatrix;
use Opus10::Association;
use Opus10::StackAsLinkedList;
use Opus10::QueueAsLinkedList;
use Opus10::ChainedHashTable;
use Opus10::AVLTree;
use Opus10::PartitionAsForest;
use Opus10::BinaryHeap;
use Opus10::GraphAsLists;
use Opus10::DigraphAsMatrix;
use Opus10::DigraphAsLists;
use Opus10::Integer;

#{
# @function breadthFirstTraversal
# Calls the given visitor function
# for the keys in the given tree
# in breadth-first traversal order.
# @param tree A tree.
sub breadthFirstTraversal
{
    my ($tree, $visitor) = @_;
    my $queue = Opus10::QueueAsLinkedList->new();
    if (!$tree->isEmpty())
    {
	$queue->enqueue($tree);
    }
    while (!$queue->isEmpty())
    {
	my $t = $queue->dequeue();
	&$visitor($t->getKey());
	for (my $i = 0; $i < $t->getDegree(); ++$i)
	{
	    my $subTree = $t->getSubtree($i);
	    if (!$subTree->isEmpty())
	    {
		$queue->enqueue($subTree);
	    }
	}
    }
}
#}>b

#{
# @function equivalenceClasses
# Computes equivalence classes using a partition.
# First reads an integer from the input stream that
# specifies the size of the universal set.
# Then reads pairs of integers from the input stream
# that denote equivalent items in the universal set.
# Prints the partition on end-of-file.
# @param INPUT Input stream.
# @param OUTPUT Output stream.
sub equivalenceClasses
{
    my ($INPUT, $OUTPUT);
    (*INPUT, *OUTPUT) = @_;
    return if !defined(my $n = <INPUT>);
    my $p = Opus10::PartitionAsForest->new($n + 0);
    while (1)
    {
	last if !defined(my $i = <INPUT>);
	last if !defined(my $j = <INPUT>);
	my $s = $p->find($i + 0);
	my $t = $p->find($j + 0);
	if ($s->isNot($t))
	{
	    $p->join($s, $t);
	}
	else
	{
	    printf OUTPUT "redundant pair: %d, %d\n", $i, $j;
	}
    }
    printf OUTPUT "%s\n", $p;
}
#}>c

#{
# @function dijkstrasAlgorithm
# Dijkstra's algorithm to solve the single-source,
# shortest path problem
# for the given edge-weighted, directed graph.
# @param g An edge-weighted, directed graph.
# @param s A node in the graph.
sub dijkstrasAlgorithm
{
    my ($g, $s) = @_;
    my $n = $g->getNumberOfVertices();
    tie(my @table, 'Opus10::Array', $n);
    for (my $v = 0; $v < $n; ++$v) {
	$table[$v] = Opus10::Algorithms::Entry->new();
    }
    $table[$s]->setDistance(0);
    my $queue = Opus10::BinaryHeap->new($g->getNumberOfEdges());
    $queue->enqueue(
	Opus10::Association->new(box(0), $g->getVertex($s)));
    while (!$queue->isEmpty()) {
	my $assoc = $queue->dequeueMin();
	my $v0 = $assoc->getValue();
	if (!$table[$v0->getNumber()]->getKnown()) {
	    $table[$v0->getNumber()]->setKnown(1);
	    my $emanatingEdges = $v0->emanatingEdges();
	    while (defined(my $e = $emanatingEdges->())) {
		my $v1 = $e->mateOf($v0);
		my $d = $table[$v0->getNumber()]->getDistance() +
		    unbox($e->getWeight());
		if ($table[$v1->getNumber()]->getDistance() > $d)
		{

		    $table[$v1->getNumber()]->setDistance($d);
		    $table[$v1->getNumber()]->setPredecessor(
			$v0->getNumber());
		    $queue->enqueue(
			Opus10::Association->new(box($d), $v1));
		}
	    }
	}
    }
    my $result = Opus10::DigraphAsLists->new($n);
    for (my $v = 0; $v < $n; ++$v) {
	$result->addVertex($v, $table[$v]->getDistance());
    }
    for (my $v = 0; $v < $n; ++$v) {
	if ($v != $s)
	{
	    $result->addEdge($v, $table[$v]->getPredecessor());
	}
    }
    return $result;
}
#}>d

use constant MAXINT => Opus10::Integer::MAXINT;

#{
# @function floydsAlgorithm
# Floyd's algorithm to solve the all-pairs,
# shortest path problem
# for the given edge-weighted, directed graph.
# @param g An edge-weighted, directed graph.
sub floydsAlgorithm
{
    my ($g) = @_;
    my $n = $g->getNumberOfVertices();
    my $distance = Opus10::DenseMatrix->new($n, $n);
    for (my $v = 0; $v < $n; ++$v) {
	for (my $w = 0; $w < $n; ++$w) {
	    $distance->setItem($v, $w, MAXINT);
	}
    }
    my $edges = $g->edges();
    while (defined(my $e = $edges->())) {
	$distance->setItem($e->getV0()->getNumber(),
	    $e->getV1()->getNumber(), unbox($e->getWeight()));
    }
    for (my $i = 0; $i < $n; ++$i) {
	for (my $v = 0; $v < $n; ++$v) {
	    for (my $w = 0; $w < $n; ++$w) {
		if ($distance->getItem($v, $i) != MAXINT && 
		    $distance->getItem($i, $w) != MAXINT) {
		    my $d = $distance->getItem($v, $i) +
			$distance->getItem($i, $w);
		    if ($distance->getItem($v, $w) > $d) {
			$distance->setItem($v, $w, $d);
		    }
		}
	    }
	}
    }
    my $result = Opus10::DigraphAsMatrix->new($n);
    for (my $v = 0; $v < $n; ++$v) {
	$result->addVertex($v);
    }
    for (my $v = 0; $v < $n; ++$v) {
	for (my $w = 0; $w < $n; ++$w) {
	    if ($distance->getItem($v, $w) != MAXINT) {
		$result->addEdge(
		    $v, $w, $distance->getItem($v, $w));
	    }
	}
    }
    return $result;
}
#}>e

#{
# @function primsAlgorithm
# Prim's algorithm to find a minimum-cost spanning tree
# for the given edge-weighted, undirected graph.
# @param g An edge-weighted, undirected graph.
# @param s A node in the graph.
sub primsAlgorithm
{
    my ($g, $s) = @_;
    my $n = $g->getNumberOfVertices();
    tie(my @table, 'Opus10::Array', $n);
    for (my $v = 0; $v < $n; ++$v) {
	$table[$v] = Opus10::Algorithms::Entry->new();
    }
    $table[$s]->setDistance(0);
    my $queue = Opus10::BinaryHeap->new($g->getNumberOfEdges());
    $queue->enqueue(
	Opus10::Association->new(box(0), $g->getVertex($s)));
    while (!$queue->isEmpty()) {
	my $assoc = $queue->dequeueMin();
	my $v0 = $assoc->getValue();
	if (!$table[$v0->getNumber()]->getKnown()) {
	    $table[$v0->getNumber()]->setKnown(1);
	    my $emanatingEdges = $v0->emanatingEdges();
	    while (defined(my $e = $emanatingEdges->())) {
		my $v1 = $e->mateOf($v0);
		my $d = unbox($e->getWeight());
		if (!$table[$v1->getNumber()]->getKnown() &&
		    $table[$v1->getNumber()]->getDistance() > $d)
		{
		    $table[$v1->getNumber()]->setDistance($d);
		    $table[$v1->getNumber()]->setPredecessor(
			$v0->getNumber());
		    $queue->enqueue(
			Opus10::Association->new(box($d), $v1))
		}
	    }
	}
    }
    my $result = Opus10::GraphAsLists->new($n);
    for (my $v = 0; $v < $n; ++$v) {
	$result->addVertex($v);
    }
    for (my $v = 0; $v < $n; ++$v) {
	if ($v != $s) {
	    $result->addEdge($v, $table[$v]->getPredecessor());
	}
    }
    return $result;
}
#}>f

#{
# @function kruskalsAlgorithm
# Kruskal's algorithm to find a minimum-cost spanning tree
# for the given edge-weighted, undirected graph.
# @param g An edge-weighted, undirected graph.
sub kruskalsAlgorithm
{
    my ($g) = @_;
    my $n = $g->getNumberOfVertices();
    my $result = Opus10::GraphAsLists->new($n);
    for (my $v = 0; $v < $n; ++$v)
    {
	$result->addVertex($v);
    }
    my $queue = Opus10::BinaryHeap->new($g->getNumberOfEdges());
    my $edges = $g->edges();
    while (defined(my $e = $edges->()))
    {
	$queue->enqueue(
	    Opus10::Association->new($e->getWeight(), $e));
    }
    my $partition = Opus10::PartitionAsForest->new($n);
    while (!$queue->isEmpty() && $partition->getCount() > 1)
    {
	my $e = $queue->dequeueMin()->getValue();
	my $n0 = $e->getV0()->getNumber();
	my $n1 = $e->getV1()->getNumber();
	my $s = $partition->find($n0);
	my $t = $partition->find($n1);
	if ($s->isNot($t))
	{
	    $partition->join($s, $t);
	    $result->addEdge($n0, $n1);
	}
    }
    $partition->purge();
    return $result;
}
#}>g

# @function max
# Returns the larger of the given two values.
# @param x A value.
# @param y A value.
# @return The larger value.
sub max
{
    my ($x, $y) = @_;
    return $x > $y ? $x : $y;
}

# @function min
# Returns the smaller of the given two values.
# @param x A value.
# @param y A value.
# @return The smaller value.
sub min
{
    my ($x, $y) = @_;
    return $x < $y ? $x : $y;
}

#{
# @function criticalPathAnalysis
# Computes the critical path in an event-node graph.
# @param g An event-node graph.
sub criticalPathAnalysis {
    my ($g) = @_;
    my $n = $g->getNumberOfVertices();
    tie(my @earliestTime, 'Opus10::Array', $n);
    $earliestTime[0] = 0;
    $g->topologicalOrderTraversal(
	sub { my ($w) = @_;
	    my $t = 0;
	    my $incidentEdges = $w->incidentEdges();
	    while (defined(my $e = $incidentEdges->())) {
		$t = max($t,
		    $earliestTime[$e->getV0()->getNumber()] +
		    unbox($e->getWeight()));
	    }
	    $earliestTime[$w->getNumber()] = $t;
	});
    tie(my @latestTime, 'Opus10::Array', $n);
    $latestTime[$n - 1] = $earliestTime[$n - 1];
    $g->depthFirstTraversal(0,
	sub { my ($v, $mode) = @_;
	    if ($mode == Opus10::Graph::POSTVISIT) {
		my $t = MAXINT;
		my $emanatingEdges = $v->emanatingEdges();
		while (defined(my $e = $emanatingEdges->())) {
		    $t = min($t,
			$latestTime[$e->getV1()->getNumber()] -
			unbox($e->getWeight()));
		}
		$latestTime[$v->getNumber()] = $t;
	    }
	});
    my $slackGraph = Opus10::DigraphAsLists->new($n);
    for (my $v = 0; $v < $n; ++$v)
	{ $slackGraph->addVertex($v); }
    my $edges = $g->edges();
    while (defined(my $e = $edges->())) {
	my $slack = $latestTime[$e->getV1()->getNumber()] -
	    $earliestTime[$e->getV0()->getNumber()] -
	    unbox($e->getWeight());
	$slackGraph->addEdge($e->getV0()->getNumber(),
	    $e->getV1()->getNumber(), $e->getWeight());
    }
    my $result = Opus10::Algorithms::dijkstrasAlgorithm(
	$slackGraph, 0);
    $slackGraph->purge();
    return $result;
}
#}>h

#{
# @function calculator
# A very simple reverse-Polish calculator.
# @param INPUT Input stream.
# @param OUTPUT Output stream.
sub calculator
{
    my ($INPUT, $OUTPUT);
    (*INPUT, *OUTPUT) = @_;
    my $stack = Opus10::StackAsLinkedList->new();
    while (<INPUT>)
    {
	foreach my $word (split)
	{
	    if ($word eq '+')
	    {
		my $arg2 = $stack->pop();
		my $arg1 = $stack->pop();
		$stack->push($arg1 + $arg2);
	    }
	    elsif ($word eq '*')
	    {
		my $arg2 = $stack->pop();
		my $arg1 = $stack->pop();
		$stack->push ($arg1 * $arg2);
	    }
	    elsif ($word eq '=')
	    {
		my $arg = $stack->pop();
		printf OUTPUT "%s\n", $arg;
	    }
	    else
	    {
		$stack->push(box(0 + $word));
	    }
	}
    }
}
#}>i

#{
# @function wordCounter
# Counts the number of occurrences of each word
# in the given file.
# @param INPUT Input stream.
# @param OUTPUT Output stream.
sub wordCounter
{
    my ($INPUT, $OUTPUT);
    (*INPUT, *OUTPUT) = @_;
    my $table = Opus10::ChainedHashTable->new(1031);
    while (<INPUT>)
    {
	foreach my $word (split)
	{
	    my $assoc = $table->find(
		Opus10::Association->new(box($word)));
	    if (defined($assoc))
	    {
		$assoc->setValue($assoc->getValue() + 1);
	    }
	    else
	    {
		$table->insert(
		    Opus10::Association->new(box($word), 1))
	    }
	}
    }
    printf OUTPUT "%s\n", $table;
}
#}>j

#{
# @function translate
# Reads all the word pairs from the dictionary file
# and then reads words from the input file,
# translates the words (if possible),
# and writes them to the output file.
# @param DICTIONARY Dictionary file.
# @param INPUT Input stream.
# @param OUTPUT Output stream.
sub translate
{
    my ($DICTIONARY, $INPUT, $OUTPUT);
    (*DICTIONARY, *INPUT, *OUTPUT) = @_;
    my $searchTree = Opus10::AVLTree->new();
    while (<DICTIONARY>)
    {
	my @words = split;
	croak 'SyntaxError' if @words != 2;
	$searchTree->insert(Opus10::Association->new(
	    box($words[0]), box($words[1])));
    }
    while (<INPUT>)
    {
	foreach my $word (split)
	{
	    my $assoc = $searchTree->find(
		Opus10::Association->new(box($word)));
	    if (defined($assoc))
	    {
		printf OUTPUT "%s ", $assoc->getValue();
	    }
	    else
	    {
		printf OUTPUT "%s ", $word;
	    }
	}
	printf OUTPUT "\n";
    }
}
#}>k

1;
__DATA__

=head1 MODULE C<Opus10::Algorithms>

=head2 CLASS C<Opus10::Algorithms>

Provides a bunch of algorithms.

=head3 FUNCTION C<breadthFirstTraversal>

Calls the given visitor function
for the keys in the given tree
in breadth-first traversal order.

=head4 Parameters

=over

=item C<tree>

A tree.

=back

=head3 FUNCTION C<calculator>

A very simple reverse-Polish calculator.

=head4 Parameters

=over

=item C<INPUT>

Input stream.

=item C<OUTPUT>

Output stream.

=back

=head3 FUNCTION C<criticalPathAnalysis>

Computes the critical path in an event-node graph.

=head4 Parameters

=over

=item C<g>

An event-node graph.

=back

=head3 FUNCTION C<dijkstrasAlgorithm>

Dijkstra's algorithm to solve the single-source,
shortest path problem
for the given edge-weighted, directed graph.

=head4 Parameters

=over

=item C<g>

An edge-weighted, directed graph.

=item C<s>

A node in the graph.

=back

=head3 FUNCTION C<equivalenceClasses>

Computes equivalence classes using a partition.
First reads an integer from the input stream that
specifies the size of the universal set.
Then reads pairs of integers from the input stream
that denote equivalent items in the universal set.
Prints the partition on end-of-file.

=head4 Parameters

=over

=item C<INPUT>

Input stream.

=item C<OUTPUT>

Output stream.

=back

=head3 FUNCTION C<floydsAlgorithm>

Floyd's algorithm to solve the all-pairs,
shortest path problem
for the given edge-weighted, directed graph.

=head4 Parameters

=over

=item C<g>

An edge-weighted, directed graph.

=back

=head3 FUNCTION C<kruskalsAlgorithm>

Kruskal's algorithm to find a minimum-cost spanning tree
for the given edge-weighted, undirected graph.

=head4 Parameters

=over

=item C<g>

An edge-weighted, undirected graph.

=back

=head3 FUNCTION C<max>

Returns the larger of the given two values.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=back

=head4 Return

The larger value.

=head3 FUNCTION C<min>

Returns the smaller of the given two values.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=back

=head4 Return

The smaller value.

=head3 FUNCTION C<primsAlgorithm>

Prim's algorithm to find a minimum-cost spanning tree
for the given edge-weighted, undirected graph.

=head4 Parameters

=over

=item C<g>

An edge-weighted, undirected graph.

=item C<s>

A node in the graph.

=back

=head3 FUNCTION C<translate>

Reads all the word pairs from the dictionary file
and then reads words from the input file,
translates the words (if possible),
and writes them to the output file.

=head4 Parameters

=over

=item C<DICTIONARY>

Dictionary file.

=item C<INPUT>

Input stream.

=item C<OUTPUT>

Output stream.

=back

=head3 FUNCTION C<wordCounter>

Counts the number of occurrences of each word
in the given file.

=head4 Parameters

=over

=item C<INPUT>

Input stream.

=item C<OUTPUT>

Output stream.

=back

=head2 CLASS C<Opus10::Algorithms::Entry>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Structure used in Dijkstra's and Prim's algorithms.

=head3 METHOD C<initialize>

Initializes this entry.

=head4 Parameters

=over

=item C<self>

This entry.

=back

=cut

