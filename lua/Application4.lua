#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:02:20 $
    $RCSfile: Application4.lua,v $
    $Revision: 1.1 $

    $Id: Application4.lua,v 1.1 2004/12/02 01:02:20 brpreiss Exp $

--]]

require "Polynomial"
require "PolynomialAsSortedList"

-- Provides application program number 4.
Application4 = Module.new("Application4")

-- Application program number 4.
-- @param arg Command-line arguments.
function Application4.main(arg)
    print "Application program number 4."
    local p1 = PolynomialAsSortedList.new()
    p1:addTerm(Polynomial.Term.new(4.5, 5))
    p1:addTerm(Polynomial.Term.new(3.2, 14))
    print(p1)

    local p2 = PolynomialAsSortedList.new()
    p2:addTerm(Polynomial.Term.new(7.8, 3))
    p2:addTerm(Polynomial.Term.new(1.6, 14))
    p2:addTerm(Polynomial.Term.new(9.999, 27))
    print(p2)

    local p3 = p1 + p2
    print(p3)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application4.main(arg) )
end
