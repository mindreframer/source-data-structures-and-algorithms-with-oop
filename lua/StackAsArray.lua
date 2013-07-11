#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: StackAsArray.lua,v $
    $Revision: 1.9 $

    $Id: StackAsArray.lua,v 1.9 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Stack"
require "Array"

--{
-- Stack implemented using an array.
StackAsArray = Class.new("StackAsArray", Stack)

-- Constructs a stack with the given size.
-- @param size The size of the stack
function StackAsArray.methods:initialize(size)
    StackAsArray.super(self)
    self.array = Array.new(size)
end

-- Purges this stack.
function StackAsArray.methods:purge()
    while self.count > 0 do
	self.count = self.count - 1
	self.array[self.count] = nil
    end
end
--}>a

--{
-- Pushes the given object onto this stack.
-- @param obj An object.
function StackAsArray.methods:push(obj)
    assert( self.count ~= self.array:get_length(),
	    "ContainerFull")
    self.array[self.count] = obj
    self.count = self.count + 1
end

-- Pops and returns the top object from this stack.
function StackAsArray.methods:pop()
    assert(self.count ~= 0, "ContainerEmpty")
    self.count = self.count - 1
    local result = self.array[self.count]
    self.array[self.count] = nil
    return result
end

-- Returns the object at the top of this stack.
function StackAsArray.methods:get_top()
    assert(self.count ~= 0, "ContainerEmpty")
    return self.array[self.count - 1]
end
--}>b

-- True if this stack is full.
function StackAsArray.methods:is_full()
    return self.count == self.array:get_length()
end

--{
-- Calls the given visitor function
-- for each element of this stack.
-- @param visitor A visitor function.
function StackAsArray.methods:each(visitor)
    for i = 0, self.count - 1 do
	visitor(self.array[i])
    end
end
--}>c

--{
-- Returns an iterator that enumerates
-- the elements of this stack.
function StackAsArray.methods:iter()
    local i = 0 -- Iterator state
    return
	function()
	    local result = nil
	    if i < self.count then
		result = self.array[i]
		i = i + 1
	    end
	    return result
	end
end
--}>d

-- StackAsArray class program.
-- @param arg Command-line arguments.
function StackAsArray.main(arg)
    print "StackAsArray test program."
    local stack1 = StackAsArray.new(5)
    Stack.test(stack1)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( StackAsArray.main(arg) )
end
