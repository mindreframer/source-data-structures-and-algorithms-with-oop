#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 02:35:40 $
    $RCSfile: BinarySearchTree.lua,v $
    $Revision: 1.1 $

    $Id: BinarySearchTree.lua,v 1.1 2004/11/26 02:35:40 brpreiss Exp $

--]]

require "BinaryTree"
require "SearchTree"

----{
--++
-- A binary search tree.
BinarySearchTree = Class.new("BinarySearchTree", BinaryTree)

BinarySearchTree:include(SearchTreeMethods)

-- Constructor.
-- @param key A key.
-- @param left A binary search tree.
-- @param right A binary search tree.
function BinarySearchTree.methods:initialize(key, left, right)
    BinarySearchTree.super(self, key, left, right)
end
--}>a

--{
-- Returns the object in this binary search tree
-- that equals the given object.
-- @param obj The object to find.
function BinarySearchTree.methods:find(obj)
    if self:is_empty() then
	return nil
    end
    diff = obj:cmp(self.key)
    if diff == 0 then
	return self.key
    elseif diff < 0 then
	return self.left:find(obj)
    elseif diff > 0 then
	return self.right:find(obj)
    end
end

-- Returns the smallest object in this binary search tree.
function BinarySearchTree.methods:get_min()
    if self:is_empty() then
	return nil
    elseif self.left:is_empty() then
	return self.key
    else
	return self.left:get_min()
    end
end
--}>b

--{
-- Inserts the given object into this binary search tree.
-- @param obj The object to insert.
function BinarySearchTree.methods:insert(obj)
    if self:is_empty() then
	self:attachKey(obj)
    else
	diff = obj:cmp(self.key)
	if diff == 0 then
	    error "ArgumentError"
	elseif diff < 0 then
	    self.left:insert(obj)
	elseif diff > 0 then
	    self.right:insert(obj)
	end
    end
    self:balance()
end

-- Attaches the given key to this binary search tree node.
-- @param obj An object.
function BinarySearchTree.methods:attachKey(obj)
    if not self:is_empty() then
	error "StateError"
    end
    self.key = obj
    self.left = BinarySearchTree.new()
    self.right = BinarySearchTree.new()
end

-- Balances this binary search tree.
-- This method does nothing. It is may be overridden in derived classes.
function BinarySearchTree.methods:balance()
end
--}>c

--{
-- Withdraws the given object from this binary search tree.
-- @param obj The object to withdraw.
function BinarySearchTree.methods:withdraw(obj)
    if self:is_empty() then
	error "ArgumentError"
    end
    diff = obj:cmp(self.key)
    if diff == 0 then
	if not self.left:is_empty() then
	    local max = self.left:get_max()
	    self.key = max
	    self.left:withdraw(max)
	elseif not self.right:is_empty() then
	    local min = self.right:get_min()
	    self.key = min
	    self.right:withdraw(min)
	else
	    self:detachKey()
	end
    elseif diff < 0 then
	self.left:withdraw(obj)
    elseif diff > 0 then
	self.right:withdraw(obj)
    end
    self:balance()
end
--}>d

-- Returns the largest object in this binary search tree.
function BinarySearchTree.methods:get_max()
    if self:is_empty() then
	return nil
    elseif self.right:is_empty() then
	return self.key
    else
	return self.right:get_max()
    end
end

-- True if the given object is in this binary search tree.
-- @param obj An object.
function BinarySearchTree.methods:contains(obj)
    if self:is_empty() then
	return false
    elseif self.key:is(obj) then
	return true
    elseif obj < self.key then
	return self.left.contains(obj)
    elseif obj > self.key then
	return self.right.contains(obj)
    else
	return false
    end
end

-- BinarySearchTree test program.
-- @param arg Command-line arguments.
function BinarySearchTree.main(arg)
    print "BinarySearchTree test program."
    print(BinarySearchTree)
    local tree = BinarySearchTree.new()
    SearchTree.test(tree)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BinarySearchTree.main(arg) )
end
