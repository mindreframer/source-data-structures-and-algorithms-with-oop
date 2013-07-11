#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:58 $
    $RCSfile: HeapSorter.lua,v $
    $Revision: 1.1 $

    $Id: HeapSorter.lua,v 1.1 2004/11/28 20:44:58 brpreiss Exp $

--]]

require "Sorter"

--{
-- Heap sorter.
HeapSorter = Class.new("HeapSorter", Sorter)

-- Constructor.
function HeapSorter.methods:initialize()
    HeapSorter.super(self)
end


-- Percolates down the elements in the array with the given length
-- and starting at the given position.
-- @param i Start index.
-- @param j Length of array.
function HeapSorter.methods:percolateDown(i, length)
    while 2 * i <= length do
	local j = 2 * i
	if j < length and self.array[j + 1] > self.array[j] then
	    j = j + 1
	end
	if self.array[i] >= self.array[j] then
	    break
	end
	self:swap(i, j)
	i = j
    end
end
--}>a

--{
-- Builds the heap.
function HeapSorter.methods:buildHeap()
    local i = math.floor(self.n / 2)
    while i > 0 do
	self:percolateDown(i, self.n)
	i = i - 1
    end
end
--}>b

--{
-- Sorts the elements of the array.
function HeapSorter.methods:doSort()
    local base = self.array:get_baseIndex()
    self.array:set_baseIndex(1)
    self:buildHeap()
    local i = self.n
    while i >= 2 do
	self:swap(i, 1)
	self:percolateDown(1, i - 1)
	i = i - 1
    end
    self.array:set_baseIndex(base)
end
--}>c

-- HeapSorter test program.
-- @param arg Command-line arguments.
function HeapSorter.main(arg)
    print "HeapSorter test program."
    Sorter.test(HeapSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( HeapSorter.main(arg) )
end
