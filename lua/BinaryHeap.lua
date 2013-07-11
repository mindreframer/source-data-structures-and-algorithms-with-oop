#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 20:42:45 $
    $RCSfile: BinaryHeap.lua,v $
    $Revision: 1.1 $

    $Id: BinaryHeap.lua,v 1.1 2004/11/26 20:42:45 brpreiss Exp $

--]]

require "PriorityQueue"
require "Array"

--{
-- Priority queue implemented using a binary heap.
BinaryHeap = Class.new("BinaryHeap", PriorityQueue)

-- Constructs a binary heap with the given size.
-- @param length The size of the binary heap.
function BinaryHeap.methods:initialize(length)
    BinaryHeap.super(self)
    self.array = Array.new(length, 1) -- Base index is 1.
end

-- Purges this binary heap.
function BinaryHeap.methods:purge()
    while self.count > 0 do
	self.array[self.count] = nil
	self.count = self.count - 1
    end
end
--}>a

--{
-- Enqueues the given object in this binary heap.
-- @param obj An object.
function BinaryHeap.methods:enqueue(obj)
    if self.count == self.array:get_length() then
	error "ContainerFull"
    end
    self.count = self.count + 1
    local i = self.count
    while i > 1 and self.array[math.floor(i / 2)] > obj do
	self.array[i] = self.array[math.floor(i / 2)]
	i = math.floor(i / 2)
    end
    self.array[i] = obj
end
--}>b

--{
-- The smallest value in this binary heap.
function BinaryHeap.methods:get_min()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    return self.array[1]
end
--}>c

--{
-- Dequeues and returns the smallest value in this binary heap.
function BinaryHeap.methods:dequeueMin()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local result = self.array[1]
    local last = self.array[self.count]
    self.count = self.count - 1
    local i = 1
    while 2 * i < self.count + 1 do
	local child = 2 * i
	if child + 1 < self.count + 1 and
		self.array[child + 1] < self.array[child] then
	    child = child + 1
	end
	if last <= self.array[child] then
	    break
	end
	self.array[i] = self.array[child]
	i = child
    end
    self.array[i] = last
    return result
end
--}>d

-- True if this binary heap is full.
function BinaryHeap.methods:is_full()
    return self.count == self.array:get_length() - 1
end

-- Calls the given visitor function for each object in this binary heap.
-- @param visitor A visitor function.
function BinaryHeap.methods:each(visitor)
    for i = 1, self.count do
	visitor(self.array[i])
    end
end

-- Returns an iterator that enumerates the elements of this binary heap.
function BinaryHeap.methods:iter()
    local position = 1 -- Iterator state.
    return
	function()
	    local result = nil
	    if position <= self.count then
		result = self.array[position]
		position = position + 1
	    end
	    return result
	end
end

-- BinaryHeap test program.
-- @param arg Command-line arguments.
function BinaryHeap.main(arg)
    print "BinaryHeap test program."
    print(BinaryHeap)
    local pqueue = BinaryHeap.new(256)
    PriorityQueue.test(pqueue)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BinaryHeap.main(arg) )
end
