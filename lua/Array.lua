#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 16:50:11 $
    $RCSfile: Array.lua,v $
    $Revision: 1.10 $

    $Id: Array.lua,v 1.10 2004/12/05 16:50:11 brpreiss Exp $

--]]

require "Class"

--{
-- An array class.
Array = Class.new("Array")

-- Initialize this array.
-- The first argument is either a Lua array of values
-- or the desired array length.
-- @param arg1 The first argument.
-- @param baseIndex The base index.
function Array.methods:initialize(arg1, baseIndex)
    Array.super(self)
    if type(arg1) == "table" then
	self.length = table.getn(arg1)
	self.baseIndex = tonumber(baseIndex) or 0
	self.array = {}
	for i = 0, self.length - 1 do
	    self.array[i] = arg1[i + 1]
	end
    else
	self.length = tonumber(arg1)
	self.baseIndex = tonumber(baseIndex) or 0
	self.array = {}
	for i = 0, self.length - 1 do
	    self.array[i] = nil
	end
    end
end

-- The array length.
Array:attr_reader("length")

-- The base index.
Array:attr_accessor("baseIndex")
--}>a

--{
-- Returns the offset in the array for the given index.
function Array.methods:getOffset(index)
    assert( index >= self.baseIndex and
	    index < self.baseIndex + self.length, "IndexError")
    return index - self.baseIndex
end

-- Returns the item in the array at the given index.
function Array.methods:getitem(index)
    return self.array[self:getOffset(tonumber(index))]
end

-- Sets the item in the array at the given index
-- to the given value.
function Array.methods:setitem(index, value)
    self.array[self:getOffset(tonumber(index))] = value
end
--}>b

--{
-- Sets the length of this array to the given value.
function Array.methods:set_length(value)
    if value > self.length then
	for i = self.length, value - 1 do
	    table.insert(self.array, nil)
	end
	self.length = value
    elseif value < self.length then
	for i = self.length - 1, value, -1 do
	    table.remove(self.array)
	end
	self.length = value
    end
end
--}>c

-- Returns a clone of this array.
function Array.methods:clone()
    local obj = Object.clone(self)
    obj.array = {}
    for i = 0, self.length - 1 do
	obj.array[i] = self.array[i]
    end
    return obj
end

-- Returns a string representation of this array.
function Array.methods:toString()
    local result = "Array{baseIndex=" .. self.baseIndex
    for i = 0, self.length - 1 do
	result = result .. ", " .. (self.array[i] or "nil")
    end
    result = result .. "}"
    return result
end

-- Array class test program.
-- @param arg Command-line arguments.
function Array.main(arg)
    print "Array test program"
    a1 = Array.new(3)
    print("a1 = ", a1)
    a1[0] = 2
    a1[1] = a1[0] + 2
    a1[2] = a1[1] + 2
    print("a1 = ", a1)
    print("baseIndex = ", a1:get_baseIndex())
    print("length = ", a1:get_length())
    a2 = Array.new(2, 10)
    a2[10] = 57
    print("a2 = ", a2)
    print("baseIndex = ", a2:get_baseIndex())
    print("length = ", a2:get_length())
    a2:set_length(5)
    print("a2 = ", a2)
    print("length = ", a2:get_length())
    a2:set_length(2)
    print("a2 = ", a2)
    print("length = ", a2:get_length())
    a3 = a2:clone()
    print("a3 = ", a3)
end

if _REQUIREDNAME == nil then
    os.exit( Array.main(arg) )
end
