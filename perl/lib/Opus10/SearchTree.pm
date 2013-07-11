#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: SearchTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SearchTree.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SearchTree
# Abstract base class from which all search tree classes are derived.
package Opus10::SearchTree;
use Carp;
use Opus10::Declarators;
use Opus10::SearchableContainer;
use Opus10::Tree;
our @ISA = qw(Opus10::SearchableContainer Opus10::Tree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this search tree.
# @param self This search tree.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->Opus10::SearchableContainer::initialize();
    $self->Opus10::Tree::initialize();
}

destructor qw(DESTROY);

# @method getMin
# Returns the smallest key in this tree.
# @param self This search tree.
# @return The smallest key.
abstract_method qw(getMin);

# @method getMax
# Returns the largest key in this tree.
# @param self This search tree.
# @return The largest key.
abstract_method qw(getMax);
#}>a

use Opus10::Box;

# @function test
# SearchTree test program.
# @param tree The search tree to test.
sub test
{
    my ($tree) = @_;
    printf "SearchTree test program.\n";
    printf "%s\n", $tree;
    for (my $i = 1; $i <= 8; ++$i)
    {
	$tree->insert(box($i));
    }
    printf "%s\n", $tree;

    printf "Breadth-first traversal\n";
    $tree->breadthFirstTraversal(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );

    printf "Preorder traversal\n";
    $tree->depthFirstTraversal(Opus10::Tree::preOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "Inorder traversal\n";
    $tree->depthFirstTraversal(Opus10::Tree::inOrder(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    ));

    printf "Postorder traversal\n";
    $tree->depthFirstTraversal(Opus10::Tree::postOrder(
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

    printf "Withdrawing 4\n";
    my $obj = $tree->find(box(4));
    eval
    {
	$tree->withdraw($obj);
	printf "%s\n", $tree;
    };
    if ($@)
    {
	printf "Caught exception: $@\n";
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::SearchTree>

=head2 CLASS C<Opus10::SearchTree>

=head3 Base Classes

=over

=item C<Opus10::SearchableContainer>

=item C<Opus10::Tree>

=back

Abstract base class from which all search tree classes are derived.

=head3 METHOD C<getMax>

Returns the largest key in this tree.

=head4 Parameters

=over

=item C<self>

This search tree.

=back

=head4 Return

The largest key.

=head3 METHOD C<getMin>

Returns the smallest key in this tree.

=head4 Parameters

=over

=item C<self>

This search tree.

=back

=head4 Return

The smallest key.

=head3 METHOD C<initialize>

Initializes this search tree.

=head4 Parameters

=over

=item C<self>

This search tree.

=back

=head3 FUNCTION C<test>

SearchTree test program.

=head4 Parameters

=over

=item C<tree>

The search tree to test.

=back

=cut

