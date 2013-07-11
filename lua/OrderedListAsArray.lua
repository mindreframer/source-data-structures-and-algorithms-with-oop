#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: OrderedListAsArray.lua,v $
    $Revision: 1.8 $

    $Id: OrderedListAsArray.lua,v 1.8 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "OrderedList"
require "Array"
require "Cursor"

--{
-- An ordered list implemented using an array.
OrderedListAsArray = Class.new("OrderedListAsArray", OrderedList)

-- Constructs an ordered list with the given size.
-- @param +size+:: The size of the list.
function OrderedListAsArray.methods:initialize(size)
    OrderedListAsArray.super(self)
    self.array = Array.new(size)
end

-- The array.
OrderedListAsArray:attr_reader("array")

-- The number of items in this list.
OrderedListAsArray:attr_accessor("count")
--}>a

--{
-- Inserts the given object into this ordered list (at the end of the list).
-- @param obj The object to insert.
function OrderedListAsArray.methods:insert(obj)
    assert( self.count ~= self.array:get_length(),
	    "ContainerFull")
    self.array[self.count] = obj
    self.count = self.count + 1
end
--}>b

--{
-- True if the given object is in this ordered list.
-- @param obj An object.
function OrderedListAsArray.methods:contains(obj)
    for i = 0, self.count - 1 do
	if self.array[i]:is(obj) then
	    return true
	end
    end
    return false
end

-- Returns an object in this ordered list that is equal to the given object.
-- @param obj An object.
function OrderedListAsArray.methods:find(obj)
    for i = 0, self.count - 1 do
	if self.array[i] == obj then
	    return self.array[i]
	end
    end
    return nil
end
--}>c

--{
-- Withdraws the given object from this ordered list.
-- @param Obj The object to withdraw.
function OrderedListAsArray.methods:withdraw(obj)
    assert(self.count ~= 0, "ContainerEmpty")
    local i = 0
    while i < self.count and self.array[i]:is_not(obj) do
	i = i + 1
    end
    assert(i ~= self.count, "ArgumentError")
    while i < self.count - 1 do
	self.array[i] = self.array[i + 1]
	i = i + 1
    end
    self.array[i] = nil
    self.count = self.count - 1
end
--}>d

--{
-- Returns a cursor that represents the position in this list
-- of an object equal to the given object.
-- +obj+:: An object.
function OrderedListAsArray.methods:findPosition(obj)
    local i = 0
    while i < self.count and not self.array[i] == obj do
	i = i + 1
    end
    return OrderedListAsArray.Cursor.new(self, i)
end

-- Returns the object in this list at the given offset.
-- @param offset An offset.
function OrderedListAsArray.methods:getitem(offset)
    if offset < 0 or offset >= self.count then
	error "IndexError"
    end
    return self.array[offset]
end
--}>e

--{
-- Represents a position in this list.
OrderedListAsArray.Cursor =
    Class.new("OrderedListAsArray.Cursor", Cursor)

-- Inserts the given object in the is after this position.
-- +obj+:: The object to insert.
function OrderedListAsArray.Cursor.methods:insertAfter(obj)
    if self.offset < 0 or self.offset >= self.list.count then
	error "IndexError"
    end
    if self.list.count == self.list.array:get_length() then
	error "ContainerFull"
    end
    local insertPosition = self.offset + 1
    local i = self.list.count
    while i > insertPosition do
	self.list.array[i] = self.list.array[i - 1]
	i = i - 1
    end
    self.list.array[insertPosition] = obj
    self.list.count = self.list.count + 1
end
--}>f

----{
--++
-- Withdraws from the list the object at this position.
function OrderedListAsArray.Cursor.methods:withdraw()
    if self.offset < 0 or self.offset >= self.list.count then
	error "IndexError"
    end
    if self.list.count == 0 then
	error "ContainerEmpty"
    end
    local i = self.offset
    while i < self.list.count - 1 do
	self.list.array[i] = self.list.array[i + 1]
	i = i + 1
    end
    self.list.array[i] = nil
    self.list.count = self.list.count - 1
end
--}>g

--{
-- Constructs a cursor that represents the position
-- in the given list at the given offset.
-- @param list An ordered list.
-- @param offset An offset.
function OrderedListAsArray.Cursor.methods:initialize(
						    list, offset)
    OrderedListAsArray.Cursor.super(self)
    self.list = list
    self.offset = offset
end

-- Returns the object at this position.
function OrderedListAsArray.Cursor.methods:get_datum()
    if self.offset < 0 or self.offset >= self.list.count then
	error "IndexError"
    end
    return self.list[self.offset]
end
--}>h

-- Inserts the given object in the list before this position.
-- +obj+:: The object to insert.
function OrderedListAsArray.Cursor.methods:insertBefore(obj)
    if self.offset < 0 or self.offset >= self.list.count then
	error "IndexError"
    end
    if self.list.count == self.list.array:get_length() then
	error "ContainerFull"
    end
    local insertPosition = self.offset
    local i = self.list.count
    while i > insertPosition do
	self.list.array[i] = self.list.array[i - 1]
	i = i - 1
    end
    self.list.array[insertPosition] = obj
    self.list.count = self.list.count + 1
    self.offset = self.offset + 1
end

-- Purges this list.
function OrderedListAsArray.methods:purge()
    while self.count > 0 do
	self.count = self.count - 1
	self.array[self.count] = nil
    end
end

-- True if this list is full.
function OrderedListAsArray.methods:is_full()
    return self.count == self.array.length
end

-- Calls the given visitor method
-- for each object in this ordered list.
function OrderedListAsArray.methods:each(visitor)
    for i = 0, self.count - 1 do
	visitor(self.array[i])
    end
end

-- Returns an iterator that enumerates
-- the object in this ordered list.
function OrderedListAsArray.methods:iter()
    local position = 0 -- Iterator state
    return
	function()
	    local result = nil
	    if position < self.count then
		result = self.array[position]
		position = position + 1
	    end
	    return result
	end
end

-- Ordered list test program.
-- @parma arg Command-line arguments.
function OrderedListAsArray.main(arg)
    print "OrderedListAsArray test program."
    local list = OrderedListAsArray.new(10)
    OrderedList.test(list)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( OrderedListAsArray.main(arg) )
end
