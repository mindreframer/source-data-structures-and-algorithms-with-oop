#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: QueueAsLinkedList.lua,v $
    $Revision: 1.7 $

    $Id: QueueAsLinkedList.lua,v 1.7 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Queue"
require "LinkedList"

--{
-- A queue implemented as a linked list.
QueueAsLinkedList = Class.new("QueueAsLinkedList", Queue)

-- Constructor.
function QueueAsLinkedList.methods:initialize()
    QueueAsLinkedList.super(self)
    self.list = LinkedList.new()
end

-- Purges this queue.
function QueueAsLinkedList.methods:purge()
    self.list.purge()
    Container.purge(self)
end
--}>a

--{
-- The object at the head of this queue.
function QueueAsLinkedList.methods:get_head()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    return self.list:first()
end

-- Enqueues the given object in this queue.
-- @param obj An object.
function QueueAsLinkedList.methods:enqueue(obj)
    self.list:append(obj)
    self.count = self.count + 1
end

-- Dequeues and returns the object at the head of this queue.
function QueueAsLinkedList.methods:dequeue()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    result = self.list:first()
    self.list:extract(result)
    self.count = self.count - 1
    return result
end
--}>b

-- Calls the given visitor method for each object in this queue.
-- @param visitor A visitor function.
function QueueAsLinkedList.methods:each(visitor)
    self.list:each(visitor)
end

-- Iterator that enumerates the objects in a queue.
function QueueAsLinkedList.methods:iter()
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

-- QueueAsLinkedList test program
-- @param arg Command-line arguments.
function QueueAsLinkedList.main(arg)
    print "QueueAsLinkedList test program."
    local queue2 = QueueAsLinkedList.new()
    Queue.test(queue2)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( QueueAsLinkedList.main(arg) )
end
