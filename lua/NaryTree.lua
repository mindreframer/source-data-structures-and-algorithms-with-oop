#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 02:16:14 $
    $RCSfile: NaryTree.lua,v $
    $Revision: 1.1 $

    $Id: NaryTree.lua,v 1.1 2004/11/26 02:16:14 brpreiss Exp $

--]]

require "Tree"
require "Array"

--{
-- N-ary tree impelemented using an array.
NaryTree = Class.new("NaryTree", Tree)

-- Constructor.
-- @param n The degree.
-- @param key An object.
function NaryTree.methods:initialize(n, key) -- :args: n [, key]
    NaryTree.super(self)
    if key then
	self.degree = n
	self.key = key
	self.subtree = Array.new(self.degree)
	for i = 0, self.degree - 1 do
	    self.subtree[i] = NaryTree.new(self.degree)
	end
    else
	self.degree = n
	self.key = nil
	self.subtree = nil
    end
end

-- Purges this N-ary tree.
function NaryTree.methods:purge()
    self.key = nil
    self.subtree = nil
end
--}>a

--{
-- True if this N-ary tree is empty.
function NaryTree.methods:is_empty()
    return self.key == nil
end

-- The key in this N-ary tree node.
function NaryTree.methods:get_key()
    if self:is_empty() then
	error "StateError"
    end
    return self.key
end

-- Attaches the given key to this N-ary tree node.
-- @param Obj An object.
function NaryTree.methods:attachKey(obj)
    if not self:is_empty() then
	error "StateError"
    end
    self.key = obj
    self.subtree = Array.new(degree)
    for i = 0, self.degree - 1 do
	self.subtree[i] = NaryTree.new(degree)
    end
end

-- Detaches and returns the key of thsi N-ary tree node.
function NaryTree.methods:detachKey()
    if not self:is_leaf() then
	error "StateError"
    end
    result = self.key
    self.key = nil
    self.subtree = nil
    return result
end
--}>b

--{
-- Returns the specified subtree of this N-ary tree node.
-- @param i An index.
function NaryTree.methods:get_subtree(i)
    if self:is_empty() then
	error "StateError"
    end
    return self.subtree[i]
end

-- Attaches the given N-ary tree
-- as the specified subtree of this N-ary tree node.
-- @param i An index.
-- @param t An N-ary subtree.
function NaryTree.methods:attachSubtree(i, t)
    if self:is_empty() or not self.subtree[i]:is_empty() then
	error "StateError"
    end
    self.subtree[i] = t
end

-- Detaches and returns the specified subtree of this N-ary tree node.
-- +i+:: An index.
function NaryTree.methods:detachSubtree(i)
    if self:is_empty() then
	error "StateError"
    end
    result = self.subtree[i]
    self.subtree[i] = NaryTree.new(degree)
    return result
end
--}>c

-- The degree of this N-ary tree node.
function NaryTree.methods:get_degree()
    if self:is_empty() then
	return 0
    else
	return self.degree
    end
end

-- True if this N-ary tree is a leaf node.
function NaryTree.methods:is_leaf()
    if self:is_empty() then
	return false
    end
    for i = 0, self.degree - 1 do
	if not self.subtree[i].is_empty() then
	    return false
	end
    end
    return true
end

-- NaryTree test program.
-- @param arg Command-line arguments.
function NaryTree.main(arg)
    print "NaryTree test program."
    print(NaryTree)
    local nt = NaryTree.new(3, 1)
    nt:attachSubtree(0, NaryTree.new(3, 2))
    nt:attachSubtree(1, NaryTree.new(3, 3))
    nt:attachSubtree(2, NaryTree.new(3, 4))
    Tree.test(nt)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( NaryTree.main(arg) )
end
