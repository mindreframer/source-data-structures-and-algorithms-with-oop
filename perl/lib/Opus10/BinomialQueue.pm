#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BinomialQueue.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BinomialQueue.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BinomialQueue::BinomialTree
# A binomial tree implemented as as general tree.
package Opus10::BinomialQueue::BinomialTree;
use Carp;
use Opus10::Declarators;
use Opus10::GeneralTree;
our @ISA = qw(Opus10::GeneralTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this binomial tree with the given key.
# @param self This binomial tree.
# @param key An object. Optional.
sub initialize
{
    my ($self, $key) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($key);
}

destructor qw(DESTROY);
#}>h

#{
# @method add
# Adds the given binomial tree to this binomial tree.
# Modifies this binomial tree.
# The trees must have the same degree.
# @param self This binomial tree.
# @param tree A binomial tree.
# @return This binomial tree.
sub add
{
    my ($self, $tree) = @_;
    croak 'ValueError' if $self->{_degree} != $tree->{_degree};
    if ($self->{_key} > $tree->{_key})
    {
	$self->swapContentsWith($tree);
    }
    $self->attachSubtree($tree);
    return $self;
}
#}>i

# @method getCount
# Returns the number of nodes in this binomial tree.
# @param self This binomial tree.
# @return The number of nodes.
sub getCount
{
    my ($self) = @_;
    return 1 << $self->{_degree};
}

# @method swapContentsWith
# Swaps the contents of this binomial tree node
# with the given binomial tree node.
# @param self This binomial tree.
# @param tree A binomial tree node.
sub swapContentsWith
{
    my ($self, $tree) = @_;
    ($self->{_key}, $tree->{_key}) =
	($tree->{_key}, $self->{_key});
    ($self->{_list}, $tree->{_list}) =
	($tree->{_list}, $self->{_list});
    ($self->{_degree}, $tree->{_degree}) =
	($tree->{_degree}, $self->{_degree});
}

#{
# @class Opus10::BinomialQueue
# Mergeable priority queue implemented as a forest of binomial trees.
# @attr _treeList A list of trees.
package Opus10::BinomialQueue;
use Carp;
use Opus10::Declarators;
use Opus10::MergeablePriorityQueue;
use Opus10::LinkedList;
our @ISA = qw(Opus10::MergeablePriorityQueue);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this binomial queue with the given key.
# @param self This binomial queue.
# @param tree A binomial tree.
sub initialize
{
    my ($self, $tree) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($tree);
    $self->declare qw(_treeList);
    $self->{_treeList} = Opus10::LinkedList->new();
    if (defined($tree))
    {
	croak 'DomainError' if !$tree->isa(
	    'Opus10::BinomialQueue::BinomialTree');
	$self->{_treeList}->append($tree);
    }
}

destructor qw(DESTROY);

attr_reader qw(_treeList);
#}>a

#{
# @method addTree
# Adds the given binomial tree to this binomial queue.
# @param self This binomial queue.
# @param tree A binomial tree.
sub addTree
{
    my ($self, $tree) = @_;
    $self->{_treeList}->append($tree);
    $self->{_count} += $tree->getCount();
}

# @method removeTree
# Removes the given binomial tree from this binomial queue.
# @param self This binomial queue.
# @param tree The binomial tree to remove.
sub removeTree
{
    my ($self, $tree) = @_;
    $self->{_treeList}->extract($tree);
    $self->{_count} -= $tree->getCount();
}
#}>b

#{
# @method minTree
# Returns the binomial tree in this binomial queue
# with the smallest value at its root.
# @param self This binomial queue.
# @return The tree with the smallest root.
sub minTree
{
    my ($self) = @_;
    my $minTree = undef;
    my $ptr = $self->{_treeList}->getHead();
    while (defined($ptr))
    {
	my $tree = $ptr->getDatum();
	if (!defined($minTree) ||
	    $tree->getKey() < $minTree->getKey())
	{
	    $minTree = $tree;
	}
	$ptr = $ptr->getSucc();
    }
    return $minTree;
}

# @method getMin
# Returns the smallest object contained in this binomial queue.
# @param self This binomial queue.
# @return The smallest object.
sub getMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    return minTree()->getKey();
}
#}>c

#{
# @method fullAdder
# Returns the sum and carry that result
# from the addition of the given binomial trees.
# @param a A binomial tree.
# @param b A binomial tree.
# @param c A binomial tree.
# @return The sum and carray.
sub fullAdder
{
    my ($a, $b, $c) = @_;
    if (defined($a)) {
	if (defined($b)) {
	    if (defined($c)) {
		return ($a->add($b), $c);
	    }
	    else {
		return (undef, $a->add($b));
	    }
	}
	else {
	    if (defined($c)) {
		return (undef, $a->add($c));
	    }
	    else {
		return ($a, undef);
	    }
	}
    }
    else {
	if (defined($b)) {
	    if (defined($c)) {
		return (undef, $b->add($c));
	    }
	    else {
		return ($b, undef);
	    }
	}
	else {
	    if (defined($c)) {
		return ($c, undef);
	    }
	    else {
		return (undef, undef);
	    }
	}
    }
}
#}>e

