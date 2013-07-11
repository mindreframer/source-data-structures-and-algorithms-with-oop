#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:05:25 $
    $RCSfile: GeneralTree.lua,v $
    $Revision: 1.3 $

    $Id: GeneralTree.lua,v 1.3 2004/11/25 02:05:25 brpreiss Exp $

--]]

require "Tree"
require "LinkedList"

--{
-- A general tree implemented using a linked-list of subtrees.
GeneralTree = Class.new("GeneralTree", Tree)

-- Constructs a general tree node that contains the given key.
-- @param key An object.
function GeneralTree.methods:initialize(key)
    GeneralTree.super(self)
    self.key = key
    self.degree = 0
    self.list = LinkedList.new()
end

-- Purges this general tree.
function GeneralTree.methods:purge()
    self.list.purge()
    self.degree = 0
end
--}>a

--{
-- The key in this general tree node.
GeneralTree:attr_reader("key")

-- Returns the specified subtree of this general tree node.
-- @param i An index.
function GeneralTree.methods:get_subtree(i)
    if i < 0 or i >= self.degree then
	error "IndexError"
    end
    ptr = self.list:get_head()
    for j = 1, i do
	ptr = ptr:get_succ()
    end
    return ptr:get_datum()
end

-- Attaches the given general tree to this general tree node.
-- @param t A general tree.
function GeneralTree.methods:attachSubtree(t)
    self.list:append(t)
    self.degree = self.degree + 1
end

-- Detaches and returns the specified subtree of this general tree node.
function GeneralTree.methods:detachSubtree(t)
    self.list:extract(t)
    self.degree = self.degree - 1
    return t
end
--}>b

-- True if this general tree node is empty.
-- Alwasy returns false because general tree nodes cannot be empty.
function GeneralTree.methods:is_empty()
    return false
end

-- True if this general tree node is a leaf.
function GeneralTree.methods:is_leaf()
    return self.degree == 0
end

-- The degree of this general tree node.
GeneralTree:attr_reader("degree")

-- GeneralTree test program.
-- @param arg Command-line arguments.
function GeneralTree.main(arg)
    print "GeneralTree test program."
    print(GeneralTree)
    local gt = GeneralTree.new(box'A')
    gt:attachSubtree(GeneralTree.new(box'B'))
    gt:attachSubtree(GeneralTree.new(box'C'))
    gt:attachSubtree(GeneralTree.new(box'D'))
    gt:attachSubtree(GeneralTree.new(box'E'))
    Tree.test(gt)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( GeneralTree.main(arg) )
end
