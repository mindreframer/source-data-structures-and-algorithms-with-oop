#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: PolynomialAsSortedList.lua,v $
    $Revision: 1.2 $

    $Id: PolynomialAsSortedList.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Polynomial"
require "SortedListAsLinkedList"

--{
-- Polynomial implemented as a sorted list of terms.
PolynomialAsSortedList =
    Class.new("PolynomialAsSortedList", Polynomial)

-- Constructor.
function PolynomialAsSortedList.methods:initialize()
    PolynomialAsSortedList.super(self)
    self.list = SortedListAsLinkedList.new()
end

-- The sorted list of terms.
PolynomialAsSortedList:attr_reader("list")

-- Addition operator.
-- Returns the sum of this polynomial and the given polynomial.
-- @param poly A polynomial.
function PolynomialAsSortedList.methods:add(poly)
    local result = PolynomialAsSortedList.new()
    local p1 = self.list:iter()
    local p2 = poly:get_list():iter()
    local term1 = p1()
    local term2 = p2()
    while term1 and term2 do
	if term1:get_exponent() < term2:get_exponent() then
	    result:addTerm(term1:clone())
	    term1 = p1()
	elseif term1:get_exponent() > term2:get_exponent() then
	    result:addTerm(term2:clone())
	    term2 = p2()
	else
	    local sum = term1 + term2
	    if sum:get_coefficient() ~= 0 then
		result:addTerm(sum)
	    end
	    term1 = p1()
	    term2 = p2()
	end
    end
    while term1 do
	result:addTerm(term1:clone())
	term1 = p1()
    end
    while term2 do
	result:addTerm(term2:clone())
	term2 = p2()
    end
    return result
end
--}>a

-- Adds the given term to this polynomial.
-- @param term The term to add.
function PolynomialAsSortedList.methods:addTerm(term)
    self.list:insert(term)
end

-- Calls the given visitor function for all
-- the terms in this polynomial.
-- @param visitor A visitor function.
function PolynomialAsSortedList.methods:each(visitor)
    self.list:each(visitor)
end

-- Finds the term in this polynomial that equals the given term.
-- @parm term The term to find.
function PolynomialAsSortedList.methods:find(term)
    return self.list:find(term)
end

-- Withdraws the given term from this polynomial.
-- @param term The term to withdraw.
function PolynomialAsSortedList.methods:withdraw(term)
    self.list:withdraw(term)
end

-- Purges this polynomial.
function PolynomialAsSortedList.methods:purge()
    self.list:purge()
end

-- Returns a string representation of this polynomial.
function PolynomialAsSortedList.methods:toString()
    return self.list:toString()
end
