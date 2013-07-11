#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: StackAsLinkedList.lua,v $
    $Revision: 1.6 $

    $Id: StackAsLinkedList.lua,v 1.6 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Stack"
require "LinkedList"

--{
-- Stack implemented using a linked list.
StackAsLinkedList = Class.new("StackAsLinkedList", Stack)

-- Constructor.
function StackAsLinkedList.methods:initialize()
    StackAsLinkedList.super(self)
    self.list = LinkedList.new()
end

-- Purges this stack.
function StackAsLinkedList.methods:purge()
    self.list:purge()
    Container.methods.purge(self)
end
--}>a

--{
-- Pushes the given object onto this stack.
-- @param obj An object.
function StackAsLinkedList.methods:push(obj)
    self.list:prepend(obj)
    self.count = self.count + 1
end

-- Pops and returns the object at the top of this stack.
function StackAsLinkedList.methods:pop()
    assert(self.count ~= 0, "ContainerEmpty")
    local result = self.list:first()
    self.list:extract(result)
    self.count = self.count - 1
    return result
end

-- The object at top of this stack.
function StackAsLinkedList.methods:get_top()
    assert(self.count ~= 0, "ContainerEmpty")
    return self.list:first()
end
--}>b

--{
-- Calls the given visitor method for each object in this stack.
-- @param visitor A visitor function.
function StackAsLinkedList.methods:each(visitor)
    self.list:each(visitor)
end
--}>c

--{
-- Iterator that enumerates the objects in a given stack.
function StackAsLinkedList.methods:iter()
    local position = self.list:get_head() -- Iterator state.
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
--}>d

-- StackAsLinkedList test program.
-- @param arg Command-line arguments.
function StackAsLinkedList.main(arg)
    print "StackAsLinkedList test program."
    stack2 = StackAsLinkedList.new()
    Stack.test(stack2)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( StackAsLinkedList.main(arg) )
end
