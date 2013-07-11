#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:05:25 $
    $RCSfile: Stack.lua,v $
    $Revision: 1.9 $

    $Id: Stack.lua,v 1.9 2004/11/25 02:05:25 brpreiss Exp $

--]]

require "Container"

--{
-- Abstract base class from which all stack classes are derived.
Stack = Class.new("Stack", Container)

-- Constructs a stack.
function Stack.methods:initialize()
    Stack.super(self)
    self.count = 0
end

-- Pushes the given object onto this stack.
-- @param obj An object.
Stack:abstract_method("push")

-- Pops and returns the top object of this stack.
Stack:abstract_method("pop")

-- Returns the object at the top of this stack.
Stack:abstract_method("get_top")
--}>a

-- Stack test program.
-- @param stack A stack.
function Stack.test(stack)
    print "Stack test program."
    for i = 1, 5 do
	if not stack:is_full() then
	    stack:push(box(i))
	end
    end
    print(stack)
    print "Using iterator"
    for obj in stack:iter() do
	print(obj)
    end
    print("Top is", stack:get_top())
    print "Popping"
    while not stack:is_empty() do
	print(stack:pop())
    end
    stack:push(box(2))
    stack:push(box(4))
    stack:push(box(6))
    print "Purging"
    stack:purge()
    print(stack)
end
