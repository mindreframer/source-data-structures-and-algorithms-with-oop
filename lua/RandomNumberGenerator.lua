#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: RandomNumberGenerator.lua,v $
    $Revision: 1.2 $

    $Id: RandomNumberGenerator.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

--{
require "Class"
require "Integer"

-- A multiplicative linear congruential pseudo-random number generator.
-- 
-- Adapted from the minimal standard pseudo-random number generator
-- described in Stephen K. Park and Keith W. Miller,
-- "Random Number Generators: Good Ones Are Hard To Find,"
-- Communications of the ACM, Vol. 31, No. 10, Oct. 1988, pp. 1192-1201.
RandomNumberGenerator = Class.new("RandomNumberGenerator")

local RNG = RandomNumberGenerator

RNG.A = toint(16807)
RNG.M = toint(2147483647)
RNG.Q = toint(127773)
RNG.R = toint(2836)

-- Constructs a random number generator with the given seed.
-- @param seed An seed in the range 1...M.
function RNG.methods:initialize(seed)
    RNG.super(self)
    seed = seed or 1
    seed = toint(seed)
    assert(toint(1) <= seed and seed <= RNG.M, "DomainError")
    self.seed = seed
end

-- Singleton pattern.
RNG.instance = RNG.new(1)
RNG.new = nil

-- The seed.
RNG:attr_reader("seed")

-- Sets the seed to the given value.
-- @param seed An seed in the range 1...M.
function RNG.methods:set_seed(seed)
    seed = toint(seed)
    assert(toint(1) <= seed and seed <= RNG.M, "DomainError")
    self.seed = seed
end

-- Returns the next sample.
function RNG.methods:next()
    self.seed = RNG.A * (self.seed:mod(RNG.Q)) -
				    RNG.R * (self.seed / RNG.Q)
    if self.seed < toint(0) then
	self.seed = self.seed + RNG.M
    end
    return tonumber(self.seed) / tonumber(RNG.M)
end
--}>a

-- Random number generator test program.
-- @param arg Command-line arguments.
function RandomNumberGenerator.main(arg)
    print "RandomNumberGenerator test program."
    RandomNumberGenerator.instance:set_seed(1)
    for i = 1, 10 do
	print( RandomNumberGenerator.instance:next())
    end
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( RandomNumberGenerator.main(arg) )
end
