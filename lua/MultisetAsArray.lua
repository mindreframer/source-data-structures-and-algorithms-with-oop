#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 12:59:04 $
    $RCSfile: MultisetAsArray.lua,v $
    $Revision: 1.1 $

    $Id: MultisetAsArray.lua,v 1.1 2004/11/27 12:59:04 brpreiss Exp $

--]]

require "Multiset"
require "Array"

--{
-- Multiset implemented using an array of counters.
MultisetAsArray = Class.new("MultisetAsArray", Multiset)

-- Constructs a multiset with the given universe size.
-- @param n The size of the universal set.
function MultisetAsArray.methods:initialize(n)
    MultisetAsArray.super(self, n)
    self.array = Array.new(self.universeSize)
    for item = 0, self.universeSize - 1 do
	self.array[item] = 0
    end
end

-- The array.
MultisetAsArray:attr_accessor("array")
--}>a

--{
-- Inserts the given item into this multiset.
-- @param item An integer.
function MultisetAsArray.methods:insert(item)
    self.array[item] = self.array[item] + 1
end

-- Withdraws the given item from this multiset.
-- @param item An integer.
function MultisetAsArray.methods:withdraw(item)
    if self.array[item] == 0 then
	error "ArgumentEerror"
    end
    self.array[item] = self.array[item] - 1
end

-- True if the given item is in this multiset.
-- @param item An integer.
function MultisetAsArray.methods:contains(item)
    return self.array[item] > 0
end
--}>b

--{
-- Multiset union operator.
-- Returns the union of this multiset and the given multiset.
-- @param set The multiset to add to this multiset.
function MultisetAsArray.methods:add(set)
    assert(set:is_a(MultisetAsArray))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	result.array[i] = self.array[i] + set.array[i]
    end
    return result
end

-- Multiset intersection operator.
-- Returns the intersection of this multiset and the given multiset.
-- @param set The multiset to intersect with this multiset.
function MultisetAsArray.methods:mul(set)
    assert(set:is_a(MultisetAsArray))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	result.array[i] = math.min(self.array[i], set.array[i])
    end
    return result
end

-- Multiset difference operator.
-- Returns the difference of this multiset and the given multiset.
-- @param set The multiset to subtract from this multiset.
function MultisetAsArray.methods:sub(set)
    assert(set:is_a(MultisetAsArray))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsArray.new(self.universeSize)
    for i = 0, self.universeSize - 1 do
	if set.array[i] <= self.array[i] then
	    result.array[i] = self.array[i] - set.array[i]
	end
    end
    return result
end
--}>c

-- Multiset equality operator.
-- Returns true if this multiset equals the given multiset.
-- @param set The multiset to compare with this multiset.
function MultisetAsArray.methods:eq(set)
    assert(set:is_a(MultisetAsArray))
    assert(self.universeSize == set.universeSize)
    for item = 0, self.universeSize - 1 do
	if self.array[item] ~= set.array[item] then
	    return false
	end
    end
    return true
end

-- Subset operator.
-- Returns true if this multiset is a subset of the given multiset.
-- @param set The multiset to compare with this multiset.
function MultisetAsArray.methods:le(set)
    assert(set:is_a(MultisetAsArray))
    assert(self.universeSize == set.universeSize)
    for item = 0, self.universeSize - 1 do
	if self.array[item] <= set.array[item] then
	    return false
	end
    end
    return true
end

-- Purges this multiset.
function MultisetAsArray.methods:purge()
    for item = 0, self.universeSize - 1 do
	self.array[item] = 0
    end
end

-- The number of items in this multiset.
function MultisetAsArray.methods:get_count()
    local result = 0
    for item = 0, self.universeSize - 1 do
	result = result + self.array[item]
    end
    return result
end

-- Calls the given visitor function for each item in this multiset.
-- @param visitor A visitor function.
function MultisetAsArray.methods:each(visitor)
    for item = 0, self.universeSize - 1 do
	for i = 1, self.array[item] do
	    visitor(item)
	end
    end
end

-- Returns an iterator that enumerates the items of a multiset.
function MultisetAsArray.methods:iter()
    local count = 0 -- Iterator state.
    local item = 0 -- Iterator state.
    while item < self.universeSize do
	if self.array[item] > 0 then
	    break
	end
	item = item + 1
    end
    return
	function()
	    local result = nil
	    if item < self.universeSize then
		result = item
		count = count + 1
		if count == self.array[item] then
		    count = 0
		    item = item + 1
		    while item < self.universeSize do
			if self.array[item] > 0 then
			    break
			end
			item = item + 1
		    end
		end
	    end
	    return result
	end
end

-- MultisetAsArray test program.
-- @param arg Command-line arguments.
function MultisetAsArray.main(arg)
    print "MultisetAsArray test program."
    print(MultisetAsArray)
    Multiset.test(MultisetAsArray.new(32),
	MultisetAsArray.new(32), MultisetAsArray.new(32))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( MultisetAsArray.main(arg) )
end
