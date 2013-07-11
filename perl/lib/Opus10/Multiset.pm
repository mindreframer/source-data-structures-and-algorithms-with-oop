#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: Multiset.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Multiset.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Multiset
# Abstract base class from which all multiset classes are derived.
package Opus10::Multiset;
use Opus10::Declarators;
use Opus10::Set;
our @ISA = qw(Opus10::Set);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this multiset with the given universal set size.
# @param universeSize The size of the universal set.
# @method initialize
# @param self This multiset.
# @param size The size of the universal set.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($size);
}

destructor qw(DESTROY);
#}>a

# @function test
# Multiset test function.
# @param s1 A multiset to test.
# @param s2 A multiset to test.
# @param s3 A multiset to test.
sub test
{
    my ($s1, $s2, $s3) = @_;
    printf "Multiset test program.\n";
    for (my $i = 0; $i < 4; ++$i)
    {
	$s1->insert($i);
    }
    for (my $i = 2; $i < 6; ++$i)
    {
	$s2->insert($i);
    }
    $s3->insert(0);
    $s3->insert(2);
    printf "%s\n", $s1;
    printf "%s\n", $s2;
    printf "%s\n", $s3;
    printf "%s\n", $s1 + $s2; # union
    printf "%s\n", $s1 * $s3; # intersection
    printf "%s\n", $s1 - $s3; # difference
    printf "Using each\n";
    $s3->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $s3->iter();
    while (defined(my $obj = $iter->()))
    {
	printf "%s\n", $obj;
    }
}

1;
__DATA__

=head1 MODULE C<Opus10::Multiset>

=head2 CLASS C<Opus10::Multiset>

=head3 Base Classes

=over

=item C<Opus10::Set>

=back

Abstract base class from which all multiset classes are derived.

=head3 METHOD C<initialize>


=head4 Parameters

=over

=item C<self>

This multiset.

=item C<size>

The size of the universal set.

=back

=head3 FUNCTION C<test>

Multiset test function.

=head4 Parameters

=over

=item C<s1>

A multiset to test.

=item C<s2>

A multiset to test.

=item C<s3>

A multiset to test.

=back

=cut

