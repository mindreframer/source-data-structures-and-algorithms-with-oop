#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: QueueAsArray.lua,v $
    $Revision: 1.7 $

    $Id: QueueAsArray.lua,v 1.7 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Queue"
require "Array"

--{
-- Queue implemented using an array.
QueueAsArray = Class.new("QueueAsArray", Queue)

-- Constructs a queue with the given size.
-- self.param size The size of the queue.
function QueueAsArray.methods:initialize(size)
    QueueAsArray.super(self)
    self.array = Array.new(size)
    self.headPos = 0
    self.tailPos = size - 1
end

-- Purges this queue.
function QueueAsArray.methods:purge()
    while self.count > 0 do
	self.array[self.headPos] = nil
	self.headPos = self.headPos + 1
	if self.headPos == self.array.length then
	    self.headPos = 0
	end
	self.count = self.count - 1
    end
end
--}>a

--{
-- The head of the queue.
function QueueAsArray.methods:get_head()
    assert(self.count ~= 0, "ContainerEmpty")
    return self.array[self.headPos]
end

-- Enqueues the given object in this queue.
-- @param obj An object.
function QueueAsArray.methods:enqueue(obj)
    assert( self.count ~= self.array:get_length(),
	    "ContainerFull")
    self.tailPos = self.tailPos + 1
    if self.tailPos == self.array:get_length() then
	self.tailPos = 0
    end
    self.array[self.tailPos] = obj
    self.count = self.count + 1
end

-- Dequeues and returns the object at the head of this queue.
function QueueAsArray.methods:dequeue()
    assert(self.count ~= 0, "ContainerEmpty")
    local result = self.array[self.headPos]
    self.array[self.headPos] = nil
    self.headPos = self.headPos + 1
    if self.headPos == self.array:get_length() then
	self.headPos = 0
    end
    self.count = self.count - 1
    return result
end
--}>b

-- True if this queue is full.
function QueueAsArray.methods:isFul()
    return self.count == self.array:get_length()
end

-- Calls the given visitor function
-- for each object in this queue.
-- @param visitor A visitor function.
function QueueAsArray.methods:each(visitor)
    local pos = self.headPos
    for i = 0, self.count - 1 do
	visitor(self.array[pos])
	pos = pos + 1
	if pos == self.array:get_length() then
	    pos = 0
	end
    end
end

-- Iterator that enumerates the objects in a queue.
function QueueAsArray.methods:iter()
    local position = 0 -- Iterator state.
    return
	function()
	    local result = nil
	    if position < self.count then
		result = self.array[
			math.mod(self.headPos + position,
				    self.array:get_length())]
		position = position + 1
	    end
	    return result
	end
end

-- QueueAsArray test program.
-- @param arg Command-line arguments.
function QueueAsArray.main(arg)
    print "QueueAsArray test program."
    local queue1 = QueueAsArray.new(5)
    Queue.test(queue1)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( QueueAsArray.main(arg) )
end
