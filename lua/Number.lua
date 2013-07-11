#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:32:16 $
    $RCSfile: Number.lua,v $
    $Revision: 1.8 $

    $Id: Number.lua,v 1.8 2004/12/01 00:32:16 brpreiss Exp $

--]]

require "Class"

-- Wrapper class for numbers.
Number = Class.new("Number", Object)

-- Constructs an number with the given value.
-- @param value A value.
function Number.methods:initialize(value)
    Number.super(self)
    assert(type(value) == "number", "DomainError")
    self.value = value
end

-- The value of this number.
Number:attr_reader("value")

-- Compares this number with the given number.
function Number.methods:compare(obj)
    return self.value - obj.value
end

-- Computes the sum of this number and the given number.
-- @param obj An number.
function Number.methods:add(obj)
    return Number.new(self.value + obj.value)
end

-- Computes the difference of this number and the given number.
-- @param obj An number.
function Number.methods:sub(obj)
    return Number.new(self.value - obj.value)
end

-- Computes the product of this number and the given number.
-- @param obj An number.
function Number.methods:mul(obj)
    return Number.new(self.value * obj.value)
end

-- Computes the quotient of this number and the given number.
-- @param obj An number.
function Number.methods:div(obj)
    return Number.new(self.value / obj.value)
end

-- Computes the remainder of this number and the given number.
-- @param obj An number.
function Number.methods:mod(obj)
    return Number.new(math.mod(self.value, obj.value))
end

-- Computes the negation of this number.
function Number.methods:unm()
    return Number.new(-self.value)
end

-- Computes this number raised to the given number.
function Number.methods:pow(obj)
    return Number.new(self.value ^ obj.value)
end

-- Returns a string representation of the given number.
function Number.methods:toString()
    return tostring(self.value)
end

-- Returns a number representation of the given number.
function Number.methods:toNumber()
    return self.value
end

-- Hashes this number.
function Number.methods:hash()
    return math.floor(self.value)
end

-- Number test program.
-- @param arg Command-line arguments.
function Number.main(arg)
    print "Number test program."
    local i1 = box(1)
    local i2 = box(1)
    local i3 = box(2)
    print("i1 = ", i1)
    print("i2 = ", i2)
    print("i3 = ", i3)
    print("i1 < i2", i1 < i2)
    print("i1 == i2", i1 == i2)
    print("i1:is(i2)", i1:is(i2))
    print("i1 > i2", i1 > i2)
    print(unbox(i1))
    print(unbox(i2))
    print(unbox(i3))
end

if _REQUIREDNAME == nil then
    os.exit( Number.main(arg) )
end
