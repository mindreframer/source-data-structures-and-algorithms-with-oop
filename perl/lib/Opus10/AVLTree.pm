#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:38 $
#   $RCSfile: AVLTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: AVLTree.pm,v 1.2 2005/09/25 23:52:38 brpreiss Exp $
#

use strict;

#{
# @class Opus10::AVLTree
# An Adelson-Velskii and Landis binary search tree.
# @attr _height The height of this tree node.
package Opus10::AVLTree;
use Carp;
use Opus10::Declarators;
use Opus10::BinarySearchTree;
our @ISA = qw(Opus10::BinarySearchTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes an empty AVL tree node.
# @param self This general tree.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_height);
    $self->{_height} = -1;
}

destructor qw(DESTROY);

attr_reader qw(_height);
#}>a

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

#{
# @method adjustHeight
# Adjusts the height of this tree node.
# @param self This AVL tree node.
sub adjustHeight
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	$self->{_height} = -1;
    }
    else
    {
	$self->{_height} =
	    max($self->{_left}->{_height},
		$self->{_right}->{_height}) + 1;
    }
}

# @method getBalanceFactor
# Returns the balance factor of this tree node.
# @param self This AVL tree node.
# @return The balance factor.
sub getBalanceFactor
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    else
    {
	return $self->{_left}->{_height} -
	    $self->{_right}->{_height};
    }
}
#}>b

#{
# @method doLLRotation
# Does an LL rotation at this AVL tree node.
# @param self This AVL tree node.
sub doLLRotation
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();

    my $tmp = $self->{_right};
    $self->{_right} = $self->{_left};
    $self->{_left} = $self->{_right}->{_left};
    $self->{_right}->{_left} = $self->{_right}->{_right};
    $self->{_right}->{_right} = $tmp;

    $tmp = $self->{_key};
    $self->{_key} = $self->{_right}->{_key};
    $self->{_right}->{_key} = $tmp;

    $self->{_right}->adjustHeight();
    $self->adjustHeight();
}
#}>c
#++

#{
# @method doLRRotation
# Does an LR rotation at this AVL tree node.
# @param self This AVL tree node.
sub doLRRotation
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    $self->{_left}->doRRRotation();
    $self->doLLRotation();
}
#}>d

#{
# @method balance
# Balances this AVL tree.
# @param self This AVL tree node.
sub balance
{
    my ($self) = @_;
    $self->adjustHeight();
    if ($self->getBalanceFactor() > 1)
    {
	if ($self->{_left}->getBalanceFactor() > 0)
	{
	    $self->doLLRotation();
	}
	else
	{
	    $self->doLRRotation();
	}
    }
    elsif ($self->getBalanceFactor() < -1)
    {
	if ($self->{_right}->getBalanceFactor() < 0)
	{
	    $self->doRRRotation();
	}
	else
	{
	    $self->doRLRotation();
	}
    }
}
#}>e

#{
# @method attachKey
# Attaches the given key to this AVL tree node.
# @param self This AVL tree node.
# @param obj The key to attached.
sub attachKey
{
    my ($self, $obj) = @_;
    croak 'StateError' if !$self->isEmpty();
    $self->{_key} = $obj;
    $self->{_left} = Opus10::AVLTree->new();
    $self->{_right} = Opus10::AVLTree->new();
    $self->{_height} = 0;
}
#}>f

#{
# @method detachKey
# Detaches the key from this AVL tree node.
# @param self This AVL tree node.
sub detachKey
{
    my ($self) = @_;
    $self->SUPER::detachKey();
    $self->{_height} = -1;
}
#}>g

# @method doRRRotation
# Does an RR rotation at this AVL tree node.
# @param self This AVL tree node.
sub doRRRotation
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();

    my $tmp = $self->{_left};
    $self->{_left} = $self->{_right};
    $self->{_right} = $self->{_left}->{_right};
    $self->{_left}->{_right} = $self->{_left}->{_left};
    $self->{_left}->{_left} = $tmp;

    $tmp = $self->{_key};
    $self->{_key} = $self->{_left}->{_key};
    $self->{_left}->{_key} = $tmp;

    $self->{_left}->adjustHeight();
    $self->adjustHeight();
}

# @method doRLRotation
# Does an RL rotation at this AVL tree node.
# @param self This AVL tree node.
sub doRLRotation
{
    my ($self) = @_;
    croak 'StateError' if $self->isEmpty();
    $self->{_right}->doLLRotation();
    $self->doRRRotation();
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "AVLTree test program.\n";
    my $tree = Opus10::AVLTree->new();
    Opus10::SearchTree::test($tree);
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

=head1 MODULE C<Opus10::AVLTree>

=head2 CLASS C<Opus10::AVLTree>

=head3 Base Classes

=over

=item C<Opus10::BinarySearchTree>

=back

An Adelson-Velskii and Landis binary search tree.

=head3 ATTRIBUTES

=over

=item C<_height>

The height of this tree node.

=back

=head3 METHOD C<adjustHeight>

Adjusts the height of this tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<attachKey>

Attaches the given key to this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=item C<obj>

The key to attached.

=back

=head3 METHOD C<balance>

Balances this AVL tree.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<detachKey>

Detaches the key from this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<doLLRotation>

Does an LL rotation at this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<doLRRotation>

Does an LR rotation at this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<doRLRotation>

Does an RL rotation at this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<doRRRotation>

Does an RR rotation at this AVL tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head3 METHOD C<getBalanceFactor>

Returns the balance factor of this tree node.

=head4 Parameters

=over

=item C<self>

This AVL tree node.

=back

=head4 Return

The balance factor.

=head3 METHOD C<initialize>

Initializes an empty AVL tree node.

=head4 Parameters

=over

=item C<self>

This general tree.

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

=cut

