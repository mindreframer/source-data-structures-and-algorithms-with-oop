#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: MedianOfThreeQuickSorter.lua,v $
    $Revision: 1.2 $

    $Id: MedianOfThreeQuickSorter.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "QuickSorter"

--{
-- Median-of-three quick sorter.
MedianOfThreeQuickSorter =
    Class.new("MedianOfThreeQuickSorter", QuickSorter)

-- Constructor.
function MedianOfThreeQuickSorter.methods:initialize()
    MedianOfThreeQuickSorter.super(self)
end

-- Sorts the left, middle, and right array element
-- and returns the position of the middle element as the pivot.
-- @param left Index of left element.
-- @param right Index of right element.
function MedianOfThreeQuickSorter.methods:selectPivot(
						    left, right)
    local middle = math.floor((left + right) / 2)
    if self.array[left] > self.array[middle] then
	self:swap(left, middle)
    end
    if self.array[left] > self.array[right] then
	self:swap(left, right)
    end
    if self.array[middle] > self.array[right] then
	self:swap(middle, right)
    end
    return middle
end
--}>a

-- MedianOfThreeQuickSorter test program.
-- +argv+:: Command-line arguments.
function MedianOfThreeQuickSorter.main(arg)
    print "MedianOfThreeQuickSorter test program."
    Sorter.test(MedianOfThreeQuickSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( MedianOfThreeQuickSorter.main(arg) )
end
