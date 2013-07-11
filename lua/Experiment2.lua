#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 03:02:05 $
    $RCSfile: Experiment2.lua,v $
    $Revision: 1.1 $

    $Id: Experiment2.lua,v 1.1 2004/12/03 03:02:05 brpreiss Exp $

--]]

require "Demo9"

-- Provides experiment 2.
Experiment2 = Module.new("Experiment")

-- Program that measures the running times of various sorting algorithms.
-- @param arg Command-line arguments.
function Experiment2.main(arg)
    print "Experiment2 test program."
    print "4"
    print "sort"
    print "length"
    print "seed"
    print "time"
    local seeds = {"1", "57", "12345", "7252795", "3127"}
    for k, seed in pairs(seeds) do
	local lengths = {"10", "25", "50", "75",
	    "100", "250", "500", "750",
	    "1000", "1250", "1500", "1750", "2000"}
	for k, length in pairs(lengths) do
	    Demo9.main{length, seed, "7"}
	end
	lengths = {"3000", "4000", "5000", "6000",
	    "7000", "8000", "9000", "10000"}
	for k, length in pairs(lengths) do
	    Demo9.main{length, seed, "3"}
	end
	lengths = {"20000", "30000", "40000", "50000",
	    "60000", "70000", "80000", "90000", "100000"}
	for k, length in pairs(lengths) do
	    Demo9.main{length, seed, "1"}
	end
    end
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Experiment2.main(arg) )
end
