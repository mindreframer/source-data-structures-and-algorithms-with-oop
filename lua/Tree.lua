#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 21:36:29 $
    $RCSfile: Tree.lua,v $
    $Revision: 1.4 $

    $Id: Tree.lua,v 1.4 2004/11/26 21:36:29 brpreiss Exp $

--]]

require "Container"
require "StackAsLinkedList"
require "QueueAsLinkedList"

--{
-- Base class from which all tree classes are derived.
Tree = Class.new("Tree", Container)

-- Constructor.
function Tree.methods:initialize()
    Tree.super(self)
end

-- The key in this tree node.
Tree:abstract_method("get_key")

-- Returns the specified subtree of this tree node.
-- +index+:: An index.
Tree:abstract_method("get_subtree")

-- True if this tree node is empty.
Tree:abstract_method("is_empty")

-- True if this tree node is a leaf node.
Tree:abstract_method("is_leaf")

-- The degree of this node.
Tree:abstract_method("get_degree")

-- The height of this tree.
Tree:abstract_method("get_height")
--}>a

--{
-- Pre-visit mode.
Tree.PREVISIT = -1
-- In-visit mode.
Tree.INVISIT = 0
-- Post-visit mode.
Tree.POSTVISIT = 1

-- Calls the given visitor function for each key in this tree
-- in depth-first traversal order.
function Tree.methods:depthFirstTraversal(visitor)
    if not self:is_empty() then
	visitor(self.key, Tree.PREVISIT)
	for i = 0, self:get_degree() - 1 do
	    self:get_subtree(i):depthFirstTraversal(visitor)
	end
	visitor(self.key, Tree.POSTVISIT)
    end
end
--}>b

--{
-- Calls the given visitor function for each key in this tree
-- in breadth-first traversal order.
function Tree.methods:breadthFirstTraversal(visitor)
    local queue = QueueAsLinkedList.new()
    if not self:is_empty() then
	queue:enqueue(self)
    end
    while not queue:is_empty() do
	local head = queue:dequeue()
	visitor(head:get_key())
	for i = 0, head:get_degree() - 1 do
	    local child = head:get_subtree(i)
	    if not child:is_empty() then
		queue:enqueue(child)
	    end
	end
    end
end
--}>c

--{
-- Calls the given visitor function for each key in this tree
-- in depth-first traversal order.
-- @param visitor A visitor function.
function Tree.methods:each(visitor)
    self:depthFirstTraversal(
	function(obj,mode)
	    if mode == Tree.PREVISIT then
		visitor(obj)
	    end
	end
    )
end
--}>d

--{
-- Returns an iterator that enumerates the key contained in a tree.
function Tree.methods:iter()
    local stack = StackAsLinkedList.new() -- Iterator state.
    if not self:is_empty() then
	stack:push(self)
    end
    return
	function()
	    local result = nil
	    if not stack:is_empty() then
		top = stack:pop()
		result = top:get_key()
		local i = top:get_degree() - 1
		while i >= 0 do
		    local subtree = top:get_subtree(i)
		    if not subtree:is_empty() then
			stack:push(subtree)
		    end
		    i = i - 1
		end
	    end
	    return result
	end
end
--}>e

-- The height of this tree.
function Tree.methods:get_height()
    if self:is_empty() then
	return -1
    end
    local height = -1
    for i = 0, self:get_degree() - 1 do
	height = math.max(height, self:get_subtree(i):get_height())
    end
    return height + 1
end

-- The number of keys contained in ths tree.
function Tree.methods:get_count()
    if self:is_empty() then
	return 0
    end
    local result = 1
    for i = 0, self:get_degree() - 1 do
	result = result + self:get_subtree(i):get_count()
    end
    return result
end

-- Returns a preorder visitor that is composed with the given visitor function.
-- @param visitor A visitor function.
function Tree.preOrder(visitor)
    return
	function(obj, mode)
	    if mode == Tree.PREVISIT then
		visitor(obj)
	    end
	end
end

-- Returns an inorder visitor that is composed with the given visitor function.
-- @param visitor A visitor function.
function Tree.inOrder(visitor)
    return
	function(obj, mode)
	    if mode == Tree.INVISIT then
		visitor(obj)
	    end
	end
end

-- Returns a postorder visitor that is composed with the given visitor function.
-- @param visitor A visitor function.
function Tree.postOrder(visitor)
    return
	function(obj, mode)
	    if mode == Tree.POSTVISIT then
		visitor(obj)
	    end
	end
end

-- Tree test program.
-- @param tree The tree to test.
function Tree.test(tree)
    print "Tree test program."

    print "Breadth-First traversal"
    tree:breadthFirstTraversal(
	function(obj)
	    print(obj)
	end
    )

    print "Preorder traversal"
    tree:depthFirstTraversal(Tree.preOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Inorder traversal"
    tree:depthFirstTraversal(Tree.inOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Postorder traversal"
    tree:depthFirstTraversal(Tree.postOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Using each"
    tree:each(
	function(obj)
	    print(obj)
	end
    )

    print "Using Iterator"
    for obj in tree:iter() do
	print(obj)
    end
end
