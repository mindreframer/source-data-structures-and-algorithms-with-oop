#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 20:44:58 $
    $RCSfile: BubbleSorter.lua,v $
    $Revision: 1.1 $

    $Id: BubbleSorter.lua,v 1.1 2004/11/28 20:44:58 brpreiss Exp $

--]]

require "Sorter"

--{
-- Bubble sorter.
BubbleSorter = Class.new("BubbleSorter", Sorter)

-- Constructor.
function BubbleSorter.methods:initialize()
    BubbleSorter.super(self)
end

-- Sorts the elements of the array.
function BubbleSorter.methods:doSort()
    local i = self.n
    while i > 1 do
	for j = 0, i - 2 do
	    if self.array[j] > self.array[j + 1] then
		self:swap(j, j + 1)
	    end
	end
	i = i - 1
    end
end
--}>a

-- BubbleSorter test program.
-- @param arg Command-line arguments.
function BubbleSorter.main(arg)
    print "BubbleSorter test program."
    Sorter.test(BubbleSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( BubbleSorter.main(arg) )
end
