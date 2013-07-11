#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:59 $
    $RCSfile: Timer.lua,v $
    $Revision: 1.1 $

    $Id: Timer.lua,v 1.1 2004/11/28 20:44:59 brpreiss Exp $

--]]

require "Class"

-- A timer for measuring the elapsed time.
Timer = Class.new("Timer")

-- Timer stopped state.
Timer.STOPPED = 1

-- Timer running state.
Timer.RUNNING = 2

-- Constructor.
function Timer.methods:initialize()
    self.startTime = os.clock()
    self.stopTime = self.startTime
    self.state = Timer.STOPPED
end

-- Starts this timer.
function Timer.methods:start()
    if self.state ~= Timer.STOPPED then
	error "StateError"
    end
    self.startTime = os.clock()
    self.state = Timer.RUNNING
end

-- Stops this timer.
function Timer.methods:stop()
    if self.state ~= Timer.RUNNING then
	error "StateError"
    end
    self.stopTime = os.clock()
    self.state = Timer.STOPPED
end

-- The elapsed time.
function Timer.methods:elapsedTime()
    if self.state == Timer.RUNNING then
	self.stopClock = os.clock()
    end
    return self.stopTime - self.startTime
end

-- Timer test program.
-- @param arg Command-line arguments.
function Timer.main(arg)
    print "Timer test program."
    local t = Timer.new()
    t:start()
    local x = 2
    for i = 1, 10000000 do
	x = x * 2
    end
    t:stop()
    print("Elapsed time",t:elapsedTime())
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Timer.main(arg) )
end
