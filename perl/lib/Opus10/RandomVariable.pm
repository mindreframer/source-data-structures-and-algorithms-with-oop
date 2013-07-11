#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: RandomVariable.pm,v $
#   $Revision: 1.2 $
#
#   $Id: RandomVariable.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @class Opus10::RandomVariable
# Abstract base class from which all random variables are derived.
package Opus10::RandomVariable;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this random variable.
# @param self This random variable.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method next
# Returns the next sample.
# @param self This random variable.
# @return The next sample.
abstract_method qw(next);

1;
__DATA__

=head1 MODULE C<Opus10::RandomVariable>

=head2 CLASS C<Opus10::RandomVariable>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Abstract base class from which all random variables are derived.

=head3 METHOD C<initialize>

Initializes this random variable.

=head4 Parameters

=over

=item C<self>

This random variable.

=back

=head3 METHOD C<next>

Returns the next sample.

=head4 Parameters

=over

=item C<self>

This random variable.

=back

=head4 Return

The next sample.

=cut

