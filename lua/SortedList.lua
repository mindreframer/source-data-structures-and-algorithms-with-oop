#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: SortedList.lua,v $
    $Revision: 1.6 $

    $Id: SortedList.lua,v 1.6 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "OrderedList"

--{
-- Sorted list methods.
SortedListMethods = Module.new("SortedListMethods")

-- Abstract base class from which sorted lists are derived.
SortedList = Class.new("SortedList", OrderedList)

function SortedList.methods:initialize()
    SortedList.super(self)
end

SortedList:include(SortedListMethods)
--}>a

-- SortedList test program.
-- @param list The sorted list to test.
function SortedList.test(list)
    print "SortedList test program."
    list:insert(box(4))
    list:insert(box(3))
    list:insert(box(2))
    list:insert(box(1))
    print(list)
    local obj = list:find(box(2))
    list:withdraw(obj)
    print(list)
    for i in list:iter() do
	print(i)
    end
end
