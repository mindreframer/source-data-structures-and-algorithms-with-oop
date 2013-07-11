#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 18:26:55 $
    $RCSfile: SimpleRV.lua,v $
    $Revision: 1.1 $

    $Id: SimpleRV.lua,v 1.1 2004/11/28 18:26:55 brpreiss Exp $

--]]

require "RandomVariable"
require "RandomNumberGenerator"

--{
-- A random variable uniformly distributed on the interval (0, 1].
SimpleRV = Class.new("SimpleRV", RandomVariable)

-- Constructor.
function SimpleRV.methods:initialize()
    SimpleRV.super(self)
end

-- Returns the next sample.
function SimpleRV.methods:next()
    return RandomNumberGenerator.instance:next()
end
--}>a

-- SimpleRV test program.
-- @param arg Command-line arguments.
function SimpleRV.main(arg)
    print "SimpleRV test program."
    local rv = SimpleRV.new()
    toint(10):times(
	function()
	    print(rv:next())
	end
    )
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SimpleRV.main(arg) )
end
