#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:43 $
#   $RCSfile: Partition.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Partition.pm,v 1.2 2005/09/25 23:52:43 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Partition
# Abstract base class from which all partition classes are derived.
package Opus10::Partition;
use Opus10::Declarators;
use Opus10::Set;
our @ISA = qw(Opus10::Set);

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

# @method find
# Returns the partition element that contains the given item.
# @param self This partition.
# @param item An item of the universal set.
# @return The element that contains the given item.
abstract_method qw(find);

# @method join
# Joins the given partition elements.
# @param self This partition.
# @param s An element of the partition.
# @param t An element of the partition.
abstract_method qw(join);
#}>a

# @function test
# Partition test function.
# @param p A partition to test.
sub test
{
    my ($p) = @_;
    printf "Partition test program.\n";
    printf "%s\n", $p;
    my $s2 = $p->find(2);
    printf "%s\n", $s2;
    my $s4 = $p->find(4);
    printf "%s\n", $s4;
    $p->join($s2, $s4);
    printf "%s\n", $p;
    my $s3 = $p->find(3);
    printf "%s\n", $s3;
    my $s4b = $p->find(4);
    printf "%s\n", $s4b;
    $p->join($s3, $s4b);
    printf "%s\n", $p;
}

1;
__DATA__

=head1 MODULE C<Opus10::Partition>

=head2 CLASS C<Opus10::Partition>

=head3 Base Classes

=over

=item C<Opus10::Set>

=back

Abstract base class from which all partition classes are derived.

=head3 METHOD C<find>

Returns the partition element that contains the given item.

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


=head4 Parameters

=over

=item C<self>

This partition.

=item C<size>

The size of the universal set.

=back

=head3 METHOD C<join>

Joins the given partition elements.

=head4 Parameters

=over

=item C<self>

This partition.

=item C<s>

An element of the partition.

=item C<t>

An element of the partition.

=back

=head3 FUNCTION C<test>

Partition test function.

=head4 Parameters

=over

=item C<p>

A partition to test.

=back

=cut

