#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:47:07 $
    $RCSfile: Experiment1.lua,v $
    $Revision: 1.1 $

    $Id: Experiment1.lua,v 1.1 2004/12/03 02:47:07 brpreiss Exp $

--]]

require "Example"
require "Timer"

-- Provides experiment 1.
Experiment1 = Module.new("Experiment1")

-- Program that measures the running times of both
-- a recursive and a non-recursive method to compute
-- the Fibonacci numbers.
-- @param arg Command-line arguments.
function Experiment1.main(arg)
    print "Experiment1 test program."
    print "3"
    print "n"
    print "fib1 s"
    print "fib2 s"
    local timer1 = Timer.new()
    local timer2 = Timer.new()
    for i = 0, 48 do
	timer1:start()
	local result = fibonacci1(i)
	timer1:stop()

	timer2:start()
	result = fibonacci2(i)
	timer2:stop()

	local datum = string.format("%d\t%g\t%g",
	    i, timer1:elapsedTime(), timer2:elapsedTime())
	print(datum)
	io.stderr:write(datum .. "\n")
    end
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Experiment1.main(arg) )
end
