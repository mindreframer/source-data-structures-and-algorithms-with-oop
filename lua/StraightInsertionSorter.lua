#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 20:04:16 $
    $RCSfile: StraightInsertionSorter.lua,v $
    $Revision: 1.3 $

    $Id: StraightInsertionSorter.lua,v 1.3 2004/12/05 20:04:16 brpreiss Exp $

--]]

require "Sorter"

--{
--++
-- Straight insertion sorter.
StraightInsertionSorter =
    Class.new("StraightInsertionSorter", Sorter)

-- Constructor.
function StraightInsertionSorter.methods:initialize()
    StraightInsertionSorter.super(self)
end

-- Sorts the elements of the array.
function StraightInsertionSorter.methods:doSort()
    for i = 1, self.n - 1 do
	local j = i
	while j > 0 and self.array[j - 1] > self.array[j] do
	    self:swap(j, j - 1)
	    j = j - 1
	end
    end
end
--}>a

-- StraightInsertionSorter test program.
function StraightInsertionSorter.main(arg)
    print "StraightInsertionSorter test program."
    Sorter.test(StraightInsertionSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( StraightInsertionSorter.main(arg) )
end
