#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 18:26:55 $
    $RCSfile: Integer.lua,v $
    $Revision: 1.13 $

    $Id: Integer.lua,v 1.13 2004/11/28 18:26:55 brpreiss Exp $

--]]

require "Class"

-- Load the Opus9.int library.
loadlib("./int.so", "luaopen_int")()

-- Wrapper class for 32-bit integers.
Integer = Class.new("Integer")

-- Constructs an Integer with the given value.
-- @param value A value.
function Integer.methods:initialize(value)
    Integer.super(self)
    if type(value) == "number" then
	self.value = int.new(value)
    elseif type(userdata) then
	self.value = value
    end
end

-- Returns a texual representation of this integer.
function Integer.methods:toString()
    return tostring(self.value)
end

-- Returns a number representation of this integer.
function Integer.methods:toNumber()
    return tonumber(self.value)
end

-- Compares this integer with the given intenger.
-- @param obj An integer.
function Integer.methods:compare(obj)
    return self.value:cmp(obj.value)
end

-- Computes the sum of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:add(obj)
    return Integer.new(self.value:add(obj.value))
end

-- Computes the difference of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:sub(obj)
    return Integer.new(self.value:sub(obj.value))
end

-- Computes the product of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:mul(obj)
    return Integer.new(self.value:mul(obj.value))
end

-- Computes the quotient of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:div(obj)
    return Integer.new(self.value:div(obj.value))
end

-- Computes the remainder of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:mod(obj)
    return Integer.new(self.value:mod(obj.value))
end

-- Computes the negation of this integer.
function Integer.methods:unm()
    return Integer.new(self.value:unm())
end

-- Computes this integer raised to the given integer.
function Integer.methods:pow(obj)
    return Integer.new(self.value:pow(obj.value))
end

-- Computes the bitwise and of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:AND(obj)
    return Integer.new(self.value:AND(obj.value))
end

-- Computes the bitwise or of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:OR(obj)
    return Integer.new(self.value:OR(obj.value))
end

-- Computes the bitwise exclusive-or of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:XOR(obj)
    return Integer.new(self.value:XOR(obj.value))
end

-- Computes the bitwise complement of this integer and the given integer.
-- @param obj An integer.
function Integer.methods:NOT()
    return Integer.new(self.value:NOT())
end

-- Returns this integer shifted left by the given number of bits.
-- @param obj An integer.
function Integer.methods:lshift(obj)
    return Integer.new(self.value:lshift(obj.value))
end

-- Returns this integer shifted right by the given number of bits.
-- @param obj An integer.
function Integer.methods:rshift(obj)
    return Integer.new(self.value:rshift(obj.value))
end

-- Smallest integer value.
Integer.MIN = Integer.new(int.MIN)

-- Largest integer value.
Integer.MAX = Integer.new(int.MAX)

-- Number of bits in an integer.
Integer.BITS = Integer.new(int.BITS)

-- Calls the given function the number of times given by this integer.
function Integer.methods:times(f)
    for i = 1, tonumber(self.value) do
	f()
    end
end

-- Helper method to convert a number to an Integer.
function toint(x)
    if type(x) == "number" then
	return Integer.new(x)
    elseif type(x) == "Object" and class(x) == "Integer" then
	return x
    else
	local value = tonumber(x)
	if not value then
	    error "DomainError"
	end
	return Integer.new(value)
    end
end

-- Integer test program.
-- @param arg Command-line arguments.
function Integer.main(arg)
    print "Integer test program."
    local i1 = Integer.new(13)
    local i2 = Integer.new(10)
    print("i1 = ", i1)
    print("i2 = ", i2)
    print("i1 < i2", i1 < i2)
    print("i1 + i2", i1 + i2)
    print("i1 - i2", i1 - i2)
    print("i1 * i2", i1 * i2)
    print("i1 / i2", i1 / i2)
    print("i1 % i2", i1:mod(i2))
    print("-i1", -i1)
    print("-i2", -i2)
    print("i1 AND i2", i1:AND(i2))
    print("i1 OR i2", i1:OR(i2))
    print("i1 XOR i2", i1:XOR(i2))
    print("NOT(i1)", i1:NOT())
    print("NOT(i2)", i2:NOT())
    print("i1 << 3", i1:lshift(Integer.new(2)))
    print("i1 << 1", i1:rshift(Integer.new(1)))
    print("2^8", Integer.new(2) ^ Integer.new(8))
    print(int.MAX)
    print(int.MIN)
    print(int.BITS)
    print(Integer)
end

if _REQUIREDNAME == nil then
    os.exit( Integer.main(arg) )
end
