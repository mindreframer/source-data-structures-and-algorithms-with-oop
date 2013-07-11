#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 20:42:45 $
    $RCSfile: PriorityQueue.lua,v $
    $Revision: 1.1 $

    $Id: PriorityQueue.lua,v 1.1 2004/11/26 20:42:45 brpreiss Exp $

--]]

require "Container"

--{
PriorityQueueMethods = Module.new("PriorityQueueMethods")

-- Enqueues the given object in this priority queue.
-- @param obj An object
PriorityQueueMethods:abstract_method("enqueue")

-- Returns the smallest object in this priority queue.
PriorityQueueMethods:abstract_method("get_min")

-- Dequeues and returns the smallest object in this priority queue.
PriorityQueueMethods:abstract_method("dequeueMin")

-- Abstract base class from which all priority queue classes are derived.
PriorityQueue = Class.new("PriorityQueue", Container)

-- Constructor
function PriorityQueue.methods:initialize()
    PriorityQueue.super(self)
end

PriorityQueue:include(PriorityQueueMethods)
--}>a

-- PriorityQueue test program.
-- @param pqueue The priority queue to test.
function PriorityQueue.test(pqueue)
    print "PriorityQueue test program."
    print(pqueue)
    pqueue:enqueue(box(3))
    pqueue:enqueue(box(1))
    pqueue:enqueue(box(4))
    pqueue:enqueue(box(1))
    pqueue:enqueue(box(5))
    pqueue:enqueue(box(9))
    pqueue:enqueue(box(2))
    pqueue:enqueue(box(6))
    pqueue:enqueue(box(5))
    pqueue:enqueue(box(4))
    print(pqueue)
    print "Using each"
    pqueue:each(
	function(obj)
	    print(obj)
	end
    )
    print "Using Iterator"
    for obj in pqueue:iter() do
	print(obj)
    end
    print "Dequeueing"
    while not pqueue:is_empty() do
	local obj = pqueue:dequeueMin()
	print(obj)
    end
end
