#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: OrderedListAsLinkedList.lua,v $
    $Revision: 1.6 $

    $Id: OrderedListAsLinkedList.lua,v 1.6 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "OrderedList"
require "LinkedList"
require "Cursor"

--{
-- An ordered list implemented using a linked list.
OrderedListAsLinkedList =
    Class.new("OrderedListAsLinkedList", OrderedList)

-- Constructor.
function OrderedListAsLinkedList.methods:initialize()
    OrderedListAsLinkedList.super(self)
    self.linkedList = LinkedList.new()
end

-- The linked list.
OrderedListAsLinkedList:attr_reader("linkedList")

-- The number of objects in this list.
OrderedListAsLinkedList:attr_accessor("count")
--}>a

--{
-- Inserts the given object in this ordered list
-- (at the end of the list).
-- @param obj The object to insert.
function OrderedListAsLinkedList.methods:insert(obj)
    self.linkedList:append(obj)
    self.count = self.count + 1
end

-- Returns the object in this list at the given offset.
-- @param offset An offset.
function OrderedListAsLinkedList.methods:getitem(offset)
    assert(offset >= 0 and offset < self.count, "IndexError")
    local ptr = self.linkedList:get_head()
    local i = 0
    while i < offset and ptr do
	ptr = ptr:get_succ()
	i = i + 1
    end
    return ptr:get_datum()
end
--}>b

--{
-- True if the given object is in this ordered list.
-- @param obj An object.
function OrderedListAsLinkedList.methods:contains(obj)
    local ptr = self.linkedList:get_head()
    while ptr do
	if ptr.datum:is(obj) then
	    return true
	end
	ptr = ptr:get_succ()
    end
    return false
end

-- Returns the object in this ordered list
-- that is equal to the given object.
-- @param obj An object.
function OrderedListAsLinkedList.methods:find(arg)
    local ptr = self.linkedList:get_head()
    while ptr do
	if ptr:get_datum() == arg then
	    return ptr:get_datum()
	end
	ptr = ptr:get_succ()
    end
    return nil
end
--}>c

--{
-- Withdraws the given object from this ordered list.
-- @param obj The object to withdraw.
function OrderedListAsLinkedList.methods:withdraw(obj)
    assert(self.count ~= 0, "ContainerEmpty")
    self.linkedList:extract(obj)
    self.count = self.count - 1
end
--}>d

--{
-- Returns a cursor that represents the position in this list
-- of the object that is equal to the given object.
-- +obj+:: An object.
function OrderedListAsLinkedList.methods:findPosition(obj)
    local ptr = self.linkedList:get_head()
    while ptr do
	if ptr:get_datum() == obj then
	    break
	end
	ptr = ptr:get_succ()
    end
    return OrderedListAsLinkedList.Cursor.new(self, ptr)
end
--}>e

--{
-- Represents a position in an ordered list.
OrderedListAsLinkedList.Cursor =
    Class.new("OrderedListAsLinkedList.Cursor", Cursor)

-- Inserts the given object in the ordered list
-- after this position.
-- +obj+:: The object to insert.
function OrderedListAsLinkedList.Cursor.methods:insertAfter(obj)
    self.element:insertAfter(obj)
    self.list.count = self.list.count + 1
end
--}>f

--{
-- Withdraws the object in the ordered list at this position.
function OrderedListAsLinkedList.Cursor.methods:withdraw()
    self.list.linkedList:extract(self.element:get_datum())
    self.list.count = self.list.count - 1
end
--}>g

--{
-- Constructs a cursor that represents the position
-- in the given list of the given list element.
-- +list+:: An ordered list.
-- +element+:: A linked list element.
function OrderedListAsLinkedList.Cursor.methods:initialize(
						list, element)
    OrderedListAsLinkedList.Cursor.super(self)
    self.list = list
    self.element = element
end

-- Returns the object in the ordered list at this position.
function OrderedListAsLinkedList.Cursor.methods:get_datum()
    self.element.get_datum()
end
--}>h

-- Inserts the given object in the ordered list
-- before this position.
-- +obj+:: The object to insert.
function OrderedListAsLinkedList.Cursor.methods:insertBefore(obj)
    self.element:insertBefore(obj)
    self.list.count = self.list.count + 1
end

-- Purges this ordered list.
function OrderedListAsLinkedList.methods:purge()
    self.linkedList = LinkedList.new()
    self.count = 0
end

-- Calls the given visitor function
-- for each object in this ordered list.
-- @para visitor A visitor function.
function OrderedListAsLinkedList.methods:each(visitor)
    self.linkedList:each(visitor)
end

-- Returns an iterator that enumerates
-- the objects in an ordered list.
function OrderedListAsLinkedList.methods:iter()
    local position = self.linkedList:get_head() -- Iterator state
    return
	function()
	    local result = nil
	    if position then
		result = position:get_datum()
		position = position:get_succ()
	    end
	    return result
	end
end

-- OrderedListAsLinkedList test program."
-- @param arg Command-line arguments.
function OrderedListAsLinkedList.main(arg)
    print "OrderedListAsLinkedList test program."
    local list = OrderedListAsLinkedList.new()
    OrderedList.test(list)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( OrderedListAsLinkedList.main(arg) )
end
