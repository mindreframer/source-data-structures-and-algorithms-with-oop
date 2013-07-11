#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:44 $
#   $RCSfile: Simulation.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Simulation.pm,v 1.2 2005/09/25 23:52:44 brpreiss Exp $
#

use strict;

#{
# @package Opus10::Simulation
# Provides a simulation of an M/M/1 queue.
package Opus10::Simulation;

# Arrival of a customer.
use constant ARRIVAL => 1;
# Departure of a customer.
use constant DEPARTURE => 2;

# @class Opus10::Simulation::Event
# Represents an event in the M/M/1 queue simulation.
package Opus10::Simulation::Event;
use Carp;
use Opus10::Declarators;
use Opus10::Association;
use Opus10::Box;
our @ISA = qw(Opus10::Association);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this event.
# Initializes this event with the given type and time.
# @param type The type of the event.
# @param time The time of the event.
sub initialize
{
    my ($self, $type, $time) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize(box($time), box($type));
}

destructor qw(DESTROY);

# @method getTime
# Returns the time of this event.
# @param self This event.
# @return The time.
sub getTime
{
    my ($self) = @_;
    return unbox($self->getKey());
}

# @method getType
# Returns the type of this event.
# @param self This event.
# @return The type.
sub getType
{
    my ($self) = @_;
    return unbox($self->getValue());
}
#}>a

# @method toString
# Returns a string representation of this event.
# @param self This event.
# @return A string.
sub toString
{
    my ($self) = @_;
    if ($self->getType() == Opus10::Simulation::ARRIVAL)
    {
	return 'Event {' . $self->getTime() . ', arrival}';
    }
    elsif ($self->getType() == Opus10::Simulation::DEPARTURE)
    {
	return 'Event {' . $self->getTime() . ', departure}';
    }
}

#{
# @class Opus10::Simulation
# A discrete-event simulation of an M/M/1 queue.
package Opus10::Simulation;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
use Opus10::LeftistHeap;
use Opus10::ExponentialRV;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this simulation.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_eventList _serverBusy
	_numberInQueue _serviceTime _interArrivalTime);
    $self->{_eventList} = Opus10::LeftistHeap->new();
    $self->{_serverBusy} = 0;
    $self->{_numberInQueue} = 0;
    $self->{_serviceTime} =
	Opus10::ExponentialRV->new(100.0);
    $self->{_interArrivalTime} =
	Opus10::ExponentialRV->new(100.0);
}

destructor qw(DESTROY);
#}>b

#{
# @method run
# Runs this simulation up to the specified time.
# @param self This simulation.
# @param timeLimit The time limit.
sub run
{
    my ($self, $timeLimit) = @_;
    $self->{_eventList}->enqueue(
	Opus10::Simulation::Event->new(ARRIVAL, 0));
    while (!$self->{_eventList}->isEmpty()) {
	my $evt = $self->{_eventList}->dequeueMin();
	my $t = $evt->getTime();
	last if $t > $timeLimit;
#[
	printf "%s\n", $evt;
#]
	if ($evt->getType() == ARRIVAL) {
	    if (!$self->{_serverBusy}) {
		$self->{_serverBusy} = 1;
		$self->{_eventList}->enqueue(
		    Opus10::Simulation::Event->new(DEPARTURE,
			$t + $self->{_serviceTime}->next()));
	    }
	    else {
		$self->{_numberInQueue} += 1;
	    }
	    $self->{_eventList}->enqueue(
		Opus10::Simulation::Event->new(ARRIVAL,
		    $t + $self->{_interArrivalTime}->next()));
	}
	elsif ($evt->getType() == DEPARTURE) {
	    if ($self->{_numberInQueue} == 0) {
		$self->{_serverBusy} = 0;
	    }
	    else {
		$self->{_numberInQueue} -= 1;
		$self->{_eventList}->enqueue(
		    Opus10::Simulation::Event->new(DEPARTURE,
			$t + $self->{_serviceTime}->next()));
	    }
	}
    }
    $self->{_eventList}->purge();
}
#}>c

1;
__DATA__

=head1 MODULE C<Opus10::Simulation>

=head2 PACKAGE C<Opus10::Simulation>

Provides a simulation of an M/M/1 queue.

=head3 METHOD C<initialize>

Initializes this simulation.

=head3 METHOD C<run>

Runs this simulation up to the specified time.

=head4 Parameters

=over

=item C<self>

This simulation.

=item C<timeLimit>

The time limit.

=back

=head2 CLASS C<Opus10::Simulation::Event>

=head3 Base Classes

=over

=item C<Opus10::Association>

=back

Represents an event in the M/M/1 queue simulation.

=head3 METHOD C<getTime>

Returns the time of this event.

=head4 Parameters

=over

=item C<self>

This event.

=back

=head4 Return

The time.

=head3 METHOD C<getType>

Returns the type of this event.

=head4 Parameters

=over

=item C<self>

This event.

=back

=head4 Return

The type.

=head3 METHOD C<initialize>

Initializes this event.
Initializes this event with the given type and time.

=head4 Parameters

=over

=item C<type>

The type of the event.

=item C<time>

The time of the event.

=back

=head3 METHOD C<toString>

Returns a string representation of this event.

=head4 Parameters

=over

=item C<self>

This event.

=back

=head4 Return

A string.

=cut

