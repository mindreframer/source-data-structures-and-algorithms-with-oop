#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo9.lua,v $
    $Revision: 1.2 $

    $Id: Demo9.lua,v 1.2 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "Sorter"
require "StraightInsertionSorter"
require "BinaryInsertionSorter"
require "BubbleSorter"
require "StraightSelectionSorter"
require "MedianOfThreeQuickSorter"
require "HeapSorter"
require "TwoWayMergeSorter"
require "BucketSorter"
require "RadixSorter"

-- Provides demonstration program number 9.
Demo9 = Module.new("Demo9")

-- Demonstration program number 9.
-- @param arg Command-line arguments.
function Demo9.main(arg)
    print "Demonstration program number 9."
    if table.getn(arg) ~= 3 then
	printf("usage: %s size seed mask", arg[0])
	os.exit(1)
    end
    local n = tonumber(arg[1])
    local seed = tonumber(arg[2])
    local mask = toint(tonumber(arg[3]))
    if mask:AND(toint(4)) ~= toint(0) then
	Sorter.test(StraightInsertionSorter.new(), n, seed)
	Sorter.test(BinaryInsertionSorter.new(), n, seed)
	Sorter.test(BubbleSorter.new(), n, seed)
	Sorter.test(StraightSelectionSorter.new(), n, seed)
    end
    if mask:AND(toint(2)) ~= toint(0) then
	Sorter.test(MedianOfThreeQuickSorter.new(), n, seed)
	Sorter.test(HeapSorter.new(), n, seed)
	Sorter.test(TwoWayMergeSorter.new(), n, seed)
    end
    if mask:AND(toint(1)) ~= toint(0) then
	Sorter.test(BucketSorter.new(1024), n, seed, 1024)
	Sorter.test(RadixSorter.new(), n, seed)
    end
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo9.main(arg) )
end
