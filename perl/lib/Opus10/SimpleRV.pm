#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: SimpleRV.pm,v $
#   $Revision: 1.2 $
#
#   $Id: SimpleRV.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::SimpleRV
# A random variable uniformly distributed on the interval (0, 1].
package Opus10::SimpleRV;
use Opus10::Declarators;
use Opus10::RandomVariable;
use Opus10::RandomNumberGenerator;
our @ISA = qw(Opus10::RandomVariable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this simple random variable.
# @param self This random variable.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method next
# Returns the next value of this random variable.
# @param self This random variable.
# @return The next value.
sub next
{
    my ($self) = @_;
    return Opus10::RandomNumberGenerator->next();
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
    printf "SimpleRV test program.\n";
    my $rv = Opus10::SimpleRV->new();
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

=head1 MODULE C<Opus10::SimpleRV>

=head2 CLASS C<Opus10::SimpleRV>

=head3 Base Classes

=over

=item C<Opus10::RandomVariable>

=back

A random variable uniformly distributed on the interval (0, 1].

=head3 METHOD C<initialize>

Initializes this simple random variable.

=head4 Parameters

=over

=item C<self>

This random variable.

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

