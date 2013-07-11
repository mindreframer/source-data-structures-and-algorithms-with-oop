#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:16:32 $
    $RCSfile: BinaryTree.lua,v $
    $Revision: 1.4 $

    $Id: BinaryTree.lua,v 1.4 2004/11/25 02:16:32 brpreiss Exp $

--]]

require "Tree"

--{
-- A binary tree.
BinaryTree = Class.new("BinaryTree", Tree)

-- Constructor.
-- @param key An object.
-- @param left A binary tree.
-- @param right A binary tree.
function BinaryTree.methods:initialize(key, left, right)
    BinaryTree.super(self)
    if key then
	self.key = key
	self.left = left or BinaryTree.new()
	self.right = right or BinaryTree.new()
    else
	self.key = nil
	self.left = nil
	self.right = nil
    end
end

-- Purges this binary tree.
function BinaryTree.methods:purge()
    self.key = nil
    self.left = nil
    self.right = nil
end
--}>a

--{
-- The left subtree of this binary tree node.
function BinaryTree.methods:get_left()
    if self:is_empty() then
	error "StateError"
    end
    return self.left
end

-- The right subtree of this binary tree node.
function BinaryTree.methods:get_right()
    if self:is_empty() then
	error "StateError"
    end
    return self.right
end
--}>b

--{
-- Calls the given visitor function for each key in this tree
-- in the order of a depth-first traversal of this tree.
-- @param visitor A visitor function.
function BinaryTree.methods:depthFirstTraversal(visitor)
    if not self:is_empty() then
	visitor(self.key, Tree.PREVISIT)
	self.left:depthFirstTraversal(visitor)
	visitor(self.key, Tree.INVISIT)
	self.right:depthFirstTraversal(visitor)
	visitor(self.key, Tree.POSTVISIT)
    end
end
--}>c

--{
-- Compares this binary tree with the given binary tree.
-- @param bt The binary tree to compare.
function BinaryTree.methods:compare(bt)
    assert( self:is_a(bt.class) )
    if self:is_empty() then
	if bt:is_empty() then
	    return 0
	else
	    return -1
	end
    elseif bt:is_empty() then
	return 1
    else
	result = self.key:compare(bt.key)
	if result == 0 then
	    result = self.left:compare(bt.left)
	end
	if result == 0 then
	    result = self.right:compare(bt.right)
	end
	return result
    end
end
--}>d

-- True if this binary tree node is a leaf node.
function BinaryTree.methods:is_leaf()
    return not self:is_empty() and
	    self.left:is_empty() and self.right:is_empty()
end

-- The degree of this binary tree node.
function BinaryTree.methods:get_degree()
    if self:is_empty() then
	return 0
    else
	return 2
    end
end

-- True if this binary tree node is empty.
function BinaryTree.methods:is_empty()
    return self.key == nil
end

-- The key in this binary tree node.
function BinaryTree.methods:get_key()
    if self:is_empty() then
	error "StateError"
    end
    return self.key
end

-- The specified subtree of this binary tree node.
-- @param i An index in the range 0..1.
function BinaryTree.methods:get_subtree(i)
    if i == 0 then
	return self.left
    elseif i == 1 then
	return self.right
    else
	error "IndexError"
    end
end

-- Attaches the given key to this binary tree node.
-- @param Obj An object.
function BinaryTree.methods:attachKey(obj)
    if not self:is_empty() then
	error "StateError"
    end
    self.key = obj
    self.left = BinaryTree.new()
    self.right = BinaryTree.new()
end

-- Detaches the key from this binary tree node.
function BinaryTree.methods:detachKey()
    if not self:is_leaf() then
	error "StateError"
    end
    result = self.key
    self.key = nil
    self.left = nil
    self.right = nil
    return result
end

-- Attaches the given tree as the left subtre of this binary tree node.
-- @param t A binary tree.
function BinaryTree.methods:attachLeft(t)
    if self:is_empty() or not self.left:is_empty() then
	raise "StateError"
    end
    self.left = t
end

-- Detaches and returns the left subtree of this binary tree node.
function BinaryTree.methods:detachLeft()
    if self:is_empty() then
	error "StateError"
    end
    result = self.left
    self.left = BinaryTree.new()
    return result
end

-- Attaches the given tree as the right subtre of this binary tree node.
-- @param t A binary tree.
function BinaryTree.methods:attachRight(t)
    if self:is_empty() or not self.right:is_empty() then
	error "StateError"
    end
    self.right = t
end

-- Detaches and returns the right subtree of this binary tree node.
function BinaryTree.methods:detachRight()
    if self:is_empty() then
	raise "StateErorr"
    end
    result = self.right
    self.right = BinaryTree.new()
    return result
end

-- BinaryTree test program.
-- @param arg Command-line arguments.
function BinaryTree.main(arg)
    print "BinaryTree test program."
    print(BinaryTree)
    local bt = BinaryTree.new(box(4))
    bt:attachLeft(BinaryTree.new(box(2)))
    bt:attachRight(BinaryTree.new(box(6)))
    Tree.test(bt)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BinaryTree.main(arg) )
end
