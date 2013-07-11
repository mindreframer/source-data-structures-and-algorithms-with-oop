#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: DequeAsLinkedList.lua,v $
    $Revision: 1.7 $

    $Id: DequeAsLinkedList.lua,v 1.7 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Deque"
require "QueueAsLinkedList"

--{
-- Deque implemented using a linked list.
DequeAsLinkedList =
    Class.new("DequeAsLinkedList", QueueAsLinkedList)

-- Constructor.
function DequeAsLinkedList.methods:initialize()
    DequeAsLinkedList.super(self)
end

DequeAsLinkedList:alias_method("queueHead", "get_head")
DequeAsLinkedList:include(DequeMethods)
DequeAsLinkedList:alias_method("get_head", "queueHead")

-- Enqueues the given object at the head of this deque.
-- @param obj An object.
function DequeAsLinkedList.methods:enqueueHead(obj)
    self.list:prepend(obj)
    self.count = self.count + 1
end

DequeAsLinkedList:alias_method("dequeueHead", "dequeue")
--}>a

--{
-- The object at the tail of this deque.
function DequeAsLinkedList.methods:get_tail()
    assert(self.count ~= 0, "ContainerEmpty")
    return self.list:last()
end

DequeAsLinkedList:alias_method("enqueueTail", "enqueue")

-- Dequeues and returns the object at the tail of this deque.
function DequeAsLinkedList.methods:dequeueTail()
    assert(self.count ~= 0, "ContainerEmpty")
    local result = self.list:last()
    self.list:extract(result)
    self.count = self.count - 1
    return result
end
--}>b

-- DequeAsLinkedList test program.
-- @param arg Command-line arguments.
function DequeAsLinkedList.main(arg)
    print "DequeAsLinkedList test program."
    local deque2 = DequeAsLinkedList.new()
    Queue.test(deque2)
    Deque.test(deque2)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( DequeAsLinkedList.main(arg) )
end
