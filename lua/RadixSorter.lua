#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: RadixSorter.lua,v $
    $Revision: 1.2 $

    $Id: RadixSorter.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Sorter"
require "Array"

--{
-- Radix sorter.
RadixSorter = Class.new("RadixSorter", Sorter)

-- The number of bits in the radix.
RadixSorter.r = toint(8)

-- The radix.
RadixSorter.R = toint(1):lshift(RadixSorter.r)

-- Number of passes.
RadixSorter.p = (toint(Integer.BITS)
		    + RadixSorter.r - toint(1)) / RadixSorter.r

-- Constructor
function RadixSorter.methods:initialize()
    RadixSorter.super(self)
    self.count = Array.new(RadixSorter.R)
    self.tempArray = nil
end
--}>a

--{
-- Sorts the elements of the array.
function RadixSorter.methods:doSort()
    local RM1 = toint(RadixSorter.R)-toint(1)
    self.tempArray = Array.new(self.n)
    for i = 0, tonumber(RadixSorter.p) - 1 do
	for j = 0, tonumber(RadixSorter.R) - 1 do
	    self.count[j] = 0
	end
	local shift = RadixSorter.r*toint(i)
	for k = 0, self.n - 1 do
	    local index = self.array[k]:rshift(shift):AND(RM1)
	    self.count[index] = self.count[index] + 1
	    self.tempArray[k] = self.array[k]
	end
	local pos = 0
	for j = 0, tonumber(RadixSorter.R) - 1 do
	    local tmp = pos
	    pos = pos + self.count[j]
	    self.count[j] = tmp
	end
	for k = 0, self.n - 1 do
	    local index =
		    self.tempArray[k]:rshift(shift):AND(RM1)
	    self.array[self.count[index]] = self.tempArray[k]
	    self.count[index] = self.count[index] + 1
	end
    end
end
--}>b

-- RadixSorter test program.
-- @param arg Command-line arguments.
function RadixSorter.main(arg)
    print "RadixSorter test program."
    Sorter.test(RadixSorter.new(), 100, 123)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( RadixSorter.main(arg) )
end
