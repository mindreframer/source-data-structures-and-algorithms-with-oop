#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: PartitionAsForestV2.pm,v $
#   $Revision: 1.2 $
#
#   $Id: PartitionAsForestV2.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::PartitionAsForestV2
# Partition implemented as a forest of trees.
package Opus10::PartitionAsForestV2;
use Carp;
use Opus10::Declarators;
use Opus10::PartitionAsForest;
our @ISA = qw(Opus10::PartitionAsForest);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this partition with the given universe size.
# @param universeSize The size of the universal set.
# @method initialize
# @param self This partition.
# @param size The size of the universal set.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($size);
}

destructor qw(DESTROY);

1;

#{
# @method find
# Returns the element of this partition that contains the given item.
# (Collapsing find).
# @param self This parition.
# @param item An item of the universal set.
# @return The element that contains the given item.
sub find
{
    my ($self, $item) = @_;
    my $root = ${$self->{_array}}[$item];
    while (defined($root->getParent()))
    {
	$root = $root->getParent();
    }
    my $ptr = ${$self->{_array}}[$item];
    while (defined($ptr->getParent()))
    {
	my $tmp = $ptr;
	$ptr = $ptr->getParent();
	$tmp->setParent($root);
    }
    return $root;
}
#}>a

#{
# @method join
# Joins the given elements of this partition.
# (Union by size).
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
    if ($s->getCount() > $t->getCount())
    {
	$t->setParent($s);
	$s->setCount($s->getCount() + $t->getCount());
    }
    else
    {
	$s->setParent($t);
	$t->setCount($t->getCount() + $s->getCount());
    }
    $self->{_count} -= 1;
}
#}>b


# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "PartitionAsForestV2 test program.\n";
    my $p = Opus10::PartitionAsForestV2->new(5);
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

=head1 MODULE C<Opus10::PartitionAsForestV2>

=head2 CLASS C<Opus10::PartitionAsForestV2>

=head3 Base Classes

=over

=item C<Opus10::PartitionAsForest>

=back

Partition implemented as a forest of trees.

=head3 METHOD C<find>

Returns the element of this partition that contains the given item.
(Collapsing find).

=head4 Parameters

=over

=item C<self>

This parition.

=item C<item>

An item of the universal set.

=back

=head4 Return

The element that contains the given item.

=head3 METHOD C<initialize>


=head4 Parameters

=over

=item C<self>

This partition.

=item C<size>

The size of the universal set.

=back

=head3 METHOD C<join>

Joins the given elements of this partition.
(Union by size).

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

=cut

