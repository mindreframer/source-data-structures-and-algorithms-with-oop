#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: SetAsBitVector.lua,v $
    $Revision: 1.2 $

    $Id: SetAsBitVector.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Set"
require "Array"
require "Integer"

--{
-- Set implemented using a bit vector.
SetAsBitVector = Class.new("SetAsBitVector", Set)

-- Constructs a set with the given universe size.
-- @param n The size of the universal set.
function SetAsBitVector.methods:initialize(n)
    SetAsBitVector.super(self, n)
    self.vector = Array.new(
	    (toint(n) + Integer.BITS - toint(1)) / Integer.BITS)
    for i = 0, self.vector:get_length() - 1 do
	self.vector[i] = toint(0)
    end
end

-- The bit vector.
SetAsBitVector:attr_accessor("vector")
--}>a

--{
-- Inserts the given item into this set.
-- @param item An integer.
function SetAsBitVector.methods:insert(item)
    item = toint(item)
    self.vector[item / Integer.BITS] = 
	self.vector[item / Integer.BITS]:OR(
	    toint(1):lshift(item:mod(Integer.BITS)))
end

-- Withdraws the given item from this set.
-- @param item An integer.
function SetAsBitVector.methods:withdraw(item)
    item = toint(item)
    self.vector[item / Integer.BITS] =
	self.vector[item / Integer.BITS]:AND(
	    (toint(1):lshift(item:mod(Integer.BITS))):NOT() )
end

-- True if the given item is in this set.
-- @param item An integer.
function SetAsBitVector.methods:contains(item)
    item = toint(item)
    return (self.vector[toint(item) / Integer.BITS]:AND(
	(toint(1):lshift(item:mod(Integer.BITS))))) ~= toint(0)
end
--}>b

--{

-- Set union operator.
-- Returns the union of this set and the given set.
-- @param set The set to add to this set.
function SetAsBitVector.methods:add(set)
    assert(set:is_a(SetAsBitVector), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    local result = SetAsBitVector.new(self.universeSize)
    for i = 0, self.vector:get_length() - 1 do
	result.vector[i] = self.vector[i]:OR(set.vector[i])
    end
    return result
end

-- Set intersection operator.
-- Returns the intersection of this set and the given set.
-- @param set The set to intersect with this set.
function SetAsBitVector.methods:mul(set)
    assert(set:is_a(SetAsBitVector), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    local result = SetAsBitVector.new(self.universeSize)
    for i = 0, self.vector:get_length() - 1 do
	result.vector[i] = self.vector[i]:AND(set.vector[i])
    end
    return result
end

-- Set difference operator.
-- Returns the difference of this set and the given set.
-- @param set The set to subtract from this set.
function SetAsBitVector.methods:sub(set)
    assert(set:is_a(SetAsBitVector), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    local result = SetAsBitVector.new(self.universeSize)
    for i = 0, self.vector:get_length() - 1 do
	result.vector[i] =
			self.vector[i]:AND(set.vector[i]:NOT())
    end
    return result
end
--}>c

-- Set equality operator.
-- Returns true if this set equals the given set.
-- @param set The set to compare with this set.
function SetAsBitVector.methods:eq(set)
    assert(set:is_a(SetAsBitVector), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    for i = 0, self.vector:get_length() - 1 do
	if self.vector[i] ~= set.vector[i] then
	    return false
	end
    end
    return true
end

-- Subset operator.
-- Returns true if this set is a subset of the given set.
-- @param set The set to compare with this set.
function SetAsBitVector.methods:le(set)
    assert(set:is_a(SetAsBitVector), "TypeError")
    assert(self.universeSize == set.universeSize, "DomainError")
    for i = 0, self.vector:get_length() - 1 do
	if (self.vector[i]:AND(set.vector[i]:NOT())) ~= toint(0) then
	    return false
	end
    end
    return true
end

-- True if this set is empty.
function SetAsBitVector.methods:is_empty()
    for item = 0, self.vector:get_length() - 1 do
	if self.vector[i] ~= toint(0) then
	    return false
	end
    end
    return true
end

-- True if this set is full.
function SetAsBitVector.methods:is_full()
    for item = 0, self.vector:get_length() - 1 do
	if self.vector[i] ~= toint(-1) then
	    return false
	end
    end
    return true
end

-- Purges this set.
function SetAsBitVector.methods:purge()
    for i = 0, self.vector:get_length() - 1 do
	self.vector[i] = toint(0)
    end
end

-- Calls the given visitor method for each item in this set.
-- @param visitor A visitor function.
function SetAsBitVector.methods:each(visitor)
    for item = 0, self.universeSize - 1 do
	if self:contains(item) then
	    visitor(item)
	end
    end
end

-- The number of items in this set.
function SetAsBitVector.methods:get_count()
    local result = 0
    for item = 0, self.universeSize - 1 do
	if self:contains(item) then
	    result = result + 1
	end
    end
    return result
end

-- SetAsBitVector test program.
-- @param arg Command-line arguments.
function SetAsBitVector.main(arg)
    print "SetAsBitVector test program."
    Set.test(
	SetAsBitVector.new(57),
	SetAsBitVector.new(57),
	SetAsBitVector.new(57))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SetAsBitVector.main(arg) )
end
