#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:05:25 $
    $RCSfile: Queue.lua,v $
    $Revision: 1.8 $

    $Id: Queue.lua,v 1.8 2004/11/25 02:05:25 brpreiss Exp $

--]]

require "Container"

--{
-- Abstract base class from which all queue classes are derived.
Queue = Class.new("Queue", Container)

-- Constructor.
function Queue.methods:initialize()
    Queue.super(self)
end

-- Enqueues the given object on this queue.
-- @param obj The object to enqueue.
Queue:abstract_method("enqueue")

-- Dequeues and returns the object at the head of this queue.
Queue:abstract_method("dequeue")

-- The object at the head of the queue.
Queue:abstract_method("get_head")
--}>a

-- Queue test program.
-- @param queue A queue.
function Queue.test(queue)
    print "Queue test program."
    for i = 0, 4 do
	if queue:is_full() then
	    break
	end
	queue:enqueue(box(i))
    end
    print(queue)
    print "Using each"
    queue:each(
	function(obj)
	    print(obj)
	end
    )
    print "Using Iterator"
    for i in queue:iter() do
	print(i)
    end
    print "get_head"
    print(queue:get_head())
    print "Dequeueing"
    while not queue:is_empty() do
	print(queue:dequeue())
    end
end
