#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/29 00:58:33 $
    $RCSfile: Sorter.lua,v $
    $Revision: 1.2 $

    $Id: Sorter.lua,v 1.2 2004/11/29 00:58:33 brpreiss Exp $

--]]

require "Object"
require "Array"
require "RandomNumberGenerator"
require "Integer"
require "Timer"

--{
-- Abststract base class from which all sorters are derived.
Sorter = Class.new("Sorter", AbstractObject)

-- Constructor.
function Sorter.methods:initialize()
    Sorter.super(self)
    self.array = nil
    self.n = 0
end

-- The sort routine.
Sorter:abstract_method("doSort")

-- Sorts the elements of the given array.
-- @param array The array to be sorted.
function Sorter.methods:sort(array)
    assert(array:is_a(Array), "TypeError")
    self.array = array
    self.n = array:get_length()
    if self.n > 0 then
	self:doSort()
    end
    self.array = nil
end

-- Swaps the specified elements of the being sorted.
-- @param i An index.
-- @param j An index.
function Sorter.methods:swap(i, j)
    self.array[i], self.array[j] = self.array[j], self.array[i]
end
--}>a

-- Sorter test program.
-- @param sorter The sorter to test.
-- @param n The array size to test.
-- @param seed The seed for the random number generator.
-- @param m If given, data values are restricted to the interval [0,m-1].
function Sorter.test(sorter, n, seed, m)
    m = m or 0
    RandomNumberGenerator.instance:set_seed(seed)
    local data = Array.new(n)
    for i = 0, n - 1 do
	local datum = toint(RandomNumberGenerator.instance:next()
				* tonumber(Integer.MAX))
	if m ~= 0 then
	    datum = datum:mod(toint(m))
	end
	data[i] = datum
    end
    timer = Timer.new()
    timer:start()
    sorter:sort(data)
    timer:stop()
    datum = string.format("%s %d %d %g",
		class(sorter), n, seed, timer:elapsedTime())
    print(datum)
    io.stderr:write(datum .. "\n")
    for i = 1, n - 1 do
	if data[i] < data[i - 1] then
	    print "FAILED"
	    break
	end
    end
end
