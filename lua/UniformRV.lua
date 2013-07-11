#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 18:26:55 $
    $RCSfile: UniformRV.lua,v $
    $Revision: 1.1 $

    $Id: UniformRV.lua,v 1.1 2004/11/28 18:26:55 brpreiss Exp $

--]]

require "RandomVariable"
require "RandomNumberGenerator"

----{
--++
-- A random variable uniformly distributed on the interval (u, v].
UniformRV = Class.new("UniformRV", RandomVariable)

-- Constructs a uniform random variable on the given interval.
-- @param u The lower bound of the interval.
-- @param v The upper bound of the interval.
function UniformRV.methods:initialize(u, v)
    UniformRV.super(self)
    self.u = u
    self.v = v
end

-- Returns the next sample.
function UniformRV.methods:next()
    return self.u + (self.v - self.u) * RandomNumberGenerator.instance:next()
end
--}>a

-- UniformRV test program.
-- @param arg Comand-line arguments.
function UniformRV.main(arg)
    print "UniformRV test program."
    local rv = UniformRV.new(0,100)
    toint(10):times(
	function()
	    print(rv:next())
	end
    )
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( UniformRV.main(arg) )
end
