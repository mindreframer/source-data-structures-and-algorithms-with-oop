#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: OpenScatterTableV2.pm,v $
#   $Revision: 1.2 $
#
#   $Id: OpenScatterTableV2.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::OpenScatterTableV2
# Open scatter table implemented using an array.
# This version provides an improved withdraw method.
# @attr array The array.
package Opus10::OpenScatterTableV2;
use Carp;
use Opus10::Declarators;
use Opus10::OpenScatterTable;
our @ISA = qw(Opus10::OpenScatterTable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes a open scatter table with the given size.
# @param self This scatter table.
# @param size The size of the scatter table.
sub initialize
{
    my ($self, $size) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($size);
}

destructor qw(DESTROY);

#{
# @method withdraw
# Withdraws the given object from this scatter table.
# @param self This scatter table.
# @param obj The object to withdraw.
sub withdraw
{
    my ($self, $obj) = @_;
    croak 'ContainerEmpty' if $self->{_count} == 0;
    my $i = $self->findInstance($obj);
    croak 'ArgumentError' if $i < 0;
    while (1)
    {
	my $j = ($i + 1) % $self->getLength();
	while (${$self->{_array}}[$j]->getState() ==
	    $Opus10::OpenScatterTable::OCCUPIED)
	{
	    my $h = $self->h(${$self->{_array}}[$j]->getObj());
	    last if (($h <= $i && $i < $j) ||
		    ($i < $j && $j < $h) ||
		    ($j < $h && $h <= $i));
	    $j = ($j + 1) % $self->getLength();
	}
	last if (${$self->{_array}}[$j]->getState() ==
	    $Opus10::OpenScatterTable::EMPTY);
	${$self->{_array}}[$i] = ${$self->{_array}}[$j];
	$i = $j;
    }
    ${$self->{_array}}[$i] =
	Opus10::OpenScatterTable::Entry->new(
	    $Opus10::OpenScatterTable::EMPTY, undef);
    $self->{_count} -= 1;
}
#}>a

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on stateess; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "OpenScatterTableV2 test program.\n";
    my $hashTable = Opus10::OpenScatterTableV2->new(57);
    Opus10::HashTable::test($hashTable);
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

=head1 MODULE C<Opus10::OpenScatterTableV2>

=head2 CLASS C<Opus10::OpenScatterTableV2>

=head3 Base Classes

=over

=item C<Opus10::OpenScatterTable>

=back

Open scatter table implemented using an array.
This version provides an improved withdraw method.

=head3 ATTRIBUTES

=over

=item C<array>

The array.

=back

=head3 METHOD C<initialize>

Initializes a open scatter table with the given size.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<size>

The size of the scatter table.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on stateess; non-zero on failure.

=head3 METHOD C<withdraw>

Withdraws the given object from this scatter table.

=head4 Parameters

=over

=item C<self>

This scatter table.

=item C<obj>

The object to withdraw.

=back

=cut

