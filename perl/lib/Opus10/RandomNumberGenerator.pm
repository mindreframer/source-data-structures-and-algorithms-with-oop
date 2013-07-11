#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: RandomNumberGenerator.pm,v $
#   $Revision: 1.2 $
#
#   $Id: RandomNumberGenerator.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::RandomNumberGenerator
# A multiplicative linear congruential pseudo-random number generator.
# 
# Adapted from the minimal standard pseudo-random number generator
# described in Stephen K. Park and Keith W. Miller,
# "Random Number Generators: Good Ones Are Hard To Find,"
# Communications of the ACM, Vol. 31, No. 10, Oct. 1988, pp. 1192-1201.
#
# @attr _seed The seed.
package Opus10::RandomNumberGenerator;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
use constant A => 16807;
use constant M => 2147483647;
use constant Q => 127773;
use constant R => 2836;

# @method initialize
# Initializes this random number generator with the given seed.
# @param self This random number generator.
# @param seed An seed in the range 1...M.
sub initialize
{
    my ($self, $seed) = @_;
    $seed = $seed || 1;
    croak 'DomainError' if $seed < 1 || $seed > M;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_seed);
    $self->{_seed} = $seed;
}

destructor qw(DESTROY);

attr_reader qw(_seed);
#}>a

#{
# Singleton
our $SINGLETON = Opus10::RandomNumberGenerator->new(1);

# @method setSeed
# Sets the seed to the given value.
# @param self This random number generator.
# @param seed An seed in the range 1...M.
sub setSeed
{
    my ($self, $seed) = @_;
    if (ref($self) eq __PACKAGE__)
    {
	croak 'DomainError' if $seed < 1 || $seed > M;
	$self->{_seed} = $seed;
    }
    else
    {
	$SINGLETON->setSeed($seed);
    }
}

# @method next
# Returns the next sample from this random number generator.
# @param self This random number generator.
# @return The next sample.
sub next
{
    my ($self) = @_;
    if (ref($self) eq __PACKAGE__)
    {
	use integer;
	$self->{_seed} = A * ($self->{_seed} % Q) -
	    R * ($self->{_seed} / Q);
	if ($self->{_seed} < 0)
	{
	    $self->{_seed} += M;
	}
    }
    else
    {
	return $SINGLETON->next();
    }
    return 1.0 * $self->{_seed} / M;
}

END { $SINGLETON = undef; }
#}>b

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "RandomNumberGenerator test program.\n";
    Opus10::RandomNumberGenerator->setSeed(1);
    for (my $i = 0; $i < 10; ++$i)
    {
	printf "%.15g\n", Opus10::RandomNumberGenerator->next();
    }
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

=head1 MODULE C<Opus10::RandomNumberGenerator>

=head2 CLASS C<Opus10::RandomNumberGenerator>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

A multiplicative linear congruential pseudo-random number generator.
Adapted from the minimal standard pseudo-random number generator
described in Stephen K. Park and Keith W. Miller,
"Random Number Generators: Good Ones Are Hard To Find,"
Communications of the ACM, Vol. 31, No. 10, Oct. 1988, pp. 1192-1201.

=head3 ATTRIBUTES

=over

=item C<_seed>

The seed.

=back

=head3 METHOD C<initialize>

Initializes this random number generator with the given seed.

=head4 Parameters

=over

=item C<self>

This random number generator.

=item C<seed>

An seed in the range 1...M.

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

=head3 METHOD C<next>

Returns the next sample from this random number generator.

=head4 Parameters

=over

=item C<self>

This random number generator.

=back

=head4 Return

The next sample.

=head3 METHOD C<setSeed>

Sets the seed to the given value.

=head4 Parameters

=over

=item C<self>

This random number generator.

=item C<seed>

An seed in the range 1...M.

=back

=cut

