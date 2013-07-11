#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 19:34:52 $
    $RCSfile: MWayTree.lua,v $
    $Revision: 1.1 $

    $Id: MWayTree.lua,v 1.1 2004/11/26 19:34:52 brpreiss Exp $

--]]

require "SearchTree"
require "Array"
require "QueueAsLinkedList"

--{
-- An M-way search tree implemented using arrays.
MWayTree = Class.new("MWayTree", SearchTree)

-- Constructs an M-way search tree node with the given order m.
-- @param Obj An integer greater than 2.
function MWayTree.methods:initialize(m)
    assert(m > 2, "ArgumentError")
    MWayTree.super(self)
    self.key = Array.new(m - 1, 1)
    self.subtree = Array.new(m)
end

function MWayTree.methods:get_m()
    return self.subtree:get_length()
end
--}>a

--{
-- Calls the given visitor function for each key in this M-way search tree
-- in depth-first traversal order.
-- @param visitor A visitor function.
function MWayTree.methods:depthFirstTraversal(visitor)
    if not self:is_empty() then
	for i = 1, self.count do
	    visitor(self.key[i], Tree.PREVISIT)
	end
	self.subtree[0]:depthFirstTraversal(visitor)
	for i = 1, self.count do
	    visitor(self.key[i], Tree.INVISIT)
	    self.subtree[i]:depthFirstTraversal(visitor)
	end
	for i = 1, self.count do
	    visitor(self.key[i], Tree.POSTVISIT)
	end
    end
end
--}>b

--{
-- Finds the object in this M-way search tree that equals the given object.
-- @param obj The object to find.
function MWayTree.methods:find(obj)
    if self:is_empty() then
	return nil
    end
    local i = self.count
    while i > 0 do
	diff = obj:cmp(self.key[i])
	if diff == 0 then
	    return self.key[i]
	end
	if diff > 0 then
	    break
	end
	i = i - 1
    end
    return self.subtree[i]:find(obj)
end
--}>c

--{
-- Returns the position of the given object
-- in the array of keys contained in this M-way tree node.
-- Uses a binary search.
-- @param Obj The object to find.
function MWayTree.methods:findIndex(obj)
    if self:is_empty() or obj < self.key[1] then
	return 0
    end
    local left = 1
    local right = self.count
    while left < right do
	local middle = math.floor((left + right + 1) / 2)
	if obj < self.key[middle] then
	    right = middle - 1
	else
	    left = middle
	end
    end
    return left
end

-- Finds the object in this M-way search tree that equals the given object.
-- @param obj The object to find.
function MWayTree.methods:find(obj)
    if self:is_empty() then
	return nil
    end
    local index = self:findIndex(obj)
    if index ~= 0 and self.key[index] == obj then
	return self.key[index]
    else
	return self.subtree[index]:find(obj)
    end
end
--}>d

--{
-- Inserts the given object into this M-way search tree.
-- @param obj+:: The object to insert.
function MWayTree.methods:insert(obj)
    if self:is_empty() then
	self.subtree[0] = MWayTree.new(self:get_m())
	self.key[1] = obj
	self.subtree[1] = MWayTree.new(self:get_m())
	self.count = 1
    else
	local index = self:findIndex(obj)
	if index ~= 0 and self.key[index] == obj then
	    error "ValueError"
	end
	if not self:is_full() then
	    local i = self.count
	    while i > index do
		self.key[i + 1] = self.key[i]
		self.subtree[i + 1] = self.subtree[i]
		i = i - 1
	    end
	    self.key[index + 1] = obj
	    self.subtree[index + 1] = MWayTree.new(self:get_m())
	    self.count = self.count + 1
	else
	    self.subtree[index]:insert(obj)
	end
    end
end
--}>e

--{
-- Withdraws the given object from this M-way search tree.
-- @param obj The object to withdraw.
function MWayTree.methods:withdraw(obj)
    if self:is_empty() then
	error "ArgumentError"
    end
    local index = self:findIndex(obj)
    if index ~= 0 and self.key[index] == obj then
	if not self.subtree[index - 1]:is_empty() then
	    local max = self.subtree[index - 1]:get_max()
	    self.key[index] = max
	    self.subtree[index - 1]:withdraw(max)
	elseif not self.subtree[index]:is_empty() then
	    local min = self.subtree[index]:get_min()
	    self.key[index] = min
	    self.subtree[index]:withdraw(min)
	else
	    self.count = self.count - 1
	    local i = index
	    while i <= self.count do
		self.key[i] = self.key[i + 1]
		self.subtree[i] = self.subtree[i + 1]
		i = i + 1
	    end
	    self.key[i] = nil
	    self.subtree[i] = nil
	    if self.count == 0 then
		self.subtree[0] = nil
	    end
	end
    else
	self.subtree[index]:withdraw(obj)
    end
end
--}>f

