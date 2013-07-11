#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 01:17:12 $
    $RCSfile: Set.lua,v $
    $Revision: 1.1 $

    $Id: Set.lua,v 1.1 2004/11/27 01:17:12 brpreiss Exp $

--]]

require "SearchableContainer"

--{
-- Abstract base class from which all set classes are derived.
Set = Class.new("Set", SearchableContainer)

-- Constructs a set with the given universal set size.
-- @param universeSize The size of the universal set.
function Set.methods:initialize(universeSize)
    Set.super(self)
    self.universeSize = universeSize
end

-- The size of the universal set.
Set:attr_reader("universeSize")

-- Union operator.
-- Returns the union of this set and the given set.
-- @param set A set.
Set:abstract_method("add")

-- Intersection operator.
-- Returns the intersection of this set and the given set.
-- @param set A set.
Set:abstract_method("mul")

-- Difference operator.
-- Returns the difference of this set and the given set.
-- @param set A set.
Set:abstract_method("sub")

-- Equality operator.
-- Returns true if this set equals the given set.
-- @param set A set.
Set:abstract_method("eq")

-- Subset operator.
-- Returns true if this set is a subset of the given set.
-- @param set A set.
Set:abstract_method("le")

-- Proper subset operator.
-- Returns true if this set is a proper subset of the given set.
-- @param set A set.
function Set.methods:lt(set)
    return self:le(set) and not self:eq(set)
end

-- Returns the integer i if i is contained in this set.
-- @param i An integer.
function Set.methods:find(i)
    if self:contains(i) then
	return i
    else
	return nil
    end
end
--}>a

-- Returns an iterator that enumerates the elements of a set.
function Set.methods:iter()
    local item = 0 -- Iterator state.
    while item < self.universeSize and not self:contains(item) do
	item = item + 1
    end
    return
	function()
	    local result = nil
	    if item < self.universeSize then
		result = item
		item = item + 1
		while item < self.universeSize and not self:contains(item) do
		    item = item + 1
		end
	    end
	    return result
	end
end

-- Set test program.
-- @param s1 A set to test.
-- @param s2 A set to test.
-- @param s3 A set to test.
function Set.test(s1, s2, s3)
    print "Set test program."
    for i = 0, 3 do
	s1:insert(i)
    end
    for i = 2, 5 do
	s2:insert(i)
    end
    s3:insert(0)
    s3:insert(2)
    print(s1)
    print(s2)
    print(s3)
    print(s1 + s2) -- union
    print(s1 * s3) -- intersection
    print(s1 - s3) -- difference
    print "Using each"
    s3:each(
	function(obj)
	    print(obj)
	end
    )
    print "Using Iterator"
    for obj in s3:iter() do
	print(obj)
    end
end
