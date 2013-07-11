#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 01:17:12 $
    $RCSfile: SetAsArray.lua,v $
    $Revision: 1.1 $

    $Id: SetAsArray.lua,v 1.1 2004/11/27 01:17:12 brpreiss Exp $

--]]

require "Set"
require "Array"

--{
-- Set implemented using an array of boolean values.
SetAsArray = Class.new("SetAsArray", Set)

-- Constructs a set with the given universe size.
-- @param n The universe size.
function SetAsArray.methods:initialize(n)
    SetAsArray.super(self, n)
    self.array = Array.new(self.universeSize)
    for item = 0, self.universeSize - 1 do
	self.array[item] = false
    end
end

-- The array.
SetAsArray:attr_accessor("array")
--}>a

--{
-- Inserts the given item into this set.
-- @param item An integer.
function SetAsArray.methods:insert(item)
    self.array[item] = true
end

-- True if the given item is in this set.
-- @param item An integer.
function SetAsArray.methods:contains(item)
    return self.array[item]
end

-- Withdraws the given item from this set.
-- @param item An integer.
function SetAsArray.methods:withdraw(item)
    self.array[item] = false
end
--}>b

--{
-- Set union operator.
-- Returns the union of this set and the given set.
-- @param set The set to add to this set.
function SetAsArray.methods:add(set)
    assert(set:is_a(SetAsArray), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    local result = SetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	result.array[i] = (self.array[i] or set.array[i])
    end
    return result
end

-- Set intersection operator.
-- Returns the intersection of this set and the given set.
-- @param set The set to intersect with this set.
function SetAsArray.methods:mul(set)
    assert(set:is_a(SetAsArray), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    local result = SetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	result.array[i] = (self.array[i] and set.array[i])
    end
    return result
end

-- Set difference operator.
-- Returns the difference of this set and the given set.
-- @param set The set to subtract from this set.
function SetAsArray.methods:sub(set)
    assert(set:is_a(SetAsArray), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    result = SetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	result.array[i] = (self.array[i] and not set.array[i])
    end
    return result
end
--}>c

--{
-- Set equality operator.
-- Returns true if this set equals the given set.
-- @param set The set to compare with this set.
function SetAsArray.methods:eq(set)
    assert(set:is_a(SetAsArray), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    for i = 0, self.universeSize - 1 do
	if self.array[i] ~= set.array[i] then
	    return false
	end
    end
    return true
end

-- Subset operator.
-- Returns true if this set is a subset of the given set.
-- +set+:: The set to compare with this set.
function SetAsArray.methods:le(set)
    assert(set:is_a(SetAsArray), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    for i = 0, self.universeSize - 1 do
	if self_array[i] and not set.array[i] then
	    return false
	end
    end
    return true
end
--}>d
--++

-- True if this set is empty.
function SetAsArray.methods:is_empty()
    for item = 0, self.universeSize - 1 do
	if self:contains(item) then
	    return false
	end
    end
    return true
end

-- True if this set is full.
function SetAsArray.methods:is_full()
    for item = 0, self.universeSize - 1 do
	if not self:contains(item) then
	    return false
	end
    end
    return true
end

-- Purges this set.
function SetAsArray.methods:purge()
    for item = 0, self.universeSize - 1 do
	self.array[item] = false
    end
end

-- Yields the items in this set.
-- Calls the given visitor function for each object in this set.
-- @param visitor A visitor method.
function SetAsArray.methods:each(visitor)
    for item = 0, self.universeSize - 1 do
	if self:contains(item) then
	    visitor(item)
	end
    end
end

-- The number of items in this set.
function SetAsArray.methods:get_count()
    local result = 0
    for item in 0, self.universeSize - 1 do
	if self:contains(item) then
	    result = result + 1
	end
    end
    return result
end

-- SetAsArray test program.
-- @param arg Command-line arguments.
function SetAsArray.main(arg)
    print "SetAsArray test program."
    print(SetAsArray)
    Set.test(SetAsArray.new(32), SetAsArray.new(32), SetAsArray.new(32))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SetAsArray.main(arg) )
end
