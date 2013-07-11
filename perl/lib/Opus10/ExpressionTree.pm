#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: ExpressionTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ExpressionTree.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::ExpressionTree
# Represents an expression comprised of binary operators and operands.
package Opus10::ExpressionTree;
use Carp;
use Opus10::Declarators;
use Opus10::BinaryTree;
use Opus10::StackAsLinkedList;
use Opus10::Box;
our @ISA = qw(Opus10::BinaryTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Constructs an expression tree node
# that contains the given word (operand).
# @param self This expression tree.
# @param word A word.
sub initialize
{
    my ($self, $word) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($word);
}

# @function parsePostfix
# Parses the input stream into an expression tree.
# The input is assumed to be a blank-separated postfix expression.
# @param input Input stream.
# @return An expression tree.
sub parsePostfix
{
    my ($INPUT);
    (*INPUT) = @_;
    my $stack = Opus10::StackAsLinkedList->new();
    while (<INPUT>)
    {
	foreach my $word (split)
	{
	    if ($word eq '+' || $word eq '-'
		|| $word eq '*' || $word eq '/')
	    {
		my $result =
		    Opus10::ExpressionTree->new(box($word));
		$result->attachRight($stack->pop());
		$result->attachLeft($stack->pop());
		$stack->push($result);
	    }
	    else
	    {
		$stack->push(
		    Opus10::ExpressionTree->new(box($word)));
	    }
	}
    }
    return $stack->pop();
}
#}>a

destructor qw(DESTROY);

#{
# @method toString
# Returns a string representation of this binary expression tree.
# @param self This expression tree.
sub toString
{
    my ($self) = @_;
    my $s = '';
    $self->depthFirstTraversal(
	sub
	{
	    my ($obj, $mode) = @_;
	    if ($mode == Opus10::Tree::PREVISIT)
	    {
		$s .= '(';
	    }
	    elsif ($mode == Opus10::Tree::INVISIT)
	    {
		$s .= $obj;
	    }
	    elsif ($mode == Opus10::Tree::POSTVISIT)
	    {
		$s .= ')';
	    }
	}
    );
    return $s;
}
#}>b

1;
__DATA__

=head1 MODULE C<Opus10::ExpressionTree>

=head2 CLASS C<Opus10::ExpressionTree>

=head3 Base Classes

=over

=item C<Opus10::BinaryTree>

=back

Represents an expression comprised of binary operators and operands.

=head3 METHOD C<initialize>

Constructs an expression tree node
that contains the given word (operand).

=head4 Parameters

=over

=item C<self>

This expression tree.

=item C<word>

A word.

=back

=head3 FUNCTION C<parsePostfix>

Parses the input stream into an expression tree.
The input is assumed to be a blank-separated postfix expression.

=head4 Parameters

=over

=item C<input>

Input stream.

=back

=head4 Return

An expression tree.

=head3 METHOD C<toString>

Returns a string representation of this binary expression tree.

=head4 Parameters

=over

=item C<self>

This expression tree.

=back

=cut

