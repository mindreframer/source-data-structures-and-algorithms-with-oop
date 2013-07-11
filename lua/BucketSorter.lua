#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:58 $
    $RCSfile: BucketSorter.lua,v $
    $Revision: 1.1 $

    $Id: BucketSorter.lua,v 1.1 2004/11/28 20:44:58 brpreiss Exp $

--]]

require "Sorter"
require "Array"

--{
-- Bucket sorter.
BucketSorter = Class.new("BucketSorter", Sorter)

-- Constructs a bucket sorter with the given number of buckets.
-- @param m The number of buckets.
function BucketSorter.methods:initialize(m)
    BucketSorter.super(self)
    self.m = m
    self.count = Array.new(self.m)
end
--}>a

--{
-- Sorts the elements of the array.
function BucketSorter.methods:doSort()
    for i = 0, self.m - 1 do
	self.count[i] = 0
    end
    for j = 0, self.n - 1 do
	self.count[self.array[j]] = self.count[self.array[j]] + 1
    end
    local j = 0
    for i = 0, self.m - 1 do
	while self.count[i] > 0 do
	    self.array[j] = i
	    j = j + 1
	    self.count[i] = self.count[i] - 1
	end
    end
end
--}>b

-- BucketSorter test program.
function BucketSorter.main(arg)
    print "BucketSorter test program."
    Sorter.test(BucketSorter.new(1024), 100, 123, 1024)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BucketSorter.main(arg) )
end
