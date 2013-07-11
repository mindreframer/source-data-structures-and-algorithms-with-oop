#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: PartitionAsForest.pm,v $
#   $Revision: 1.2 $
#
#   $Id: PartitionAsForest.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::PartitionAsForest::Tree
# Represents an element of a partition.
# @attr _universeSize The size of the universal set.
# @attr _partition The partition.
# @attr _parent The parent of this partition tree node.
# @attr _rank The rank of this partition tree node.
# @attr _count The number of items in this partition.
package Opus10::PartitionAsForest::Tree;
use Opus10::Declarators;
use Opus10::Set;
use Opus10::Tree;
our @ISA = qw(Opus10::Set Opus10::Tree);

# @method initialize
# Initializes this partition tree that is an element of the
# given partition and contains the given item.
# @param self This partition tree.
# @param partition A partition.
# @param item An item.
sub initialize
{
    my ($self, $partition, $item) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_universeSize _partition _item
			_parent _rank _count);
    $self->{_universeSize} = $partition->getUniverseSize();
    $self->{_partition} = $partition;
    $self->{_item} = $item;
    $self->{_parent} = undef;
    $self->{_rank} = 0;
    $self->{_count} = 1;
}

destructor qw(DESTROY);

attr_reader qw(_universeSize);
attr_reader qw(_partition);
attr_accessor qw(_parent);
attr_accessor qw(_rank);
attr_accessor qw(_count);
#}>a

# @method purge
# Purges this partition tree.
# @param self This partition tree.
sub purge
{
    my ($self) = @_;
    $self->{_partition} = undef;
    $self->{_parent} = undef;
    $self->{_rank} = 0;
    $self->{_count} = 1;
}

# @method getHeight
# Returns the height of this partition tree node.
# @param self This partition tree node.
# @return The height of this partition tree node.
sub getHeight
{
    my ($self) = @_;
    return $self->{_rank};
}

# @method getKey
# Returns the item in this partition tree node.
# @param self This partition tree node.
sub getKey
{
    my ($self) = @_;
    return $self->{_item};
}

# @method compareTo
# Compares this partition tree node with the given partition tree node.
# @param self This partition tree node.
# @param tree The partition tree node to be compared.
# @return A number less than, equal to, or greater than zero
# depending on whether this partition tree node is
# less than, equal to, or greater than (respectively)
# the given partition tree node.
sub compareTo
{
    my ($self, $tree) = @_;
    return $self->{_item} - $tree->{_item};
}

use Opus10::Box;

# @method hash
# Returns the hash value for this partition tree node.
# @param self This partition tree node.
sub hash
{
    my ($self) = @_;
    return box($self->{_item})->hash();
}

# @method toString
# Returns a string representation of this partition tree node.
# @param self This partition tree node.
sub toString
{
    my ($self) = @_;
    my $s = '' . $self->{_item};
    if (defined($self->{_parent}))
    {
	$s .= ', ' . $self->{_parent};
    }
    return '{' . $s . '}';
}

# @method isEmpty
# Returns true if this partition tree is empty.
# @param self This partition tree node.
sub isEmpty
{
    return 0;
}

#{
# @class Opus10::PartitionAsForest
# A partition implemented as a forest of trees.
# @attr _array The forest.
package Opus10::PartitionAsForest;
use Carp;
use Opus10::Declarators;
use Opus10::Partition;
use Opus10::Tree;
use Opus10::Set;
use Opus10::Array;
our @ISA = qw(Opus10::Partition);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this partition with the given universe size.
# @param self This partition.
# @param n The size of the universal set.
sub initialize
{
    my ($self, $n) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($n);
    $self->declare qw(_array);
    tie (@{$self->{_array}}, 'Opus10::Array', $n);
    for (my $item = 0; $item < $n; ++$item)
    {
	${$self->{_array}}[$item] =
	    Opus10::PartitionAsForest::Tree->new($self, $item);
    }
    $self->{_count} = $n;
}

destructor qw(DESTROY);
#}>b

1;

#{
# @method find
# Finds the partition element that contains the given item.
# @param self This partition.
# @param item An item of the universal set.
# @return The element that contains the given item.
sub find
{
    my ($self, $item) = @_;
    my $ptr = ${$self->{_array}}[$item];
    while (defined($ptr->getParent()))
    {
	$ptr = $ptr->getParent();
    }
    return $ptr;
}
#}>c

