#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:39 $
#   $RCSfile: Association.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Association.pm,v 1.2 2005/09/25 23:52:39 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Association
# Represents a (key, value) pair.
# @attr key A key.
# @attr value A value.
package Opus10::Association;
use Carp;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this association.
# @param self This association.
# @param key A key.
# @param value A value. Optional
sub initialize
{
    my ($self, $key, $value) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_key _value);
    $self->{_key} = $key;
    $self->{_value} = $value;
}

destructor qw(DESTROY);
#}>a

#{
attr_reader qw(_key);
attr_accessor qw(_value);
#}>b

#{
# @method compareTo
# Compares this association with the given association.
# @param self This association.
# @param assoc The given association.
# @return A number less than zero if the key in this association
# is less than the key in the given assocation,
# zero if the keys are equal, and
# a number greater than zero if the key in this association
# is greater than the key in the given assocation.
sub compareTo
{
    my ($self, $assoc) = @_;
    croak 'ArgumentError' if !$assoc->isa(__PACKAGE__);
    my $tmp = $assoc->{_key};
    return $self->{_key}->compare($tmp);
}

# @method toString
# Returns a string representation of this association.
# @param self This association.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $value = $self->{_value} || 'undef';
    return sprintf("%s{%s, %s}",
	ref($self), $self->{_key}, $value);
}
#}>c

#{
# @method hash
# Returns a hash value for this association.
# @param self This association.
# @return An integer
sub hash
{
    my ($self) = @_;
    return $self->{_key}->hash();
}
#}>d

use Opus10::Box;

# @function main
# Association test program.
# @param args Command-line arguments.
# @return 0 on succes; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;
    printf "Association test program.\n";
    my $a = Opus10::Association->new(box(1),box(2));
    printf "%s %s %s\n", $a, $a->getKey(), $a->getValue();
    printf "%d\n", $a->hash();
    printf "%d\n",
	Opus10::Association->new(box(2),box(2)) >
	Opus10::Association->new(box(3),box(2));
    my $b = Opus10::Association->new(box(3));
    printf "%s\n", $b;
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

=head1 MODULE C<Opus10::Association>

=head2 CLASS C<Opus10::Association>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Represents a (key, value) pair.

=head3 ATTRIBUTES

=over

=item C<key>

A key.

=item C<value>

A value.

=back

=head3 METHOD C<compareTo>

Compares this association with the given association.

=head4 Parameters

=over

=item C<self>

This association.

=item C<assoc>

The given association.

=back

=head4 Return

A number less than zero if the key in this association
is less than the key in the given assocation,
zero if the keys are equal, and
a number greater than zero if the key in this association
is greater than the key in the given assocation.

=head3 METHOD C<hash>

Returns a hash value for this association.

=head4 Parameters

=over

=item C<self>

This association.

=back

=head4 Return

An integer

=head3 METHOD C<initialize>

Initializes this association.

=head4 Parameters

=over

=item C<self>

This association.

=item C<key>

A key.

=item C<value>

A value. Optional

=back

=head3 FUNCTION C<main>

Association test program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

0 on succes; non-zero on failure.

=head3 METHOD C<toString>

Returns a string representation of this association.

=head4 Parameters

=over

=item C<self>

This association.

=back

=head4 Return

A string.

=cut

