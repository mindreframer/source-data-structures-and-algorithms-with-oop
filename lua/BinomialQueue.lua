#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: BinomialQueue.lua,v $
    $Revision: 1.2 $

    $Id: BinomialQueue.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "MergeablePriorityQueue"
require "LinkedList"
require "GeneralTree"

--{
-- Mergeable priority queue implemented as a forest of binomial trees.
BinomialQueue =
    Class.new("BinomialQueue", MergeablePriorityQueue)

-- Constructor.
-- @param obj A binomial tree.
function BinomialQueue.methods:initialize(tree)
    BinomialQueue.super(self)
    self.treeList = LinkedList.new()
    if tree then
	assert(tree:is_a(BinomialTree), "DomainError")
	self.treeList:append(tree)
    end
end

-- The linked list of binomial trees.
BinomialQueue:attr_reader("treeList")
--}>a

--{
-- Adds the given binomial tree to this binomial queue.
-- @param tree A binomial tree.
function BinomialQueue.methods:addTree(tree)
    self.treeList:append(tree)
    self.count = self.count + tree:get_count()
end

-- Removes the given binomial tree from this binomial queue.
-- @param tree The binomial tree to remove.
function BinomialQueue.methods:removeTree(tree)
    self.treeList:extract(tree)
    self.count = self.count - tree:get_count()
end
--}>b

--{
-- The binomial tree in this binomial queue
-- with the smallest value at its root.
function BinomialQueue.methods:minTree()
    local minTree = nil
    local ptr = self.treeList:get_head()
    while ptr do
	local tree = ptr:get_datum()
	if not minTree or tree:get_key() < minTree:get_key() then
	    minTree = tree
	end
	ptr = ptr:get_succ()
    end
    return minTree
end

-- The smallest object contained in this binomial queue.
function BinomialQueue.methods:get_min()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    return minTree:get_key()
end
--}>c

--{
-- Merges this binomial queue with the given binomial queue.
-- @param queue The binomial queue to be merged.
function BinomialQueue.methods:merge(queue)
    local oldList = self.treeList
    self.treeList = LinkedList.new()
    self.count = 0
    local p = oldList:get_head()
    local q = queue.treeList:get_head()
    local sum = nil
    local carry = nil
    local i = 0
    while p or q  or carry do
	local a = nil
	if p then
	    local tree = p:get_datum()
	    if tree:get_degree() == i then
		a = tree
		p = p:get_succ()
	    end
	end
	local b = nil
	if q then
	    local tree = q:get_datum()
	    if tree:get_degree() == i then
		b = tree
		q = q:get_succ()
	    end
	end
	sum, carry = self:fullAdder(a, b, carry)
	if sum then
	    self:addTree(sum)
	end
	i = i + 1
    end
end
--}>d

--{
-- Returns the sum and carry that result
-- from the addition of the given binomial trees.
-- @param a A binomial tree.
-- @param b A binomial tree.
-- @param c A binomial tree.
function BinomialQueue.methods:fullAdder(a, b, c)
    if a then
	if b then
	    if c then
		return a:add(b), c
	    else
		return nil, a:add(b)
	    end
	else
	    if c then
		return nil, a:add(c)
	    else
		return a, nil
	    end
	end
    else
	if b then
	    if c then
		return nil, b:add(c)
	    else
		return b, nil
	    end
	else
	    if c then
		return c, nil
	    else
		return nil, nil
	    end
	end
    end
end
--}>e

--{
-- Enqueues the given object in this binomial queue.
-- @param obj The object to enqueue.
function BinomialQueue.methods:enqueue(obj)
    self:merge(BinomialQueue.new(BinomialTree.new(obj)))
end
--}>f

--{
-- Dequeues and returns
-- the smallest object in this binomial queue.
function BinomialQueue.methods:dequeueMin()
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local mt = self:minTree()
    self:removeTree(mt)
    local queue = BinomialQueue.new()
    while mt.degree > 0 do
	local child = mt:get_subtree(0)
	mt:detachSubtree(child)
	queue:addTree(child)
    end
    self:merge(queue)
    return mt:get_key()
end
--}>g

--{
-- A binomial tree implemented as as general tree.
BinomialTree = Class.new("BinomialTree", GeneralTree)

-- Constructs a binomial tree that contains the given key.
-- +key+:: An object.
function BinomialTree.methods:initialize(key)
    BinomialTree.super(self, key)
end

-- The key in this binomial tree node.
BinomialTree:attr_accessor("key")

-- The subtrees of this binomial tree node.
BinomialTree:attr_accessor("list")

-- The degree of this binomial tree node.
BinomialTree:attr_accessor("degree")
--}>h

--{
-- Adds the given binomial tree to this binomial tree.
-- Modifies this binomial tree.
-- The trees must have the same degree.
-- @param tree A binomial tree.
function BinomialTree.methods:add(tree)
    if self.degree ~= tree.degree then
	error "ValueError"
    end
    if self.key > tree.key then
	self:swapContentsWith(tree)
    end
    self:attachSubtree(tree)
    return self
end
--}>i

-- The number of in this binomial tree.
function BinomialTree.methods:get_count()
    return 2 ^ self.degree
end

-- Swaps the contents of this binomial tree node
-- with the given binomial tree node.
-- @param tree A binomial tree node.
function BinomialTree.methods:swapContentsWith(tree)
    self.key, tree.key = tree.key, self.key
    self.list, tree.list = tree.list, self.list
    self.degree, tree.degree = tree.degree, self.degree
end

-- Returns a string representation of this binomial queue.
function BinomialQueue.methods:toString()
    local s = ""
    local ptr = self.treeList:get_head()
    while ptr do
	s = s .. tostring(ptr:get_datum()) .. "\n"
	ptr = ptr:get_succ()
    end
    return class(self) .. " {\n" .. s .. "}"
end

-- Purges this binomial queue.
function BinomialQueue.methods:purge()
    self.treeList = LinkedList.new()
    self.count = 0
end

-- Calls the given visitor function
-- for all the keys in this binomial queue.
-- @param visitor A visitor function.
function BinomialQueue.methods:each(visitor)
    local ptr = self.treeList:get_head()
    while ptr do
	ptr:get_datum():each(visitor)
	ptr = ptr:get_succ()
    end
end

-- BinomialQueue test program.
-- @param arg Command-line arguments.
function BinomialQueue.main(arg)
    print "BinomialQueue test program."
    print(BinomialQueue)
    print(BinomialTree)
    local pqueue = BinomialQueue.new()
    PriorityQueue.test(pqueue)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BinomialQueue.main(arg) )
end
