#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: LeftistHeap.lua,v $
    $Revision: 1.2 $

    $Id: LeftistHeap.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "BinaryTree"
require "MergeablePriorityQueue"

--{
-- A mergeable priority queue
-- implemented as a leftist binary tree.
LeftistHeap = Class.new("LeftistHeap", BinaryTree)

LeftistHeap:include(PriorityQueueMethods)
LeftistHeap:include(MergeablePriorityQueueMethods)

-- Constructs a leftist heap.
-- @param key An object.
function LeftistHeap.methods:initialize(key)
    if key then
	LeftistHeap.super(self, key,
			LeftistHeap.new(), LeftistHeap.new())
	self.nullPathLength = 1
    else
	LeftistHeap.super(self)
	self.nullPathLength = 0
    end
end

-- The key in this leftist heap node.
LeftistHeap:attr_accessor("key")

-- The left subtree of this leftist heap node.
LeftistHeap:attr_accessor("left")

-- The right subtree of this leftist heap node.
LeftistHeap:attr_accessor("right")

-- The null path length of this leftist heap node.
LeftistHeap:attr_accessor("nullPathLength")
--}>a

--{
-- Merges this leftist heap with the given leftist heap.
-- All the objects in the given leftist heap
-- are transfered to this leftist heap.
-- Therefore, after the merge, the given leftist heap is empty.
-- @param queue A leftist heap.
function LeftistHeap.methods:merge(queue)
    if self:is_empty() then
	self:swapContentsWith(queue)
    elseif not queue:is_empty() then
	if self.key > queue.key then
	    self:swapContentsWith(queue)
	end
	self.right:merge(queue)
	if self.left.nullPathLength <
				self.right.nullPathLength then
	    self:swapSubtrees()
	end
	self.nullPathLength = 1 +
		math.min(self.left.nullPathLength,
			self.right.nullPathLength)
    end
end
--}>b

--{
-- Enqueues the given object in this leftist heap.
-- +obj+:: The object to enqueue.
function LeftistHeap.methods:enqueue(obj)
    self:merge(LeftistHeap.new(obj))
end
--}>c

--{
-- The smallest object in this leftist heap.
function LeftistHeap.methods:get_min()
    if self:is_empty() then
	error "ContainerEmpty"
    end
    return self.key
end
--}>d

--{
-- Dequeues and returns the smallest object in this leftist heap.
function LeftistHeap.methods:dequeueMin()
    if self:is_empty() then
	error "ContainerEmpty"
    end
    local result = self.key
    local oldLeft = self.left
    local oldRight = self.right
    self:purge()
    self:swapContentsWith(oldLeft)
    self:merge(oldRight)
    return result
end
--}>e

-- Swaps the contents of this leftist heap node
-- with the given leftist heap node.
-- @param heap A leftist heap node.
function LeftistHeap.methods:swapContentsWith(heap)
    self.key, heap.key = heap.key, self.key
    self.left, heap.left = heap.left, self.left
    self.right, heap.right = heap.right, self.right
    self.nullPathLength, heap.nullPathLength =
	heap.nullPathLength, self.nullPathLength
end

-- Swaps the subtree of this leftist heap node.
function LeftistHeap.methods:swapSubtrees()
    self.left, self.right = self.right, self.left
end

-- Leftist heap test program.
-- @param arg Command-line arguments.
function LeftistHeap.main(arg)
    print "LeftistHeap test program."
    print(LeftistHeap)
    local pqueue = LeftistHeap.new()
    PriorityQueue.test(pqueue)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( LeftistHeap.main(arg) )
end
