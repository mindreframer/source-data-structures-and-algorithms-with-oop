#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:59 $
    $RCSfile: StraightSelectionSorter.lua,v $
    $Revision: 1.1 $

    $Id: StraightSelectionSorter.lua,v 1.1 2004/11/28 20:44:59 brpreiss Exp $

--]]

require "Sorter"

----{
--++
-- Straight selection sorter.
StraightSelectionSorter = Class.new("StraightSelectionSorter", Sorter)

-- Constructor.
function StraightSelectionSorter.methods:initialize()
    StraightSelectionSorter.super(self)
end

-- Sorts the elements of the array.
function StraightSelectionSorter.methods:doSort()
    local i = self.n
    while i > 1 do
	local max = 0
	for j = 0, i - 1 do
	    if self.array[j] > self.array[max] then
		max = j
	    end
	end
	self:swap(i - 1, max)
	i = i - 1
    end
end
--}>a

-- StraightSelectionSorter test program.
-- @param arg Command-line arguments.
function StraightSelectionSorter.main(arg)
    print "StraightSelectionSorter test program."
    Sorter.test(StraightSelectionSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( StraightSelectionSorter.main(arg) )
end
