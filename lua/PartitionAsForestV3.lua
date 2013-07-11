#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: PartitionAsForestV3.lua,v $
    $Revision: 1.2 $

    $Id: PartitionAsForestV3.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "PartitionAsForestV2"

--{
-- Partition implemented as a forest of trees.
PartitionAsForestV3 =
    Class.new("PartitionAsForestV3", PartitionAsForestV2)

-- Joins the given elements of this partition.
-- (Union by rank).
-- @param s An element of this partition.
-- @param t An element of this partition.
function PartitionAsForestV3.methods:join(s, t)
    assert(self:contains(s) and s.parent == nil
	and self:contains(t) and t.parent == nil
	and s:is_not(t), "DomainError")
    if s.rank > t.rank then
	t.parent = s
    else
	s.parent = t
	if s.rank == t.rank then
	    t.rank = t.rank + 1
	end
    end
    self.count = self.count - 1
end
--}>a

-- Constructs a partition with the given size.
-- +n+:: The size of universal set.
function PartitionAsForestV3.methods:initialize(n)
    PartitionAsForestV3.super(self, n)
end

-- PartitionAsForestV3 test program.
-- @param arg Command-line arguments.
function PartitionAsForestV3.main(arg)
    print "PartitionAsForestV3 test program."
    print(PartitionAsForestV3)
    Partition.test(PartitionAsForestV3.new(5))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( PartitionAsForestV3.main(arg) )
end
