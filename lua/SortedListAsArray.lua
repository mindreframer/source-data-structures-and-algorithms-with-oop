#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: SortedListAsArray.lua,v $
    $Revision: 1.6 $

    $Id: SortedListAsArray.lua,v 1.6 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "OrderedListAsArray"
require "SortedList"

--{
-- A sorted list implemented using an array.
SortedListAsArray =
    Class.new("SortedListAsArray", OrderedListAsArray)

SortedListAsArray:include(SortedListMethods)

-- Constructs a sorted list with the given size.
-- @param size The size of the sorted list.
function SortedListAsArray.methods:initialize(size)
    SortedListAsArray.super(self, size)
end
--}>a

--{
-- Inserts the given object into this sorted list.
-- @param obj The object to insert.
function SortedListAsArray.methods:insert(obj)
    assert( self.count ~= self.array:get_length(),
	    "ContainerFull")
    local i = self.count
    while i > 0 and self.array[i - 1] > obj do
	self.array[i] = self.array[i - 1]
	i = i - 1
    end
    self.array[i] = obj
    self.count = self.count + 1
end
--}>b

--{
-- Returns the offset of the object in this sorted list
-- that is equal to the given object.
-- @param obj The object to find.
function SortedListAsArray.methods:findOffset(obj)
    local left = 0
    local right = self.count - 1
    while left <= right do
	local middle = math.floor((left + right) / 2)
	if obj > self.array[middle] then
	    left = middle + 1
	elseif obj < self.array[middle] then
	    right = middle - 1
	else
	    return middle
	end
    end
    return -1
end
--}>c

--{
-- Returns the object in this sorted list
-- that is equal to the given object.
-- @param obj An object.
function SortedListAsArray.methods:find(obj)
    local offset = self:findOffset(obj)
    if offset >= 0 then
	return self.array[offset]
    else
	return nil
    end
end

-- Represents a position in a sorted list.
SortedListAsArray.Cursor = Class.new("SortedListAsArray.Cursor",
				    OrderedListAsArray.Cursor)

-- Constructs a cursor that represents the position
-- in the given list with the given offset.
-- @param list A sorted list.
-- @param offset An offset.
function SortedListAsArray.Cursor.methods:initialize(
						    list, offset)
    SortedListAsArray.Cursor.super(self, list, offset)
end

-- Not supported in sorted lists.
SortedListAsArray.Cursor:undef_method("insertAfter")

-- Not supported in sorted lists.
SortedListAsArray.Cursor:undef_method("insertBefore")

-- Returns a cursor that represents
-- the position in this sorted list
-- of an object that equals the given object.
-- +obj+:: An object.
function SortedListAsArray.methods:findPosition(obj)
    return SortedListAsArray.Cursor.new(
				    self, self:findOffset(obj))
end
--}>d

--{
-- Withdraws the given object from this sorted list.
-- +obj+:: The object to withdraw.
function SortedListAsArray.methods:withdraw(obj)
    assert(self.count ~= 0, "ContainerEmpty")
    local offset = self:findOffset(obj)
    assert(offset >= 0, "ArgumentError")
    local i = offset
    while i < self.count do
	self.array[i] = self.array[i + 1]
	i = i + 1
    end
    self.array[i] = nil
    self.count = self.count - 1
end
--}>e

-- SortedListAsArray test program.
-- +argv+:: Command-line arguments.
function SortedListAsArray.main(arg)
    print "SortedListAsArray test program."
    local slist = SortedListAsArray.new(10)
    SortedList.test(slist)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SortedListAsArray.main(arg) )
end
