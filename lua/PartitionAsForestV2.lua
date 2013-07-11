#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: PartitionAsForestV2.lua,v $
    $Revision: 1.2 $

    $Id: PartitionAsForestV2.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "PartitionAsForest"

--{
-- Partition implemented as a forest of trees.
PartitionAsForestV2 =
    Class.new("PartitionAsForestV2", PartitionAsForest)

-- Returns the element of this partition that contains the given item.
-- (Collapsing find).
-- @param item An item of the universal set.
function PartitionAsForestV2.methods:find(item)
    local root = self.array[item]
    while root.parent do
	root = root.parent
    end
    local ptr = self.array[item]
    while ptr.parent do
	ptr, ptr.parent = ptr.parent, root
    end
    return root
end
--}>a

--{
-- Joins the given elements of this partition.
-- (Union by size).
-- @param s An element of this partition.
-- @param t An element of this partition.
function PartitionAsForestV2.methods:join(s, t)
    assert(self:contains(s) and s.parent == nil
	and self:contains(t) and t.parent == nil
	and s:is_not(t), "DomainError")
    if s.count > t.count then
	t.parent = s
	s.count = s.count + t.count
    else
	s.parent = t
	t.count = t.count + s.count
    end
    self.count = self.count - 1
end
--}>b

-- Constructs a partition with the given universe size.
-- @param n The size of the universal set.
function PartitionAsForestV2.methods:initialize(n)
    PartitionAsForestV2.super(self, n)
end

-- PartitionAsForestV2 test program.
-- @param arg Command-line arguments.
function PartitionAsForestV2.main(arg)
    print "PartitionAsForestV2 test program."
    print(PartitionAsForestV2)
    Partition.test(PartitionAsForestV2.new(5))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( PartitionAsForestV2.main(arg) )
end