-- Purges this M-way search tree.
function MWayTree.methods:purge()
    for i = 1, self.count do
	self.key[i] = nil
    end
    for i = 0, self.count do
	self.subtree[i] = nil
    end
    self.count = 0
end

-- Calls the given visitor function for each key in this M-way search tree
-- in breadth-first traversal order.
-- @param visitor A visitor function.
function MWayTree.methods:breadthFirstTraversal(visitor)
    local queue = QueueAsLinkedList.new()
    if not self:is_empty() then
	queue:enqueue(self)
    end
    while not queue:is_empty() do
	local head = queue:dequeue()
	for i = 1, head:get_degree() - 1 do
	    visitor(head:get_key(i))
	end
	for i = 0, head:get_degree() - 1 do
	    local child = head:get_subtree(i)
	    if not child:is_empty() then
		queue:enqueue(child)
	    end
	end
    end
end

-- Returns an iterator that enumerates the keys in an M-way search tree.
function MWayTree.methods:iter()
    local stack = StackAsLinkedList.new() -- Iterator state.
    local position = 1 -- Iterator state.
    if not self:is_empty() then
	stack:push(self)
    end
    return
	function()
	    local result = nil
	    if not stack:is_empty() then
		local top = stack:get_top()
		result = top:get_key(position)
		position = position + 1
		if position == top:get_degree() then
		    position = 1
		    top = stack:pop()
		    local i = top:get_degree() - 1
		    while i >= 0 do
			local subtree = top:get_subtree(i)
			if not subtree:is_empty() then
			    stack:push(subtree)
			end
			i = i - 1
		    end
		end
	    end
	    return result
	end
end

-- True if this M-way search tree is empty.
function MWayTree.methods:is_empty()
    return self.count == 0
end

-- True if this M-way search tree is full.
function MWayTree.methods:is_full()
    return self.count == self:get_m() - 1
end

-- True if this M-way search tree node is a leaf node.
function MWayTree.methods:is_leaf()
    if self:is_empty() then
	return false
    end
    for i = 0, self.count do
	if not self.subtree[i]:is_empty() then
	    return false
	end
    end
    return true
end

-- The degree of this M-way search tree node.
function MWayTree.methods:get_degree()
    if self.count == 0 then
	return 0
    else
	return self.count + 1
    end
end

-- Returns the specified key contained in this M-way search tree node.
-- @param i An index.
function MWayTree.methods:get_key(i)
    if self:is_empty() then
	error "StateError"
    end
    if i then
	return self.key[i]
    else
	return self.key[1]
    end
end

-- Returns the specified subtree of this M-way search tree node.
-- @param i An index.
function MWayTree.methods:get_subtree(i)
    if self:is_empty() then
	error "StateError"
    end
    return self.subtree[i]
end

-- The number of keys contained in this M-way search tree.
function MWayTree.methods:get_count()
    if self:is_empty() then
	return 0
    end
    local result = self.count
    for i = 0, self.count do
	result = result + self.subtree[i]._count
    end
    return result
end

-- True if the given object is in this M-way search tree.
-- @param obj An object.
function MWayTree.methods:contains(obj)
    if self:is_empty() then
	return false
    end
    local i = self.count
    while i > 0 do
	if self.key[i]:is(obj) then
	    return true
	end
	if obj > self.key[i] then
	    break
	end
	i = i - 1
    end
    return self.subtree[i]:contains(obj)
end

-- The smallest key in this M-way search tree.
function MWayTree.methods:get_min()
    if self:is_empty() then
	return nil
    elseif self.subtree[0]:is_empty() then
	return self.key[1]
    else
	return self.subtree[0]:get_min()
    end
end

-- The largest key in this M-way search tree.
function MWayTree.methods:get_max()
    if self:is_empty() then
	return nil
    elseif self.subtree[self.count]:is_empty() then
	return self.key[self.count]
    else
	return self.subtree[self.count]:get_max()
    end
end

-- MWayTree test program.
-- @param arg Command-line arguments.
function MWayTree.main(arg)
    print "MWayTree test program."
    print(SearchTree)
    print(MWayTree)
    local tree = MWayTree.new(3)
    SearchTree.test(tree)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( MWayTree.main(arg) )
end
