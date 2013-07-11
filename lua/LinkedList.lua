#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: LinkedList.lua,v $
    $Revision: 1.7 $

    $Id: LinkedList.lua,v 1.7 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Class"

--{
-- A linked list class.
LinkedList = Class.new("LinkedList")

-- An element of a linked list.
LinkedList.Element = Class.new("LinkedList.Element", Object)

-- Constructs an element of a linked list with the given values.
-- @param list The linked list.
-- @param datum An object.
-- @param succ The next element in the list.
function LinkedList.Element.methods:initialize(list, datum, succ)
    LinkedList.Element.super(self)
    self.list = list
    self.datum = datum
    self.succ = succ
end

-- The datum.
LinkedList.Element:attr_accessor("datum")

-- The next element.
LinkedList.Element:attr_accessor("succ")
--}>a

--{
-- Constructs an empty linked list.
function LinkedList.methods:initialize()
    LinkedList.super(self)
    self.head = nil
    self.tail = nil
end
--}>b

--{
-- Purges this linked list
function LinkedList.methods:purge()
    self.head = nil
    self.tail = nil
end
--}>c

--{
-- The head of this linked list.
LinkedList:attr_accessor("head")

-- The tail of this linked list.
LinkedList:attr_accessor("tail")

-- True if this linked list is empty.
function LinkedList.methods:is_empty()
    return self.head == nil
end
--}>d

--{
-- The first object in this linked list.
function LinkedList.methods:first()
    assert(self.head, "ContainerEmpty")
    return self.head:get_datum()
end

-- The last object in this linked list.
function LinkedList.methods:last()
    assert(self.tail, "ContainerEmpty")
    return self.tail:get_datum()
end
--}>e

--{
-- Prepends the given item to this linked list.
-- @param item The item to prepend.
function LinkedList.methods:prepend(item)
    local tmp = LinkedList.Element.new(self, item, self.head)
    if self.head == nil then
	self.tail = tmp
    end
    self.head = tmp
end
--}>f

--{
-- Appends the given item to this linked list.
-- @param item The item to append.
function LinkedList.methods:append(item)
    local tmp = LinkedList.Element.new(self, item, nil)
    if self.head == nil then
	self.head = tmp
    else
	self.tail:set_succ(tmp)
    end
    self.tail = tmp
end
--}>g

--{
-- Returns a clone of this linked list.
-- Clones the list elements (but not the items in the list).
function LinkedList.methods:clone()
    local result = LinkedList.new()
    local ptr = self.head
    while ptr do
	result:append(ptr:get_datum())
	ptr = ptr:get_succ()
    end
    return result
end
--}>h

--{
-- Extracts the given item from this linked list.
-- @param item The item to extract.
function LinkedList.methods:extract(item)
    local ptr = self.head
    local prevPrt = nil
    while ptr and ptr:get_datum():is_not(item) do
	prevPtr = ptr
	ptr = ptr:get_succ()
    end
    assert(ptr, "ArgumentError")
    if ptr:is(self.head) then
	self.head = ptr:get_succ()
    else
	prevPtr:set_succ(ptr:get_succ())
    end
    if ptr:is(self.tail) then
	self.tail = prevPtr
    end
end
--}>i

--{
-- Inserts the given item
-- in the list after this linked list element.
-- @param item The item to insert.
function LinkedList.Element.methods:insertAfter(item)
    self.succ = LinkedList.Element.new(
				    self.list, item, self.succ)
    if self.list:get_tail():is(self) then
	self.list.set_tail(self.succ)
    end
end

-- Inserts the given item
-- in the list before this linked list element.
-- @param item The item to insert.
function LinkedList.Element.methods:insertBefore(item)
    local tmp = LinkedList.Element.new(self.list, item, self)
    if self.list:get_head():is(self) then
	self.list:set_head(tmp)
    else
	local prevPtr = self.list:get_head()
	while prevPtr and prevPtr:get_succ():is_not(self) do
	    prevPtr = prevPtr:get_succ()
	end
	prevPtr:set_succ(tmp)
    end
end
--}>j

-- Extracts this linked list element from the linked list.
function LinkedList.Element.methods:extract(item)
    local prevPtr = nil
    if self.list:get_head():is(self) then
	self.list:set_head(self.succ)
    else
	prevPtr = self.list:getHead()
	while prevPtr and prevPtr:get_succ():is_not(self) do
	    prevPtr = prevPtr:get_succ()
	end
	assert(prevPtr, "InternalError")
	prevPtr:set_succ(self.succ)
    end
    if self.list:get_tail():is(self) then
	self.list:set_tail(prevPtr)
    end
end

--{
-- Calls the given visitor function
-- for each object in this linked list.
function LinkedList.methods:each(visitor)
    local ptr = self.head
    while ptr do
	visitor(ptr:get_datum())
	ptr = ptr:get_succ()
    end
end
--}>k

-- Returns a string representation of this linked list.
function LinkedList.methods:toString()
    local s = ""
    local ptr = self.head
    while ptr do
	local obj = ptr:get_datum()
	s = s .. (obj or "(nil)")
	if ptr:get_succ() then
	    s = s .. ", "
	end
	ptr = ptr:get_succ()
    end
    return "LinkedList{" .. s .. "}"
end

-- LinkedList test program.
-- @param arg Command-line arguments.
function LinkedList.main(arg)
    print "LinkedList test program."
    local l1 = LinkedList.new()
    l1:append(57)
    print("l1 = ", l1)
    l1:append("hello")
    print("l1 = ", l1)
    l1:append(nil)
    print("l1 = ", l1)
    print("is_empty returns", l1:is_empty())
    print "Using each"
    l1:each(
	function(obj)
	    print(obj)
	end
    )
    l2 = l1:clone()
    print "Cloning"
    print("l2 = ", l2)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( LinkedList.main(arg) )
end