#{
# @method merge
# Merges this binomial queue with the given binomial queue.
# @param self This binomial queue.
# @param queue The binomial queue to be merged.
sub merge
{
    my ($self, $queue) = @_;
    my $oldList = $self->{_treeList};
    $self->{_treeList} = Opus10::LinkedList->new();
    $self->{_count} = 0;
    my $p = $oldList->getHead();
    my $q = $queue->{_treeList}->getHead();
    my $sum = undef;
    my $carry = undef;
    my $i = 0;
    while (defined($p) || defined($q) || defined($carry))
    {
	my $a = undef;
	if (defined($p))
	{
	    my $tree = $p->getDatum();
	    if ($tree->getDegree() == $i)
	    {
		$a = $tree;
		$p = $p->getSucc();
	    }
	}
	my $b = undef;
	if (defined($q))
	{
	    my $tree = $q->getDatum();
	    if ($tree->getDegree() == $i)
	    {
		$b = $tree;
		$q = $q->getSucc();
	    }
	}
	($sum, $carry) = fullAdder($a, $b, $carry);
	if (defined($sum)) {
	    $self->addTree($sum);
	}
	$i += 1;
    }
}
#}>d

#{
# @method enqueue
# Enqueues the given object in this binomial queue.
# @param self This binomial queue.
# @param obj The object to enqueue.
sub enqueue
{
    my ($self, $obj) = @_;
    $self->merge(
	Opus10::BinomialQueue->new(
	    Opus10::BinomialQueue::BinomialTree->new($obj)));
}
#}>f

#{
# @method dequeueMin
# Dequeues and returns
# the smallest object in this binomial queue.
# @param self This binomial queue.
# @return The smallest object.
sub dequeueMin
{
    my ($self) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $mt = $self->minTree();
    $self->removeTree($mt);
    my $queue = Opus10::BinomialQueue->new();
    while ($mt->getDegree() > 0)
    {
	my $child = $mt->getSubtree(0);
	$mt->detachSubtree($child);
	$queue->addTree($child);
    }
    $self->merge($queue);
    return $mt->getKey();
}
#}>g

# @method toString
# Returns a string representation of this binomial queue.
# @param self This binomial queue.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    my $ptr = $self->{_treeList}->getHead();
    while (defined($ptr))
    {
	$s .= $ptr->getDatum() . "\n";
	$ptr = $ptr->getSucc();
    }
    return ref($self) . " {\n" . $s . "}";
}

# @method purge
# Purges this binomial queue.
# @param self This binomial queue.
sub purge
{
    my ($self) = @_;
    $self->{_treeList} = Opus10::LinkedList->new();
    $self->{_count} = 0;
}

# @method each
# Calls the given visitor function
# for all the keys in this binomial queue.
# @param self This binomial queue.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    my $ptr = $self->{_treeList}->getHead();
    while (defined($ptr))
    {
	$ptr->getDatum()->each($visitor);
	$ptr = $ptr->getSucc();
    }
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "BinomialQueue test program.\n";
    my $pqueue = Opus10::BinomialQueue->new();
    Opus10::PriorityQueue::test($pqueue);
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

=head1 MODULE C<Opus10::BinomialQueue>

=head2 CLASS C<Opus10::BinomialQueue>

=head3 Base Classes

=over

=item C<Opus10::MergeablePriorityQueue>

=back

Mergeable priority queue implemented as a forest of binomial trees.

=head3 ATTRIBUTES

=over

=item C<_treeList>

A list of trees.

=back

=head3 METHOD C<addTree>

Adds the given binomial tree to this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<tree>

A binomial tree.

=back

=head3 METHOD C<dequeueMin>

Dequeues and returns
the smallest object in this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=back

=head4 Return

The smallest object.

=head3 METHOD C<each>

Calls the given visitor function
for all the keys in this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<enqueue>

Enqueues the given object in this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<obj>

The object to enqueue.

=back

=head3 METHOD C<fullAdder>

Returns the sum and carry that result
from the addition of the given binomial trees.

=head4 Parameters

=over

=item C<a>

A binomial tree.

=item C<b>

A binomial tree.

=item C<c>

A binomial tree.

=back

=head4 Return

The sum and carray.

=head3 METHOD C<getMin>

Returns the smallest object contained in this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=back

=head4 Return

The smallest object.

=head3 METHOD C<initialize>

Initializes this binomial queue with the given key.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<tree>

A binomial tree.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<merge>

Merges this binomial queue with the given binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<queue>

The binomial queue to be merged.

=back

=head3 METHOD C<minTree>

Returns the binomial tree in this binomial queue
with the smallest value at its root.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=back

=head4 Return

The tree with the smallest root.

=head3 METHOD C<purge>

Purges this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=back

=head3 METHOD C<removeTree>

Removes the given binomial tree from this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=item C<tree>

The binomial tree to remove.

=back

=head3 METHOD C<toString>

Returns a string representation of this binomial queue.

=head4 Parameters

=over

=item C<self>

This binomial queue.

=back

=head4 Return

A string.

=head2 CLASS C<Opus10::BinomialQueue::BinomialTree>

=head3 Base Classes

=over

=item C<Opus10::GeneralTree>

=back

A binomial tree implemented as as general tree.

=head3 METHOD C<add>

Adds the given binomial tree to this binomial tree.
Modifies this binomial tree.
The trees must have the same degree.

=head4 Parameters

=over

=item C<self>

This binomial tree.

=item C<tree>

A binomial tree.

=back

=head4 Return

This binomial tree.

=head3 METHOD C<getCount>

Returns the number of nodes in this binomial tree.

=head4 Parameters

=over

=item C<self>

This binomial tree.

=back

=head4 Return

The number of nodes.

=head3 METHOD C<initialize>

Initializes this binomial tree with the given key.

=head4 Parameters

=over

=item C<self>

This binomial tree.

=item C<key>

An object. Optional.

=back

=head3 METHOD C<swapContentsWith>

Swaps the contents of this binomial tree node
with the given binomial tree node.

=head4 Parameters

=over

=item C<self>

This binomial tree.

=item C<tree>

A binomial tree node.

=back

=cut

