#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:46 $
#   $RCSfile: Timer.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Timer.pm,v 1.2 2005/09/25 23:52:46 brpreiss Exp $
#

use strict;

# @class Opus10::Timer
# A timer for measuring the elapsed time.
# @attr _startClock
# @attr _stopClock
# @attr _startTime
# @attr _stopTime
# @attr _state
package Opus10::Timer;
use Carp;
use POSIX;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

our $VERSION = 1.00;

use constant STOPPED => 1;
use constant RUNNING => 2;
use constant TOLERANCE => 100;

# @method initialize
# Initializes this timer.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_startTime _stopTime _startClock _stopClock _state);
    $self->{_startClock} = clock;
    $self->{_stopClock} = $self->{_startClock};
    $self->{_startTime} = time;
    $self->{_stopTime} = $self->{_startTime};
    $self->{_state} = STOPPED;
}

destructor qw(DESTROY);

# @method start
# Starts this timer.
# @param self This timer.
sub start
{
    my ($self) = @_;
    croak 'StateError' if $self->{_state} != STOPPED;
    $self->{_startTime} = time;
    $self->{_startClock} = clock;
    $self->{_state} = RUNNING;
}

# @method stop
# Stops this timer.
# @param self This timer.
sub stop
{
    my ($self) = @_;
    croak 'StateError' if $self->{_state} != RUNNING;
    $self->{_stopClock} = clock;
    $self->{_stopTime} = time;
    $self->{_state} = STOPPED;
}

# @method elapsedTime
# Returns the elapsed time.
# @param self This timer.
# @return The elapsed time.
sub elapsedTime
{
    my ($self) = @_;
    if ($self->{_state} == RUNNING)
    {
	$self->{_stopClock} = clock;
	$self->{_stopTime} = time;
    }
    my $elapsedTime = ($self->{_stopTime} - $self->{_startTime});
    # This is a gross kludge.
    # The clock method measures CPU time
    # but time method measures real-time
    # so these times are not really interchangeable.
    if ($elapsedTime < TOLERANCE)
    {
	$elapsedTime = ($self->{_stopClock} - $self->{_startClock}) / 1000000.0;
    }
    return $elapsedTime;
}

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    printf "Timer test program.\n";
    my $t = Opus10::Timer->new();
    $t->start();
    my $x = 2;
    for (my $i = 0; $i < 10000000; ++$i)
    {
	$x = $x * 2;
    }
    $t->stop();
    printf "Elapsed time %g\n", $t->elapsedTime();
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

=head1 MODULE C<Opus10::Timer>

=head2 CLASS C<Opus10::Timer>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

A timer for measuring the elapsed time.

=head3 ATTRIBUTES

=over

=item C<_startClock>


=item C<_startTime>


=item C<_state>


=item C<_stopClock>


=item C<_stopTime>


=back

=head3 METHOD C<elapsedTime>

Returns the elapsed time.

=head4 Parameters

=over

=item C<self>

This timer.

=back

=head4 Return

The elapsed time.

=head3 METHOD C<initialize>

Initializes this timer.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<start>

Starts this timer.

=head4 Parameters

=over

=item C<self>

This timer.

=back

=head3 METHOD C<stop>

Stops this timer.

=head4 Parameters

=over

=item C<self>

This timer.

=back

=cut

