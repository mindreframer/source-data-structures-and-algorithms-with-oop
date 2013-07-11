#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: BTree.lua,v $
    $Revision: 1.2 $

    $Id: BTree.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "MWayTree"
require "SearchTree"

--{
-- A B-tree.
BTree = Class.new("BTree", MWayTree)

-- Constructs a B-tree with the given order m.
-- @param m The order of the B-tree.
function BTree.methods:initialize(m)
    BTree.super(self, m)
    self.parent = nil
end

-- Attaches the given tree
-- as the specified subtree of this B-tree node.
-- @param i An index.
-- @param t A B-tree node.
function BTree.methods:attachSubtree(i, t)
    self.subtree[i] = t
    t.parent = self
end

-- The parent of this B-tree node.
BTree:attr_accessor("parent")
--}>a

--{
-- Inserts the given object in this B-tree.
-- +obj+:: The object to insert.
function BTree.methods:insert(obj)
    if self:is_empty() then
	if self.parent == nil then
	    self:attachSubtree(0, BTree.new(self:get_m()))
	    self.key[1] = obj
	    self:attachSubtree(1, BTree.new(self:get_m()))
	    self.count = 1
	else
	    self.parent:insertUp(obj, BTree.new(self:get_m()))
	end
    else
	local index = self:findIndex(obj)
	if index ~= 0 and self.key == obj then
	    error "ArgumentError"
	end
	self.subtree[index]:insert(obj)
    end
end
--}>b

--{
-- Inserts the given (object, B-tree) pair into this B-tree.
-- @param obj An object.
-- @param child A B-tree.
function BTree.methods:insertUp(obj, child)
    local index = self:findIndex(obj)
    if not self:is_full() then
	self:insertPair(index + 1, obj, child)
	self.count = self.count + 1
    else
	local extraKey, extraTree =
			self:insertPair(index+1, obj, child)
	if self.parent == nil then
	    local left = BTree.new(self:get_m())
	    local right = BTree.new(self:get_m())
	    left:attachLeftHalfOf(self)
	    right:attachRightHalfOf(self)
	    right:insertUp(extraKey, extraTree)
	    self:attachSubtree(0, left)
	    self.key[1] =
		    self.key[math.floor((self:get_m() + 1)/2)]
	    self:attachSubtree(1, right)
	    self.count = 1
	else
	    self.count = math.floor((self:get_m() + 1)/2) - 1
	    local right = BTree.new(self:get_m())
	    right:attachRightHalfOf(self)
	    right:insertUp(extraKey, extraTree)
	    self.parent:insertUp(self.key[
		    math.floor((self:get_m() + 1)/2)], right)
	end
    end
end
--}>c

-- Inserts the given object and subtree at the specified index
-- in the key and subtree arrays of this B-tree node
-- and returns any leftover key and subtree.
-- @param index The position at which to insert the pair.
-- @param obj An object.
-- @param child A B-tree.
function BTree.methods:insertPair(index, obj, child)
    if index == self:get_m() then
	return obj, child
    end
    local result = {self.key[self:get_m() - 1],
		    self.subtree[self:get_m() - 1]}
    local i = self:get_m() - 1
    while i > index do
	self.key[i] = self.key[i - 1]
	self.subtree[i] = self.subtree[i - 1]
	i = i - 1
    end
    self.key[index] = obj
    self.subtree[index] = child
    child.parent = self
    return unpack(result)
end

-- Attaches the left half of the given B-tree
-- to this B-tree node.
-- @param btree A B-tree.
function BTree.methods:attachLeftHalfOf(btree)
    self.count = math.floor((self:get_m() + 1)/2) - 1
    self:attachSubtree(0, btree:get_subtree(0))
    for i = 1, self.count do
	self.key[i] = btree:get_key(i)
	self:attachSubtree(i, btree:get_subtree(i))
    end
end

-- Attaches the right half of the given B-tree
-- to this B-tree node.
-- @param btree A B-tree.
function BTree.methods:attachRightHalfOf(btree)
    self.count = self:get_m() -
			    math.floor((self:get_m() + 1)/2) - 1
    local j = math.floor((self:get_m() + 1)/2)
    self:attachSubtree(0, btree:get_subtree(j))
    j = j + 1
    for i = 1, self.count do
	self.key[i] = btree:get_key(j)
	self:attachSubtree(i, btree:get_subtree(j))
    end
end

-- Withdraws the given object from this B-tree.
-- @param obj The object to withdraw.
function BTree.methods:withdraw(obj)
    error "NotImplementedError"
end

-- BTree test program.
-- @param arg Command-line arguments.
function BTree.main(arg)
    print "BTree test program."
    print(BTree)
    local tree = BTree.new(3)
    SearchTree.test(tree)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BTree.main(arg) )
end
