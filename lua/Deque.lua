#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:05:25 $
    $RCSfile: Deque.lua,v $
    $Revision: 1.8 $

    $Id: Deque.lua,v 1.8 2004/11/25 02:05:25 brpreiss Exp $

--]]

require "Module"
require "Container"

--{
-- Deque methods.
DequeMethods = Module.new("DequeMethods")

-- Enqueues the given object at the head of this deque.
-- @param obj The object to enqueue.
DequeMethods:abstract_method("enqueueHead")

-- Dequeues and returns the object from the head of this deque.
DequeMethods:abstract_method("dequeueHead")

-- The object at the head of this deque.
DequeMethods:abstract_method("get_head")

-- Enqueues the given object at the tail of this deque.
-- @param obj The object to enqueue
DequeMethods:abstract_method("enqueueTail")

-- Dequeues and returns the object from the tail of this deque.
DequeMethods:abstract_method("dequeueTail")

-- The object at the head of this deque.
DequeMethods:abstract_method("get_tail")

-- Abstract base class from which deque classes are derived.
Deque = Class.new("Deque", Queue)

-- Constructor.
function Deque.methods:initialize()
    Deque.super(self)
end

Deque:alias_method("queueHead", "get_head")
Deque:include(DequeMethods)
Deque:alias_method("get_head", "queueHead")
--}>a

-- Deque test program.
-- @param deque Deque to be tested.
function Deque.test(deque)
    print "Deque test program."
    for i = 0, 4 do
	if deque:is_full() then
	    break
	end
	deque:enqueueHead(box(i))
	if deque:is_full() then
	    break
	end
	deque:enqueueTail(box(i))
    end
    print(deque)
    print("get_head = ", deque:get_head())
    print("get_tail = ", deque:get_tail())
    while not deque:is_empty() do
	obj = deque:dequeueHead()
	print(obj)
	if deque:is_empty() then
	    break
	end
	obj = deque:dequeueTail()
	print(obj)
    end
end
