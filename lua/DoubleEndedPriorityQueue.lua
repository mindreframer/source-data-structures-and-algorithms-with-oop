#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 00:39:47 $
    $RCSfile: DoubleEndedPriorityQueue.lua,v $
    $Revision: 1.1 $

    $Id: DoubleEndedPriorityQueue.lua,v 1.1 2004/11/27 00:39:47 brpreiss Exp $

--]]

require "PriorityQueue"

-- Abstract base class from which all double-ended priority queue classes
-- are derived.
DoubleEndedPriorityQueue = Class.new("DoubleEndedPriorityQueue", PriorityQueue)

-- Constructor
function DoubleEndedPriorityQueue.methods:initialize()
    DoubleEndedPriorityQueue.super(self)
end

-- Returns the largest object in this priority queue.
DoubleEndedPriorityQueue:abstract_method("get_max")

-- Dequeues and returns the largest object in this priority queue.
DoubleEndedPriorityQueue:abstract_method("dequeueMax")

-- DoubleEndedPriorityQueue test program.
-- @param pqueue The double-ended priority queue to test.
function DoubleEndedPriorityQueue.test(pqueue)
    print "DoubleEndedPriorityQueue test program."
    PriorityQueue.test(pqueue)
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
    while not pqueue:is_empty() do
	local obj = pqueue:dequeueMax()
	print(obj)
    end
end
