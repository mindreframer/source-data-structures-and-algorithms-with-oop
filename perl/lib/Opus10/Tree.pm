#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: Tree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Tree.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Tree
# Abstract base class from which all tree classes are derived.
package Opus10::Tree;
use Opus10::Declarators;
use Opus10::SearchableContainer;
our @ISA = qw(Opus10::SearchableContainer);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this tree.
# @param self This tree.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method getKey
# Returns the key in this tree node.
# @param self This tree node.
# @return The key in this tree node.
abstract_method qw(getKey);

# @method getSubtree
# Returns the specified subtree of this tree node.
# @param self This tree node.
# @return The specified subtree of this tree node.
abstract_method qw(getSubtree);

# @method isEmpty
# IsEmpty predicate.
# @param self This tree node.
# @return True if this tree node is empty.
abstract_method qw(is_empty);

# @method isLeaf
# IsLeaf predicate.
# @param self This tree node.
# @return True if this tree node is a leaf node.
abstract_method qw(is_leaf);

# @method getDegree
# Returns the degree of this node.
# @param self This tree node.
# @return The degree of this tree node.
abstract_method qw(getDegree);

# @method getHeight
# Returns the height of this tree.
# @param self This tree node.
# @return The height of this tree node.
abstract_method qw(get_height);
#}>a

#{
# Pre-visit mode.
use constant PREVISIT => -1;
# In-visit mode.
use constant INVISIT => 0;
# Post-visit mode.
use constant POSTVISIT => 1;

# @method depthFirstTraversal
# Calls the given visitor function for each key in this tree
# in depth-first traversal order.
# @param self This tree node.
# @param visitor A visitor function.
sub depthFirstTraversal
{
    my ($self, $visitor) = @_;
    if (!$self->isEmpty())
    {
	&$visitor($self->getKey(), PREVISIT);
	for (my $i = 0; $i < $self->getDegree(); ++$i)
	{
	    $self->getSubtree($i)->depthFirstTraversal($visitor);
	}
	&$visitor($self->getKey(), POSTVISIT);
    }
}
#}>b

#{
use Opus10::QueueAsLinkedList;

# @method breadthFirstTraversal
# Calls the given visitor function for each key in this tree
# in breadth-first traversal order.
# @param self This tree node.
# @param visitor A visitor function.
sub breadthFirstTraversal
{
    my ($self, $visitor) = @_;
    my $queue = Opus10::QueueAsLinkedList->new();
    if (!$self->isEmpty())
    {
	$queue->enqueue($self);
    }
    while (!$queue->isEmpty())
    {
	my $head = $queue->dequeue();
	&$visitor($head->getKey());
	for (my $i = 0; $i < $head->getDegree(); ++$i)
	{
	    my $child = $head->getSubtree($i);
	    if (!$child->isEmpty())
	    {
		$queue->enqueue($child);
	    }
	}
    }
}
#}>c

#{
# @method each
# Calls the given visitor function for each key in this tree
# in depth-first traversal order.
# @param self This tree node.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    $self->depthFirstTraversal(
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == PREVISIT)
	    {
		&$visitor($obj);
	    }
	}
    );
}
#}>d

#{
use Opus10::StackAsLinkedList;

# @method iter
# Returns an iterator that enumerates the key contained in a tree.
# @param self This tree node.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my $stack = Opus10::StackAsLinkedList->new();
    if (!$self->isEmpty())
    {
	$stack->push($self);
    }
    return
	sub
	{
	    my $result = undef;
	    if (!$stack->isEmpty())
	    {
		my $top = $stack->pop();
		$result = $top->getKey();
		my $i = $top->getDegree() - 1;
		while ($i >= 0)
		{
		    my $subtree = $top->getSubtree($i);
		    if (!$subtree->isEmpty())
		    {
			$stack->push($subtree);
		    }
		    $i -= 1;
		}
	    }
	    return $result;
	}
}
#}>e

# @function max
# Returns the larger of the two given values.
# @param x A value.
# @param y A value.
# @return The larger value.
sub max
{
    my ($x, $y) = @_;
    return ($x > $y) ? $x : $y;
}

# @method getHeight
# Returns the height of this tree.
# @param self This tree node.
# @return The height of this tree.
sub getHeight
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return -1;
    }
    my $height = -1;
    for (my $i = 0; $i < self->getDegree(); ++$i)
    {
	$height = max($height, $self->getSubtree($i)->getHeight());
    }
    return $height + 1;
}

