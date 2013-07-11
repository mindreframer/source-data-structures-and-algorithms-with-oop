#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:41 $
#   $RCSfile: ExponentialRV.pm,v $
#   $Revision: 1.2 $
#
#   $Id: ExponentialRV.pm,v 1.2 2005/09/25 23:52:41 brpreiss Exp $
#

use strict;

#{
# @class Opus10::ExponentialRV
# An exponentially distributed random variable.
# @attr _mu The mean.
package Opus10::ExponentialRV;
use Opus10::Declarators;
use Opus10::RandomVariable;
use Opus10::RandomNumberGenerator;
our @ISA = qw(Opus10::RandomVariable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this exponentially distributed random variable
# with the given mean.
# @param self This random variable.
# @param mu The mean.
sub initialize
{
    my ($self, $mu) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_mu);
    $self->{_mu} = $mu;
}

destructor qw(DESTROY);

# @method next
# Returns the next value of this random variable.
# @param self This random variable.
# @return The next value.
sub next
{
    my ($self) = @_;
    return -$self->{_mu} *
	log(Opus10::RandomNumberGenerator->next());
}
#}>a

# @function main
# Main program.
# @param Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "ExponentialRV test program.\n";
    my $rv = Opus10::ExponentialRV->new(100);
    for (my $i = 0; $i < 10; ++$i)
    {
	printf "%.15g\n", $rv->next();
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

=head1 MODULE C<Opus10::ExponentialRV>

=head2 CLASS C<Opus10::ExponentialRV>

=head3 Base Classes

=over

=item C<Opus10::RandomVariable>

=back

An exponentially distributed random variable.

=head3 ATTRIBUTES

=over

=item C<_mu>

The mean.

=back

=head3 METHOD C<initialize>

Initializes this exponentially distributed random variable
with the given mean.

=head4 Parameters

=over

=item C<self>

This random variable.

=item C<mu>

The mean.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<Command-line>

arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<next>

Returns the next value of this random variable.

=head4 Parameters

=over

=item C<self>

This random variable.

=back

=head4 Return

The next value.

=cut

