#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:59 $
    $RCSfile: TwoWayMergeSorter.lua,v $
    $Revision: 1.1 $

    $Id: TwoWayMergeSorter.lua,v 1.1 2004/11/28 20:44:59 brpreiss Exp $

--]]

require "Sorter"
require "Array"

--{
-- Two-way merge sorter.
TwoWayMergeSorter = Class.new("TwoWayMergeSorter", Sorter)

-- Constructor.
function TwoWayMergeSorter.methods:initialize()
    TwoWayMergeSorter.super(self)
    self.tempArray = nil
end
--}>a

--{
-- Merges two sorted sub-arrays,
-- array[left] ... array[middle] and
-- array[middle + 1] ... array[right]
-- using the temporary array.
-- @param left The left index.
-- @param middle The middle index.
-- @param right The right index.
function TwoWayMergeSorter.methods:merge(left, middle, right)
    local i = left
    local j = left
    local k = middle + 1
    while j <= middle and k <= right do
	if self.array[j] < self.array[k] then
	    self.tempArray[i] = self.array[j]
	    i = i + 1
	    j = j + 1
	else
	    self.tempArray[i] = self.array[k]
	    i = i + 1
	    k = k + 1
	end
    end
    while j <= middle do
	self.tempArray[i] = self.array[j]
	i = i + 1
	j = j + 1
    end
    for i = left, k - 1 do
	self.array[i] = self.tempArray[i]
    end
end
--}>b

--{
-- Sorts the elements of the array.
function TwoWayMergeSorter.methods:doSort()
    self.tempArray = Array.new(self.n)
    self:mergesort(0, self.n - 1)
    self.tempArray = nil
end

-- Recursively sorts the elements of the array
-- between the left and right indices.
-- @param left The left index.
-- @param right The right index.
function TwoWayMergeSorter.methods:mergesort(left, right)
    if left < right then
	local middle = math.floor((left + right) / 2)
	self:mergesort(left, middle)
	self:mergesort(middle + 1, right)
	self:merge(left, middle, right)
    end
end
--}>c

-- TwoWayMergeSorter test program
-- @param arg Command-line arguments.
function TwoWayMergeSorter.main(arg)
    print "TwoWayMergeSorter test program."
    Sorter.test(TwoWayMergeSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( TwoWayMergeSorter.main(arg) )
end
