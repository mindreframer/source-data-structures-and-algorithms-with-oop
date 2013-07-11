#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: DequeAsArray.lua,v $
    $Revision: 1.7 $

    $Id: DequeAsArray.lua,v 1.7 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Deque"
require "QueueAsArray"

--{
-- Deque implemented using an array.
DequeAsArray = Class.new("DequeAsArray", QueueAsArray)

-- Constructs a deque with the given size.
-- @param size The size of the deque.
function DequeAsArray.methods:initialize(size)
    DequeAsArray.super(self, size)
end

DequeAsArray:alias_method("queueHead", "get_head")
DequeAsArray:include(DequeMethods)
DequeAsArray:alias_method("get_head", "queueHead")

-- Enqueues the given object at the head of this deque.
-- self.param obj An object.
function DequeAsArray.methods:enqueueHead(obj)
    if self.count == self.array:get_length() then
	error "ContainerFull"
    end
    if self.headPos == 0 then
	self.headPos = self.array.length - 1
    else
	self.headPos = self.headPos - 1
    end
    self.array[self.headPos] = obj
    self.count = self.count + 1
end

DequeAsArray:alias_method("dequeueHead", "dequeue")
--}>a

--{
-- The object at the tail of this deque.
function DequeAsArray.methods:get_tail()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    return self.array[self.tailPos]
end

DequeAsArray:alias_method("enqueueTail", "enqueue")

-- Dequeues and returns the object at the tail of this deque.
function DequeAsArray.methods:dequeueTail()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    result = self.array[self.tailPos]
    self.array[self.tailPos] = nil
    if self.tailPos == 0 then
	self.tailPos = self.array.length - 1
    else
	self.tailPos = self.tailPos - 1
    end
    self.count = self.count - 1
    return result
end
--}>b

-- DequeAsArray test program.
-- @param arg Command-line arguments.
function DequeAsArray.main(arg)
    print "DequeAsArray test program."
    local deque1 = DequeAsArray.new(10)
    Queue.test(deque1)
    Deque.test(deque1)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( DequeAsArray.main(arg) )
end
