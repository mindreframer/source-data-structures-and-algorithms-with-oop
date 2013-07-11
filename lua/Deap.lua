#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 01:56:00 $
    $RCSfile: Deap.lua,v $
    $Revision: 1.2 $

    $Id: Deap.lua,v 1.2 2004/11/27 01:56:00 brpreiss Exp $

--]]

require "DoubleEndedPriorityQueue"
require "Array"
require "Integer"

-- Double-ended priority queue implemented as a double-ended binary heap.
Deap = Class.new("Deap", DoubleEndedPriorityQueue)

-- Constructs a deap with the given size.
-- @param length The size of the deap.
function Deap.methods:initialize(length)
    Deap.super(self)
    self.array = Array.new(length + 1, 1)
end

-- Purges this deap.
function Deap.methods:purge()
    self.array = Array.new(self.array.length, 1)
    self.count = 0
end

-- Returns ceil(log_2(i)).
-- @param i A non-negative integer.
function Deap.log2(i)
    local result = toint(0)
    while toint(1):lshift(result) <= i do
	result = result + toint(1)
    end
    return result - toint(1)
end

-- Returns 2^(ceil(log_2(i))).
-- @param i A non-negative integer.
function Deap.mask(i)
    return toint(1):lshift(Deap.log2(i) - toint(1))
end

-- Returns the index of the dual of the given index.
-- @param i An index.
function Deap.methods:dual(i)
    local m = Deap.mask(i)
    local result = i:XOR(m)
    if result:AND(m) ~= toint(0) then
	if result >= toint(self.count + 2) then
	    result = result / toint(2)
	end
    else
	if toint(2) * result < toint(self.count + 2) then
	    result = result * toint(2)
	    if result + toint(1) < toint(self.count + 2)
		    and self.array[result + toint(1)] > self.array[result] then
		result = result + toint(1)
	    end
	end
    end
    return result
end

-- The smallest object in this deap.
function Deap.methods:get_min()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    return self.array[2]
end

-- The largest object in this deap.
function Deap.methods:get_max()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    if self.count == 1 then
	return self.array[2]
    else
	return self.array[3]
    end
end

-- Inserts the given object into the min-heap of this deap
-- at the given position.
-- @param pos An index in the min-heap of this deap.
-- @param obj An object.
function Deap.methods:insertMin(pos, obj)
    local i = pos
    while i > toint(2) and self.array[i / toint(2)] > obj do
	self.array[i] = self.array[i / toint(2)]
	i = i / toint(2)
    end
    self.array[i] = obj
end

-- Inserts the given object into the max-heap of this deap
-- at the given position.
-- +pos+:: An index in the max-heap of this deap.
-- +obj+:: An object.
function Deap.methods:insertMax(pos, obj)
    local i = pos
    while i > toint(3) and self.array[i / toint(2)] < obj do
	self.array[i] = self.array[i / toint(2)]
	i = i / toint(2)
    end
    self.array[i] = obj
end

-- Enqueues the given object in this deap.
-- +obj+:: The object to enqueue.
function Deap.methods:enqueue(obj)
    if self.count == self.array:get_length() - 1 then
	error "ContainerFull"
    end
    self.count = self.count + 1
    if self.count == 1 then
	self.array[2] = obj
    else
	local i = toint(self.count + 1)
	local j = self:dual(i)
	if i:AND(Deap.mask(i)) ~= toint(0) then
	    if obj >= self.array[j] then
		self:insertMax(i, obj)
	    else
		self.array[i] = self.array[j]
		self:insertMin(j, obj)
	    end
	else
	    if obj < self.array[j] then
		self:insertMin(i, obj)
	    else
		self.array[i] = self.array[j]
		self:insertMax(j, obj)
	    end
	end
    end
end

-- Dequeues and returns the smallest object in this deap.
function Deap.methods:dequeueMin()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local result = self.array[2]
    local last = self.array[self.count + 1]
    self.count = self.count - 1
    if self.count <= 1 then
	self.array[2] = last
    else
	local i = toint(2)
	while toint(2) * i < toint(self.count + 2) do
	    local child = toint(2) * i
	    if child + toint(1) < toint(self.count + 2)
		    and self.array[child + toint(1)] < self.array[child] then
		child = child + toint(1)
	    end
	    self.array[i] = self.array[child]
	    i = child
	end
	local j = self:dual(i)
	if last <= self.array[j] then
	    self:insertMin(i, last)
	else
	    self.array[i] = self.array[j]
	    self:insertMax(j, last)
	end
    end
    return result
end

-- Dequeues and returns the largest object in this deap.
function Deap.methods:dequeueMax()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    if self.count == 1 then
	self.count = self.count - 1
	return self.array[2]
    elseif self.count == 2 then
	self.count = self.count - 1
	return self.array[3]
    else
	local result = self.array[3]
	local last = self.array[self.count + 1]
	self.count = self.count - 1
	local i = toint(3)
	while toint(2) * i < toint(self.count + 2) do
	    local child = toint(2) * i
	    if child + toint(1) < toint(self.count + 2)
		    and self.array[child + toint(1)] > self.array[child] then
		child = child + toint(1)
	    end
	    self.array[i] = self.array[child]
	    i = child
	end
	local j = self:dual(i)
	if last >= self.array[j] then
	    self:insertMax(i, last)
	else
	    self.array[i] = self.array[j]
	    self:insertMin(j, last)
	end
	return result
    end
end

-- True if this deap is full.
function Deap.methods:is_full()
    return self.count == self.array.get_length() - 2
end

-- Calls the given visitor function for each object in this deap
-- (in no particular order).
-- @param visitor A visitor function.
function Deap.methods:each(visitor)
    for i = 2,  self.count + 1 do
	visitor(self.array[i])
    end
end

-- Returns an iterator that enumerates the objects in this deap
-- (in no particular order).
function Deap.methods:iter()
    local position = 2 -- Iterator state.
    return
	function()
	    local result = nil
	    if position < self:get_count() + 2 then
		result = self.array[position]
		position = position + 1
	    end
	    return result
	end
end

-- Deap test program.
-- @param arg Command-line arguments.
function Deap.main(arg)
    print "Deap test program."
    print(Deap)
    local depqueue = Deap.new(256)
    DoubleEndedPriorityQueue.test(depqueue)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Deap.main(arg) )
end
