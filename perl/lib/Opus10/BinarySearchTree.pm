#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: BinarySearchTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: BinarySearchTree.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::BinarySearchTree
# A binary search tree.
package Opus10::BinarySearchTree;
use Carp;
use Opus10::Declarators;
use Opus10::BinaryTree;
use Opus10::SearchTree;
our @ISA = qw(Opus10::BinaryTree Opus10::SearchTree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a binary search tree node
# that contains the given key and subtrees.
# @param self This general tree.
# @param key An object. Optional.
# @param left A search tree. Optional.
# @param right A search tree. Optional.
sub initialize
{
    my ($self, $key, $left, $right) = @_;
    return if $self->isInitialized();
    $self->Opus10::BinaryTree::initialize($key, $left, $right);
    $self->Opus10::SearchTree::initialize();
}

destructor qw(DESTROY);
#}>a

#{
# @method find
# Returns the object in this binary search tree
# that equals the given object.
# @param self This binary search tree.
# @param obj The object to find.
# @return The object that equals the given object.
sub find
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	return undef;
    }
    my $diff = $obj <=> $self->{_key};
    if ($diff == 0)
    {
	return $self->{_key};
    }
    elsif ($diff < 0)
    {
	return $self->{_left}->find($obj);
    }
    elsif ($diff > 0)
    {
	return $self->{_right}->find($obj);
    }
}

# @method getMin
# Returns the smallest object in this binary search tree.
# @param self This binary search tree.
# @return The smallest key.
sub getMin
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return undef;
    }
    elsif ($self->{_left}->isEmpty())
    {
	return $self->{_key};
    }
    else
    {
	return $self->{_left}->getMin();
    }
}
#}>b

#{
# @method insert
# Inserts the given object into this binary search tree.
# @param self This binary search tree.
# @param obj The object to insert.
sub insert
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	$self->attachKey($obj);
    }
    else
    {
	my $diff = $obj <=> $self->{_key};
	if ($diff == 0)
	{
	    croak 'ArgumentError';
	}
	elsif ($diff < 0)
	{
	    $self->{_left}->insert($obj);
	}
	elsif ($diff > 0)
	{
	    $self->{_right}->insert($obj);
	}
    }
    $self->balance();
}

# @method attachKey
# Attaches the given key to this binary search tree node.
# @param self This binary search tree.
# @param obj An object.
sub attachKey
{
    my ($self, $obj) = @_;
    croak 'StateError' if (!$self->isEmpty());
    $self->{_key} = $obj;
    $self->{_left} = Opus10::BinarySearchTree->new();
    $self->{_right} = Opus10::BinarySearchTree->new();
}

# @method balance
# Balances this binary search tree.
# This method does nothing. It is may be overridden in derived classes.
# @param self This binary search tree.
sub balance
{
    my ($self) = @_;
}
#}>c

#{
# @method withdraw
# Withdraws the given object from this binary search tree.
# @param self This binary search tree.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	croak 'ArgumentError';
    }
    my $diff = $obj <=> $self->{_key};
    if ($diff == 0)
    {
	if (!$self->{_left}->isEmpty())
	{
	    my $max = $self->{_left}->getMax();
	    $self->{_key} = $max;
	    $self->{_left}->withdraw($max);
	}
	elsif (!$self->{_right}->isEmpty())
	{
	    my $min = $self->{_right}->getMin();
	    $self->{_key} = $min;
	    $self->{_right}->withdraw($min);
	}
	else
	{
	    $self->detachKey();
	}
    }
    elsif ($diff < 0)
    {
	$self->{_left}->withdraw($obj);
    }
    elsif ($diff > 0)
    {
	$self->{_right}->withdraw($obj);
    }
    $self->balance();
}
#}>d

# @method getMax
# Returns the largest object in this binary search tree.
# @param self This binary search tree.
# @return The largest object.
sub getMax
{
    my ($self) = @_;
    if ($self->isEmpty())
    {
	return undef;
    }
    elsif ($self->{_right}->isEmpty())
    {
	return $self->{_key};
    }
    else
    {
	return $self->{_right}->getMax();
    }
}

# @method contains
# Returns true if the given object is in this binary search tree.
# @param self This binary search tree.
# @param obj An object.
# @return True if the given object is in this binary search tree.
sub contains
{
    my ($self, $obj) = @_;
    if ($self->isEmpty())
    {
	return 0;
    }
    elsif ($self->{_key}->is($obj))
    {
	return 1;
    }
    elsif ($obj < $self->{_key})
    {
	return $self->{_left}->contains($obj);
    }
    elsif ($obj > $self->{_key})
    {
	return $self->{_right}->contains($obj);
    }
    else
    {
	return 0;
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
    printf "BinarySearchTree test program.\n";
    my $tree = Opus10::BinarySearchTree->new();
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

=head1 MODULE C<Opus10::BinarySearchTree>

=head2 CLASS C<Opus10::BinarySearchTree>

=head3 Base Classes

=over

=item C<Opus10::BinaryTree>

=item C<Opus10::SearchTree>

=back

A binary search tree.

=head3 METHOD C<attachKey>

Attaches the given key to this binary search tree node.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=item C<obj>

An object.

=back

=head3 METHOD C<balance>

Balances this binary search tree.
This method does nothing. It is may be overridden in derived classes.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=back

=head3 METHOD C<contains>

Returns true if the given object is in this binary search tree.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=item C<obj>

An object.

=back

=head4 Return

True if the given object is in this binary search tree.

=head3 METHOD C<find>

Returns the object in this binary search tree
that equals the given object.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=item C<obj>

The object to find.

=back

=head4 Return

The object that equals the given object.

=head3 METHOD C<getMax>

Returns the largest object in this binary search tree.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=back

=head4 Return

The largest object.

=head3 METHOD C<getMin>

Returns the smallest object in this binary search tree.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=back

=head4 Return

The smallest key.

=head3 METHOD C<initialize>

Initializes a binary search tree node
that contains the given key and subtrees.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<key>

An object. Optional.

=item C<left>

A search tree. Optional.

=item C<right>

A search tree. Optional.

=back

=head3 METHOD C<insert>

Inserts the given object into this binary search tree.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=item C<obj>

The object to insert.

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

=head3 METHOD C<withdraw>

Withdraws the given object from this binary search tree.

=head4 Parameters

=over

=item C<self>

This binary search tree.

=item C<obj>

The object to withdraw.

=back

=cut

