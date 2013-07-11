#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: BinaryInsertionSorter.lua,v $
    $Revision: 1.2 $

    $Id: BinaryInsertionSorter.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Sorter"

--{
-- Binary insertion sorter.
BinaryInsertionSorter =
    Class.new("BinaryInsertionSorter", Sorter)

-- Constructor.
function BinaryInsertionSorter.methods:initialize()
    BinaryInsertionSorter.super(self)
end

-- Sorts the elements of the array.
function BinaryInsertionSorter.methods:doSort()
    for i = 1, self.n - 1 do
	local tmp = self.array[i]
	local left = 0
	local right = i
	while left < right do
	    local middle = math.floor((left + right) / 2)
	    if tmp >= self.array[middle] then
		left = middle + 1
	    else
		right = middle
	    end
	end
	j = i
	while j > left do
	    self:swap(j - 1, j)
	    j = j - 1
	end
    end
end
--}>a

-- BinaryInsertionSorter test program.
-- @param arg Command-line arguments.
function BinaryInsertionSorter.main(arg)
    print "BinaryInsertionSorter test program."
    Sorter.test(BinaryInsertionSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BinaryInsertionSorter.main(arg) )
end
