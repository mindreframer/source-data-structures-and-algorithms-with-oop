#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: Polynomial.lua,v $
    $Revision: 1.2 $

    $Id: Polynomial.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Container"

--{
-- Abstract base class
-- from which all polynomial classes are derived.
Polynomial = Class.new("Polynomial", Container)

-- Constructor.
function Polynomial.methods:initialize()
    Polynomial.super(self)
end

-- Adds the given term to this polynomial.
-- @param term The term to add.
Polynomial:abstract_method("addTerm")

-- Differentiates this polynomial.
Polynomial:abstract_method("differentiate")

-- Addition operator.
-- Returns the sum of this polynomial and the given polynomial.
-- @param poly A polynomial.
Polynomial:abstract_method("add")
--}>a

--{
-- Represents a term in a polynomial.
Polynomial.Term = Class.new("Polynomial.Term")

-- Constructs a term with the given coefficient and exponent.
-- @param coefficient The coefficient of the term.
-- @param exponent The exponent of the term.
function Polynomial.Term.methods:initialize(
					coefficient, exponent)
    Polynomial.Term.super(self)
    self.coefficient = coefficient
    self.exponent = exponent
end

-- The coefficient.
Polynomial.Term:attr_reader("coefficient")

-- The exponent.
Polynomial.Term:attr_reader("exponent")

-- Compares this term with given term.
-- @param term The term to compare.
function Polynomial.Term.methods:compare(term)
    assert(term:is_a(Polynomial.Term), "TypeError")
    if self.exponent == term.exponent then
	return cmp(self.coefficient, term.coefficient)
    else
	return cmp(self.exponent, term.exponent)
    end
end

-- Differentiates this term.
function Polynomial.Term.methods:differentiate()
    if self.exponent > 0 then
	self.coefficient = self.coefficient * self.exponent
	self.exponent = self.exponent - 1
    else
	self.coefficient = 0
    end
end
--}>b

--{
-- Returns a copy of this term.
function Polynomial.Term.methods:clone()
    return Polynomial.Term.new(self.coefficient, self.exponent)
end

-- Addition operator.
-- Returns the sum of this term and the given term.
-- @param term A term.
function Polynomial.Term.methods:add(term)
    assert(self.exponent == term.exponent, "DomainError")
    return Polynomial.Term.new(
	self.coefficient + term.coefficient, self.exponent)
end
--}>c

--{
-- Differentiates this polynomial.
function Polynomial.methods:differentiate()
    self:each(
	function(term)
	    term:differentiate()
	end
    )
    local zeroTerm = self:find(Polynomial.Term.new(0, 0))
    if zeroTerm then
	self:withdraw(zeroTerm)
    end
end
--}>d

-- Returns a string representation of this term.
function Polynomial.Term.methods:toString()
    return string.format("%gx^%g",
			    self.coefficient, self.exponent)
end
