#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 18:58:15 $
    $RCSfile: Partition.lua,v $
    $Revision: 1.1 $

    $Id: Partition.lua,v 1.1 2004/11/27 18:58:15 brpreiss Exp $

--]]

require "Set"

--{
-- Abstract base class from which all partition classes are derived.
Partition = Class.new("Partition", Set)

-- Constructs a partition with the given universe size.
-- +n+:: The size of the universal set.
function Partition.methods:initialize(n)
    Partition.super(self, n)
end

-- Returns the partition element that contains the given item.
-- +item+:: An item of the universal set.
Partition:abstract_method("find")

-- Joins the given partition elements.
-- +s+:: An element of the partition.
-- +t+:: An element of the partition.
Partition:abstract_method("join")
--}>a

-- Partition test program.
-- @param p The partition to test.
function Partition.test(p)
    print "Partition test program."
    print(p)
    local s2 = p:find(2)
    print(s2)
    local s4 = p:find(4)
    print(s4)
    p:join(s2, s4)
    print(p)
    local s3 = p:find(3)
    print(s3)
    local s4b = p:find(4)
    print(s4b)
    p:join(s3, s4b)
    print(p)
end
