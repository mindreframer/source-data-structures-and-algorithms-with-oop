#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: String.pm,v $
#   $Revision: 1.2 $
#
#   $Id: String.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

#{
# @class Opus10::String
# Used to wrap a string into an object.
package Opus10::String;
use Opus10::Declarators;
use Opus10::Wrapper;
our @ISA = qw(Opus10::Wrapper);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this string.
# @param self This string.
# @param value A value.
sub initialize
{
    my ($self, $value) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize($value);
}

destructor qw(DESTROY);

# @method compareTo
# Compares this string with the given string.
# @param self This wrapper.
# @param obj The given wrapper.
# @return A number less than zero if this string is less than
# the value in the given wrapper,
# zero if this string equals the value in the given wrapper, and
# a number greater than zero if this string is greater than
# the value in the given wrapper.
sub compareTo
{
    my ($self, $obj) = @_;
    return $self->{_value} cmp $obj->{_value};
}
#}>a


#{
use constant SHIFT => 6;
use constant MASK => ~0 << (32 - SHIFT);

# @method hash
# Returns a hash of this string.
# @param self This string.
# @return An integer.
sub hash
{
    my ($self) = @_;
    my $result = 0;
    for (my $i = 0; $i < length($self->{_value}); ++$i)
    {
	my $c = ord(substr($self->{_value}, $i, 1));
	$result = (($result & MASK) ^ ($result << SHIFT) ^ $c);
    }
    return $result;
}
#}>b

# @function testHash
# String hash test program.
sub testHash
{
    printf "String hash test program.\n";
    printf "ett=0%o\n", Opus10::String->new("ett")->hash();
    printf "tva=0%o\n", Opus10::String->new("tva")->hash();
    printf "tre=0%o\n", Opus10::String->new("tre")->hash();
    printf "fyra=0%o\n", Opus10::String->new("fyra")->hash();
    printf "fem=0%o\n", Opus10::String->new("fem")->hash();
    printf "sex=0%o\n", Opus10::String->new("sex")->hash();
    printf "sju=0%o\n", Opus10::String->new("sju")->hash();
    printf "atta=0%o\n", Opus10::String->new("atta")->hash();
    printf "nio=0%o\n", Opus10::String->new("nio")->hash();
    printf "tio=0%o\n", Opus10::String->new("tio")->hash();
    printf "elva=0%o\n", Opus10::String->new("elva")->hash();
    printf "tolv=0%o\n", Opus10::String->new("tolv")->hash();
    printf "abcdefghijklmnopqrstuvwxy=0%o\n",
	    Opus10::String->new("abcdefghijklmnopqrstuvwxyz")->hash();
    printf "ece.uwaterloo.ca=0%o\n",
	Opus10::String->new("ece.uwaterloo.ca")->hash();
    printf "cs.uwaterloo.ca=0%o\n",
	Opus10::String->new("cs.uwaterloo.ca")->hash();
    printf "un=0%o\n", Opus10::String->new("un")->hash();
    printf "deux=0%o\n", Opus10::String->new("deux")->hash();
    printf "trois=0%o\n", Opus10::String->new("trois")->hash();
    printf "quatre=0%o\n", Opus10::String->new("quatre")->hash();
    printf "cinq=0%o\n", Opus10::String->new("cinq")->hash();
    printf "six=0%o\n", Opus10::String->new("six")->hash();
    printf "sept=0%o\n", Opus10::String->new("sept")->hash();
    printf "huit=0%o\n", Opus10::String->new("huit")->hash();
    printf "neuf=0%o\n", Opus10::String->new("neuf")->hash();
    printf "dix=0%o\n", Opus10::String->new("dix")->hash();
    printf "onze=0%o\n", Opus10::String->new("onze")->hash();
    printf "douze=0%o\n", Opus10::String->new("douze")->hash();
}

# @function main
# String test program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    printf "String test program.\n";
    my $s1 = Opus10::String->new("one");
    my $s2 = Opus10::String->new("one");
    my $s3 = Opus10::String->new("two");
    printf "s1 = %s\n", $s1;
    printf "s2 = %s\n", $s2;
    printf "s3 = %s\n", $s3;
    printf "s1 < s2 = %s\n", $s1 < $s2 ? 1 : 0;
    printf "s1 == s2 = %s\n", $s1 == $s2;
    printf "s1->is(s2) = %s\n", $s1->is($s2);
    printf "s1 > s2 = %s\n", $s1 > $s2 ? 1 : 0;
    printf "s1 . s2 = %s\n", $s1 . $s2;
    printf "%s\n", $s1->getValue();
    printf "%s\n", $s2->getValue();
    printf "%s\n", $s3->getValue();
    Opus10::String::testHash();
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::String>

=head2 CLASS C<Opus10::String>

=head3 Base Classes

=over

=item C<Opus10::Wrapper>

=back

Used to wrap a string into an object.

=head3 METHOD C<compareTo>

Compares this string with the given string.

=head4 Parameters

=over

=item C<self>

This wrapper.

=item C<obj>

The given wrapper.

=back

=head4 Return

A number less than zero if this string is less than
the value in the given wrapper,
zero if this string equals the value in the given wrapper, and
a number greater than zero if this string is greater than
the value in the given wrapper.

=head3 METHOD C<hash>

Returns a hash of this string.

=head4 Parameters

=over

=item C<self>

This string.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this string.

=head4 Parameters

=over

=item C<self>

This string.

=item C<value>

A value.

=back

=head3 FUNCTION C<main>

String test program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 FUNCTION C<testHash>

String hash test program.

=cut

