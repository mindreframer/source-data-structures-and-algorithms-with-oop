#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: GeneralTree.pm,v $
#   $Revision: 1.2 $
#
#   $Id: GeneralTree.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::GeneralTree
# A general tree implemented using a linked-list of subtrees.
# @attr _key The key.
# @attr _degree The degree.
# @attr _list The linked list.
package Opus10::GeneralTree;
use Carp;
use Opus10::Declarators;
use Opus10::Tree;
use Opus10::LinkedList;
our @ISA = qw(Opus10::Tree);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a general tree node that contains the given key.
# @param self This general tree.
# @param key An object.
sub initialize
{
    my ($self, $key) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_key _degree _list);
    $self->{_key} = $key;
    $self->{_degree} = 0;
    $self->{_list} = Opus10::LinkedList->new();
}

destructor qw(DESTROY);

# @method purge
# Purges this general tree.
# @param self This general tree.
sub purge
{
    my ($self) = @_;
    $self->{_key} = undef;
    $self->{_list}->purge();
    $self->{_degree} = 0;
}
#}>a

#{
attr_reader qw(_key);

# @method getSubtree
# Returns the specified subtree of this general tree node.
# @param self This general tree.
# @param i An index.
# @return The specified subtree
sub getSubtree
{
    my ($self, $i) = @_;
    croak 'IndexError' if ($i < 0 || $i >= $self->{_degree});
    my $ptr = $self->{_list}->getHead();
    for (my $j = 1; $j <= $i; ++$j)
    {
	$ptr = $ptr->getSucc();
    }
    return $ptr->getDatum();
}

# @method attachSubtree
# Attaches the given general tree to this general tree node.
# @param self This general tree.
# @param t A general tree.
sub attachSubtree
{
    my ($self, $t) = @_;
    $self->{_list}->append($t);
    $self->{_degree} += 1;
}

# @method detachSubtree
# Detaches and returns the specified subtree of this general tree node.
# @param self This general tree.
# @param t A general tree.
sub detachSubtree
{
    my ($self, $t) = @_;
    $self->{_list}->extract($t);
    $self->{_degree} -= 1;
    return $t;
}
#}>b

# @method isEmpty
# IsEmpty predicate.
# Always returns false because general tree nodes cannot be empty.
# @param self This general tree.
# @return True if this general tree node is empty.
sub isEmpty
{
    return 0;
}

# @method isLeaf
# IsLeaf predicate.
# @param self This general tree.
# @return True if this general tree node is a leaf.
sub isLeaf
{
    my ($self) = @_;
    return $self->{_degree} == 0;
}

attr_reader qw(_degree);

use Opus10::Box;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "GeneralTree test program.\n";
    my $gt = Opus10::GeneralTree->new(box('A'));
    $gt->attachSubtree(Opus10::GeneralTree->new(box('B')));
    $gt->attachSubtree(Opus10::GeneralTree->new(box('C')));
    $gt->attachSubtree(Opus10::GeneralTree->new(box('D')));
    $gt->attachSubtree(Opus10::GeneralTree->new(box('E')));
    Opus10::Tree::test($gt);
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

=head1 MODULE C<Opus10::GeneralTree>

=head2 CLASS C<Opus10::GeneralTree>

=head3 Base Classes

=over

=item C<Opus10::Tree>

=back

A general tree implemented using a linked-list of subtrees.

=head3 ATTRIBUTES

=over

=item C<_degree>

The degree.

=item C<_key>

The key.

=item C<_list>

The linked list.

=back

=head3 METHOD C<attachSubtree>

Attaches the given general tree to this general tree node.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<t>

A general tree.

=back

=head3 METHOD C<detachSubtree>

Detaches and returns the specified subtree of this general tree node.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<t>

A general tree.

=back

=head3 METHOD C<getSubtree>

Returns the specified subtree of this general tree node.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<i>

An index.

=back

=head4 Return

The specified subtree

=head3 METHOD C<initialize>

Initializes a general tree node that contains the given key.

=head4 Parameters

=over

=item C<self>

This general tree.

=item C<key>

An object.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate.
Always returns false because general tree nodes cannot be empty.

=head4 Parameters

=over

=item C<self>

This general tree.

=back

=head4 Return

True if this general tree node is empty.

=head3 METHOD C<isLeaf>

IsLeaf predicate.

=head4 Parameters

=over

=item C<self>

This general tree.

=back

=head4 Return

True if this general tree node is a leaf.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this general tree.

=head4 Parameters

=over

=item C<self>

This general tree.

=back

=cut

