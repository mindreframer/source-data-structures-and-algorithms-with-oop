#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: Simulation.lua,v $
    $Revision: 1.2 $

    $Id: Simulation.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "LeftistHeap"
require "Association"
require "ExponentialRV"

--{
-- A discrete-event simulation of an M/M/1 queue.
Simulation = Class.new("Simulation")

-- Constructor
function Simulation.methods:initialize()
    Simulation.super(self)
    self.eventList = LeftistHeap.new()
    self.serverBusy = false
    self.numberInQueue = 0
    self.serviceTime = ExponentialRV.new(100.0)
    self.interArrivalTime = ExponentialRV.new(100.0)
end

-- Runs the simulation up to the specified time.
-- @param timeLimit The time limit.
function Simulation.methods:run(timeLimit)
    self.eventList:enqueue(
	Simulation.Event.new(Simulation.Event.ARRIVAL, 0))
    while not self.eventList:is_empty() do
	local evt = self.eventList:dequeueMin()
	t = evt:get_time()
	if t > timeLimit then
	    self.eventList:purge()
	    break
	end
--<
	print(evt)
-->
	if evt:get_category() == Simulation.Event.ARRIVAL then
	    if not self.serverBusy then
		self.serverBusy = true
		self.eventList:enqueue(Simulation.Event.new(
		    Simulation.Event.DEPARTURE,
		    t + self.serviceTime:next()))
	    else
		self.numberInQueue = self.numberInQueue + 1
	    end
	    self.eventList:enqueue(
		Simulation.Event.new(Simulation.Event.ARRIVAL,
		    t + self.interArrivalTime:next()))
	elseif evt:get_category() ==
				Simulation.Event.DEPARTURE then
	    if self.numberInQueue == 0 then
		self.serverBusy = false
	    else
		self.numberInQueue = self.numberInQueue - 1
		self.eventList:enqueue(
		    Simulation.Event.new(
			Simulation.Event.DEPARTURE,
			t + self.serviceTime:next()))
	    end
	end
    end
end
--}>a

--{
-- Represents an event in the M/M/1 queue simulation.
Simulation.Event = Class.new("Simulation.Event", Association)

-- Arrival of a customer.
Simulation.Event.ARRIVAL = 1
-- Departure of a customer.
Simulation.Event.DEPARTURE = 2

-- Constructs an event with the given type and time.
-- @param category The type of the event.
-- @param time The time of the event.
function Simulation.Event.methods:initialize(category, time)
    Simulation.Event.super(self, time, category)
end

function Simulation.Event.methods:get_time()
    return unbox(self:get_key())
end

function Simulation.Event.methods:get_category()
    return unbox(self:get_value())
end
--}>b

-- Returns a string representation of this event.
function Simulation.Event.methods:toString()
    if self:get_category() == Simulation.Event.ARRIVAL then
	return "Event {" .. tostring(self:get_time()) ..
						", arrival}"
    elseif self:get_category() == Simulation.Event.DEPARTURE then
	return "Event {" .. tostring(self:get_time()) ..
						", departure}"
    end
end
