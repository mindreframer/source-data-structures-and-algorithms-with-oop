#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 18:58:15 $
    $RCSfile: PartitionAsForest.lua,v $
    $Revision: 1.1 $

    $Id: PartitionAsForest.lua,v 1.1 2004/11/27 18:58:15 brpreiss Exp $

--]]

require "Partition"
require "Tree"
require "Set"
require "Array"

--{
-- A partition implemented as a forest of trees.
PartitionAsForest = Class.new("PartitionAsForest", Partition)

-- Constructs a partition with the given universe size.
-- @param n The size of the universal set.
function PartitionAsForest.methods:initialize(n)
    PartitionAsForest.super(self, n)
    self.array = Array.new(self.universeSize)
    for item = 0, self.universeSize - 1 do
	self.array[item] = PartitionTree.new(self, item)
    end
    self.count = self.universeSize
end
--}>b

--{
-- Finds the partition element that contains the given item.
-- @param item An item of the universal set.
function PartitionAsForest.methods:find(item)
    local ptr = self.array[item]
    while ptr.parent do
	ptr = ptr.parent
    end
    return ptr
end
--}>c

--{
-- Joins the given elements of this partition.
-- @param s An element of this partition.
-- @param t An element of this partition.
function PartitionAsForest.methods:join(s, t)
    assert(self:contains(s) and s.parent == nil
	and self:contains(t) and t.parent == nil
	and s:is_not(t), "DomainError")
    t.parent = s
    self.count = self.count - 1
end
--}>d

--{
-- Represents an element of a partition.
PartitionTree = Class.new("PartitionTree", Tree)

-- Constructs a partition tree that is an element of the
-- given partition and contains the given item.
-- @param partition A partition.
-- @param item An item of the universal set.
function PartitionTree.methods:initialize(partition, item)
    PartitionTree.super(self)
    self.universeSize = partition.universeSize
    self.partition = partition
    self.item = item
    self.parent = nil
    self.rank = 0
    self.count = 1
end

-- The partition.
PartitionTree:attr_reader("partition")
-- The parent of this partition tree node.
PartitionTree:attr_accessor("parent")
-- The rank of this partition tree node
PartitionTree:attr_accessor("rank")
-- The number of items in this partition.
PartitionTree:attr_accessor("count")

-- Purges this partition tree.
function PartitionTree.methods:purge()
    self.parent = nil
    self.rank = 0
    self.count = 1
end

-- The number of items in this partition.
function PartitionTree.methods:get_count()
    return self.count
end

-- The height of this partition tree node.
function PartitionTree.methods:get_height()
    return self.rank
end

-- The item in this partition tree node.
function PartitionTree.methods:get_key()
    return self.item
end

-- Compares this partition tree node with the given partition tree node.
-- @param tree The partition tree node to be compared.
function PartitionTree.methods: compare(tree)
    return self.item - tree._item
end

-- Returns the hash value for this partition tree node.
function PartitionTree.methods:get_hash()
    return hash(self.item)
end

-- Returns a string representation of this partition tree node.
function PartitionTree.methods:toString()
    local s = tostring(self.item)
    if self.parent then
	s = s .. ", " .. tostring(self.parent)
    end
    return "{" .. s .. "}"
end

-- True if this partition tree is empty.
function PartitionTree.methods:is_empty()
    return false
end

-- Purges this partition.
function PartitionAsForest.methods:purge()
    for item = 0, self.universeSize - 1 do
	self.array[item]:purge()
    end
end

-- True if the object is an element of this partition.
function PartitionAsForest.methods:contains(obj)
    return obj.partition:is(self)
end

-- Calls the given visitor function for the items in the partition.
-- @param visitor A visitor function.
function PartitionAsForest.methods:each(visitor)
    for i = 0, self.universeSize - 1 do
	visitor(self.array[i])
    end
end

-- PartitionAsForest test program.
-- @param arg Command-line arguments.
function PartitionAsForest.main(arg)
    print "PartitionAsForest test program."
    print(PartitionAsForest)
    print(PartitionTree)
    Partition.test(PartitionAsForest.new(5))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( PartitionAsForest.main(arg) )
end
