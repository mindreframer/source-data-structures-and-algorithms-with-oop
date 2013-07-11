#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:59 $
    $RCSfile: QuickSorter.lua,v $
    $Revision: 1.1 $

    $Id: QuickSorter.lua,v 1.1 2004/11/28 20:44:59 brpreiss Exp $

--]]

require "Sorter"
require "StraightInsertionSorter"

--{
-- Abstract quick sorter base class.
QuickSorter = Class.new("QuickSorter", Sorter)

-- Constructor.
function QuickSorter.methods:initialize()
    QuickSorter.super(self)
end

-- Selects a pivot element between the given left and right indices.
-- @param left The left index.
-- @param right The right index.
QuickSorter:abstract_method("selectPivot")
--}>a

--{
-- Stop recursion when array size is less than or equal to CUTOFF.
QuickSorter.CUTOFF = 2 -- minimum cut-off

-- Recursively sorts the elements of the array
-- between the left and right indices.
-- @param left The left index.
-- @param right The right index.
function QuickSorter.methods:quicksort(left, right)
    if right - left + 1 > QuickSorter.CUTOFF then
	local p = self:selectPivot(left, right)
	self:swap(p, right)
	local pivot = self.array[right]
	local i = left
	local j = right - 1
	while true do
	    while i < j and self.array[i] < pivot do
		i = i + 1
	    end
	    while i < j and self.array[j] > pivot do
		j = j - 1
	    end
	    if i >= j then
		break
	    end
	    self:swap(i, j)
	    i = i + 1
	    j = j - 1
	end
	if self.array[i] > pivot then
	    self:swap(i, right)
	end
	if left < i then
	    self:quicksort(left, i - 1)
	end
	if right > i then
	    self:quicksort(i + 1, right)
	end
    end
end
--}>b

--{
-- Sorts the elements of the array.
function QuickSorter.methods:doSort()
    self:quicksort(0, self.n - 1)
    StraightInsertionSorter.new():sort(self.array)
end
--}>c