# @method getCount
# Returns the number of keys contained in this tree.
# @param self This tree node.
# @return The number of keys in this tree.
sub getCount
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    my $result = 1;
    for (my $i = 0; $i < $self->getDegree(); ++$i)
    {
	$result = $result + $self->getSubtree($i)->getCount();
    }
    return $result;
}

# @function preOrder
# Returns a preorder visitor that is composed with the given visitor function.
# @param visitor A visitor function.
# @return A preorder visitor.
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

# @function inOrder
# Returns an inorder visitor that is composed with the given visitor function.
# @param visitor A visitor function.
# @return An inorder visitor.
sub inOrder
{
    my ($visitor) = @_;
    return
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == INVISIT)
	    {
		&$visitor($obj);
	    }
	};
}

# @function postOrder
# Returns a postorder visitor that is composed with the given visitor function.
# @param visitor A visitor function.
# @return A postorder visitor.
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
	};
}

# @function test
# Tree test program.
# @param tree The tree to test.
sub test
{
    my ($tree) = @_;
    printf "Tree test program.\n";

    printf "Breadth-First traversal\n";
    $tree->breadthFirstTraversal(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );

    printf "Preorder traversal\n";
    $tree->depthFirstTraversal(preOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "Inorder traversal\n";
    $tree->depthFirstTraversal(inOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "Postorder traversal\n";
    $tree->depthFirstTraversal(postOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "Using each\n";
    $tree->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );

    printf "Using Iterator\n";
    my $iter = $tree->iter();
    while (defined(my $obj = $iter->()))
    {
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Tree>

=head2 CLASS C<Opus10::Tree>

=head3 Base Classes

=over

=item C<Opus10::SearchableContainer>

=back

Abstract base class from which all tree classes are derived.

=head3 METHOD C<breadthFirstTraversal>

Calls the given visitor function for each key in this tree
in breadth-first traversal order.

=head4 Parameters

=over

=item C<self>

This tree node.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<depthFirstTraversal>

Calls the given visitor function for each key in this tree
in depth-first traversal order.

=head4 Parameters

=over

=item C<self>

This tree node.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<each>

Calls the given visitor function for each key in this tree
in depth-first traversal order.

=head4 Parameters

=over

=item C<self>

This tree node.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<getCount>

Returns the number of keys contained in this tree.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

The number of keys in this tree.

=head3 METHOD C<getDegree>

Returns the degree of this node.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

The degree of this tree node.

=head3 METHOD C<getHeight>

Returns the height of this tree.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

The height of this tree.

=head3 METHOD C<getKey>

Returns the key in this tree node.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

The key in this tree node.

=head3 METHOD C<getSubtree>

Returns the specified subtree of this tree node.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

The specified subtree of this tree node.

=head3 FUNCTION C<inOrder>

Returns an inorder visitor that is composed with the given visitor function.

=head4 Parameters

=over

=item C<visitor>

A visitor function.

=back

=head4 Return

An inorder visitor.

=head3 METHOD C<initialize>

Initializes this tree.

=head4 Parameters

=over

=item C<self>

This tree.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

True if this tree node is empty.

=head3 METHOD C<isLeaf>

IsLeaf predicate.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

True if this tree node is a leaf node.

=head3 METHOD C<iter>

Returns an iterator that enumerates the key contained in a tree.

=head4 Parameters

=over

=item C<self>

This tree node.

=back

=head4 Return

An iterator.

=head3 FUNCTION C<max>

Returns the larger of the two given values.

=head4 Parameters

=over

=item C<x>

A value.

=item C<y>

A value.

=back

=head4 Return

The larger value.

=head3 FUNCTION C<postOrder>

Returns a postorder visitor that is composed with the given visitor function.

=head4 Parameters

=over

=item C<visitor>

A visitor function.

=back

=head4 Return

A postorder visitor.

=head3 FUNCTION C<preOrder>

Returns a preorder visitor that is composed with the given visitor function.

=head4 Parameters

=over

=item C<visitor>

A visitor function.

=back

=head4 Return

A preorder visitor.

=head3 FUNCTION C<test>

Tree test program.

=head4 Parameters

=over

=item C<tree>

The tree to test.

=back

=cut

