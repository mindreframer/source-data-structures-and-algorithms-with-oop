#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 01:44:45 $
    $RCSfile: SortedListAsLinkedList.lua,v $
    $Revision: 1.6 $

    $Id: SortedListAsLinkedList.lua,v 1.6 2004/12/01 01:44:45 brpreiss Exp $

--]]

require "OrderedListAsLinkedList"
require "SortedList"

--{
-- A sorted list implemented using a linked list.
SortedListAsLinkedList =
    Class.new("SortedListAsLinkedList", OrderedListAsLinkedList)

SortedListAsLinkedList:include(SortedListMethods)

-- Constructor.
function SortedListAsLinkedList.methods:initialize()
    SortedListAsLinkedList.super(self)
end
--}>a

--{
-- Inserts the given object into this sorted list.
-- @param obj The object to insert.
function SortedListAsLinkedList.methods:insert(obj)
    local prevPtr = nil
    local ptr = self.linkedList:get_head()
    while ptr do
	if ptr:get_datum() >= obj then
	    break
	end
	prevPtr = ptr
	ptr = ptr:get_succ()
    end
    if prevPtr == nil then
	self.linkedList:prepend(obj)
    else
	prevPtr:insertAfter(obj)
    end
    self.count = self.count + 1
end
--}>b

-- Finds the linked-list element that contains an object
-- that is equal to the given object.
-- @param obj An object.
function SortedListAsLinkedList.methods:findElement(obj)
    local ptr = self.linkedList:get_head()
    while ptr do
	if ptr:get_datum() == obj then
	    return ptr
	end
	ptr = ptr:get_succ()
    end
    return nil
end

-- Represents a position in a sorted list.
SortedListAsLinkedList.Cursor =
    Class.new("SortedListAsLinkedList.Cursor", Cursor)

-- Constructs a cursor that represents the position
-- in the given list at the given linked list element.
-- @param list A sorted list.
-- @param list A linked list element.
function SortedListAsLinkedList.Cursor.methods:initiallize(list, element)
    SortedListAsLinkedList.Cursor.super(self, list, element)
end

-- Not defined for sorted lists.
SortedListAsLinkedList.Cursor:undef_method("insertAfter")

-- Not defined for sorted lists.
SortedListAsLinkedList.Cursor:undef_method("insertBefore")

-- Returns a cursor that represents the position in this sorted list
-- of an object that equals the given object.
-- @param obj An object.
function SortedListAsLinkedList.methods:findPosition(obj)
    SortedListAsLinkedList.Cursor.new(self, self:findElement(obj))
end

-- SortedListAsLinkedList test program.
-- @param arg Command-line arguments.
function SortedListAsLinkedList.main(arg)
    print "SortedListAsLinkedList test program."
    local slist = SortedListAsLinkedList.new()
    SortedList.test(slist)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SortedListAsLinkedList.main(arg) )
end
