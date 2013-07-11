#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: ExponentialRV.lua,v $
    $Revision: 1.2 $

    $Id: ExponentialRV.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "RandomVariable"
require "RandomNumberGenerator"

--{
-- An exponentially distributed random variable.
ExponentialRV = Class.new("ExponentialRV", RandomVariable)

-- Constructs an exponentially distributed random variable
-- with the given mean.
-- @param mu The mean.
function ExponentialRV.methods:initialize(mu)
    ExponentialRV.super(self)
    self.mu = mu
end

-- Returns the next sample.
function ExponentialRV.methods:next()
    return -self.mu *
		math.log(RandomNumberGenerator.instance:next())
end
--}>a

-- ExponentialRV test program.
-- @param arg Command-line arguments.
function ExponentialRV.main(arg)
    print "ExponentialRV test program."
    local rv = ExponentialRV.new(100)
    toint(10):times(
	function()
	    print(rv:next())
	end
    )
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( ExponentialRV.main(arg) )
end
