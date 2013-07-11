#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: MergeablePriorityQueue.lua,v $
    $Revision: 1.2 $

    $Id: MergeablePriorityQueue.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "PriorityQueue"

--{
-- Mergeable priority queue methods.
MergeablePriorityQueueMethods =
    Module.new("MergeablePriorityQueueMethods")

-- Merges this priority queue with the given priority queue.
-- @param pqueue: A priority queue.
MergeablePriorityQueueMethods:abstract_method("merge")

-- Abstract base class from which
-- mergeable priority queues are derived.
MergeablePriorityQueue =
    Class.new("MergeablePriorityQueue", PriorityQueue)

-- Constructor.
function MergeablePriorityQueue.methods:initialize()
    MergeablePriorityQueue.super(self)
end

MergeablePriorityQueue:include(MergeablePriorityQueueMethods)
--}>a
