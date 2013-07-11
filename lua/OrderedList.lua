#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: OrderedList.lua,v $
    $Revision: 1.6 $

    $Id: OrderedList.lua,v 1.6 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "SearchableContainer"

--{
-- Abstract base class from which all ordered lists are derived.
OrderedList = Class.new("OrderedList", SearchableContainer)

-- Constructor.
function OrderedList.methods:initialize()
    OrderedList.super(self)
end

-- Returns the object at the given index in this ordered list.
-- +index+:: An index.
OrderedList:abstract_method("getitem")

-- Returns a cursor that represents the position in this list
-- of an object that is equal to the given object.
-- @param Obj An object.
OrderedList:abstract_method("findPosition")
--}>a

-- OrderedList test program.
-- @param list The ordered list to test.
function OrderedList.test(list)
    print "OrderedList test program."
    list:insert(box(1))
    list:insert(box(2))
    list:insert(box(3))
    list:insert(box(4))
    print(list)
    local obj = list:find(box(2))
    list:withdraw(obj)
    print(list)
    local position = list:findPosition(box(3))
    position:insertAfter(box(5))
    print(list)
    position:insertBefore(box(6))
    print(list)
    position:withdraw()
    print(list)
    print "Using each"
    list:each( function(obj) print(obj) end )
    print "Using Iterator"
    for obj in list:iter() do
	print(obj)
    end
end