#{
# @method join
# Joins the given elements of this partition.
# @param self This partition.
# @param s An element of this partition.
# @param t An element of this partition.
sub join
{
    my ($self, $s, $t) = @_;
    croak 'DomainError'
	if !$self->contains($s) || defined($s->getParent()) ||
	   !$self->contains($t) || defined($t->getParent()) ||
	   $s->is($t);
    $t->setParent($s);
    $self->{_count} -= 1;
}
#}>d

# @method purge
# Purges this partition.
# @param self This partition.
sub purge
{
    my ($self) = @_;
    for (my $item = 0; $item < $self->{_universeSize}; ++$item)
    {
	${$self->{_array}}[$item]->purge();
    }
}

# @method contains
# Returns true if the given object is an element of this partition.
# @param self This parition.
# @param obj An object.
sub contains
{
    my ($self, $obj) = @_;
    return $obj->getPartition()->is($self);
}

# @method each
# Calls the given visitor function for the items in the partition.
# @param self This partition.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    for (my $i = 0; $i < $self->{_universeSize}; ++$i)
    {
	&$visitor(${$self->{_array}}[$i]);
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
    printf "PartitionAsForest test program.\n";
    my $p = Opus10::PartitionAsForest->new(5);
    Opus10::Partition::test($p);
    $p->purge();
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

=head1 MODULE C<Opus10::PartitionAsForest>

=head2 CLASS C<Opus10::PartitionAsForest>

=head3 Base Classes

=over

=item C<Opus10::Partition>

=back

A partition implemented as a forest of trees.

=head3 ATTRIBUTES

=over

=item C<_array>

The forest.

=back

=head3 METHOD C<contains>

Returns true if the given object is an element of this partition.

=head4 Parameters

=over

=item C<self>

This parition.

=item C<obj>

An object.

=back

=head3 METHOD C<each>

Calls the given visitor function for the items in the partition.

=head4 Parameters

=over

=item C<self>

This partition.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<find>

Finds the partition element that contains the given item.

=head4 Parameters

=over

=item C<self>

This partition.

=item C<item>

An item of the universal set.

=back

=head4 Return

The element that contains the given item.

=head3 METHOD C<initialize>

Initializes this partition with the given universe size.

=head4 Parameters

=over

=item C<self>

This partition.

=item C<n>

The size of the universal set.

=back

=head3 METHOD C<join>

Joins the given elements of this partition.

=head4 Parameters

=over

=item C<self>

This partition.

=item C<s>

An element of this partition.

=item C<t>

An element of this partition.

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

=head3 METHOD C<purge>

Purges this partition.

=head4 Parameters

=over

=item C<self>

This partition.

=back

=head2 CLASS C<Opus10::PartitionAsForest::Tree>

=head3 Base Classes

=over

=item C<Opus10::Set>

=item C<Opus10::Tree>

=back

Represents an element of a partition.

=head3 ATTRIBUTES

=over

=item C<_count>

The number of items in this partition.

=item C<_parent>

The parent of this partition tree node.

=item C<_partition>

The partition.

=item C<_rank>

The rank of this partition tree node.

=item C<_universeSize>

The size of the universal set.

=back

=head3 METHOD C<compareTo>

Compares this partition tree node with the given partition tree node.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=item C<tree>

The partition tree node to be compared.

=back

=head4 Return

A number less than, equal to, or greater than zero
depending on whether this partition tree node is
less than, equal to, or greater than (respectively)
the given partition tree node.

=head3 METHOD C<getHeight>

Returns the height of this partition tree node.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=back

=head4 Return

The height of this partition tree node.

=head3 METHOD C<getKey>

Returns the item in this partition tree node.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=back

=head3 METHOD C<hash>

Returns the hash value for this partition tree node.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=back

=head3 METHOD C<initialize>

Initializes this partition tree that is an element of the
given partition and contains the given item.

=head4 Parameters

=over

=item C<self>

This partition tree.

=item C<partition>

A partition.

=item C<item>

An item.

=back

=head3 METHOD C<isEmpty>

Returns true if this partition tree is empty.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=back

=head3 METHOD C<purge>

Purges this partition tree.

=head4 Parameters

=over

=item C<self>

This partition tree.

=back

=head3 METHOD C<toString>

Returns a string representation of this partition tree node.

=head4 Parameters

=over

=item C<self>

This partition tree node.

=back

=cut

