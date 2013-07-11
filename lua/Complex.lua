#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 18:50:06 $
    $RCSfile: Complex.lua,v $
    $Revision: 1.3 $

    $Id: Complex.lua,v 1.3 2004/12/05 18:50:06 brpreiss Exp $

--]]

--{
-- A complex number class.
require "Class"

Complex = Class.new("Complex")

-- Constructs a complex number
-- with the given real and imaginary parts.
-- @param real The real part.
-- @param image The imaginary part.
function Complex.methods:initialize(real, imag)
    Complex.super(self)
    self.real = real
    self.imag = imag
end
--}>a

--{
-- The real part of this complex number.
Complex:attr_accessor("real")

-- The imaginary part of this complex number.
Complex:attr_accessor("imag")
--}>b

--{
-- The radius of this complex number.
function Complex.methods:get_r()
    return math.sqrt(
		self.real * self.real + self.imag * self.imag)
end

-- Sets the radius of this complex number to the given value.
-- value: A radius.
function Complex.methods:set_r(value)
    local tmp = self:get_theta()
    self.real = value * math.cos(tmp)
    self.imag = value * math.sin(tmp)
end

-- The angle of this complex number.
function Complex.methods:get_theta()
    return math.atan2(self.imag, self.real)
end

-- Sets the angle of this complex number to the given value.
-- value: A angle.
function Complex.methods:set_theta(value)
    local tmp = self:get_r()
    self.real = tmp * math.cos(value)
    self.imag = tmp * math.sin(value)
end
--}>c

--{
-- Addition operator.
-- Returns the sum of this complex number
-- and the given complex number.
-- @param c A complex number.
function Complex.methods:add(c)
    return Complex.new( self:get_real() + c:get_real(),
			self:get_imag() + c:get_imag())
end

-- Subtraction operator.
-- Returns the difference of this complex number
-- and the given complex number.
-- @param c A complex number.
function Complex.methods:sub(c)
    return Complex.new( self:get_real() - c:get_real(),
			self:get_imag() - c:get_imag())
end

-- Multiplication operator.
-- Returns the product of this complex number and the given complex number.
-- @param c A complex number.
function Complex.methods:mul(c)
    return Complex.new( self:get_real() * c:get_real() -
			    self:get_imag() * c:get_imag(),
			self:get_real() * c:get_imag() +
			    self:get_imag() * c:get_real())
end

-- Division operator.
-- Returns the quotient of this complex number
-- and the given complex number.
-- +c+:: A complex number.
function Complex.methods:div(c)
    denom = c:get_real() * c:get_real() -
		c:get_imag() * c:get_imag()
    return Complex.new(
	    (self:get_real() * c:get_real() -
		self:get_imag() * c:get_imag()) / denom,
	    (self:get_imag() * c:get_real() -
		self:get_real() * c:get_imag()) / denom)
end

-- Unary minus.
-- Returns the negative value of this complex number.
function Complex.methods:unm()
    return Complex.new(-self:get_real(), -self:get_imag())
end
--}>d

--{
-- Complex test program.
-- @param arg Command-line arguments.
function Complex.main(arg)
--<
    print "Complex test program."
-->
    local c = Complex.new(0, 0)
    print(c)
    c:set_real(1)
    c:set_imag(2)
    print(c)
    c:set_theta(math.pi/2)
    c:set_r(50)
    print(c)
    c = Complex.new(1, 2)
    local d = Complex.new(3, 4)
    print(c, d, c+d, c-d, c*d, c/d)
    return 0
end
--}>e

-- Returns a string representation of this complex number.
function Complex.methods:toString()
    return string.format("%g+%gi", self:get_real(), self:get_imag())
end

if _REQUIREDNAME == nil then
    os.exit( Complex.main(arg) )
end
