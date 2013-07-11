#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 01:44:45 $
    $RCSfile: Application3.lua,v $
    $Revision: 1.1 $

    $Id: Application3.lua,v 1.1 2004/12/01 01:44:45 brpreiss Exp $

--]]

require "Polynomial"
require "PolynomialAsOrderedList"
require "PolynomialAsSortedList"


-- Provides application program number 3.
Application3 = Module.new("Application3")

-- Application program number 3.
-- @param arg Command-line arguments.
function Application3.main(arg)
    print "Application program number 3."
    local p1 = PolynomialAsOrderedList.new()
    p1:addTerm(Polynomial.Term.new(4.5, 5))
    p1:addTerm(Polynomial.Term.new(3.2, 14))
    print(p1)
    p1:differentiate()
    print(p1)

    local p2 = PolynomialAsSortedList.new()
    p2:addTerm(Polynomial.Term.new(7.8, 0))
    p2:addTerm(Polynomial.Term.new(1.6, 14))
    p2:addTerm(Polynomial.Term.new(9.999, 27))
    print(p2)
    p2:differentiate()
    print(p2)

    local p3 = PolynomialAsSortedList.new()
    p3:addTerm(Polynomial.Term.new(0.6, 13))
    p3:addTerm(Polynomial.Term.new(-269.973, 26))
    p3:addTerm(Polynomial.Term.new(1000, 1000))
    print(p3)
    print(p2 + p3)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application3.main(arg) )
end
