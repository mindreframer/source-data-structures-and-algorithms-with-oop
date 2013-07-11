#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 01:44:45 $
    $RCSfile: PolynomialAsOrderedList.lua,v $
    $Revision: 1.1 $

    $Id: PolynomialAsOrderedList.lua,v 1.1 2004/12/01 01:44:45 brpreiss Exp $

--]]

require "Polynomial"
require "OrderedListAsLinkedList"

----{
--++
-- Polynomial implemented as an ordered list of terms.
PolynomialAsOrderedList = Class.new("PolynomialAsOrderedList", Polynomial)

-- Constructor.
function PolynomialAsOrderedList.methods:initialize()
    PolynomialAsOrderedList.super(self)
    self.list = OrderedListAsLinkedList.new()
end

-- Adds the given term to this polynomial.
-- @param term The term to add.
function PolynomialAsOrderedList.methods:addTerm(term)
    self.list:insert(term)
end

-- Calls the given visitor function for
-- each term of this polynomial.
-- @param visitor A visitor function.
function PolynomialAsOrderedList.methods:each(visitor)
    self.list:each(visitor)
end

-- Finds the term in this polynomial that equals the given term.
-- @param term The term to find.
function PolynomialAsOrderedList.methods:find(term)
    self.list:find(term)
end

-- Withdraws the given term from this polynomial.
-- @param term The term to withdraw.
function PolynomialAsOrderedList.methods:withdraw(term)
    self.list:withdraw(term)
end
--}>a

-- Purges this polynomial.
function PolynomialAsOrderedList.methods:purge()
    self.list:purge()
end

-- Returns a string representation of this polynomial.
function PolynomialAsOrderedList.methods:toString()
    return self.list:toString()
end
