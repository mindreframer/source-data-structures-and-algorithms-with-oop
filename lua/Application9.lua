#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:50:30 $
    $RCSfile: Application9.lua,v $
    $Revision: 1.1 $

    $Id: Application9.lua,v 1.1 2004/12/02 01:50:30 brpreiss Exp $

--]]

require "Algorithms"

-- Provides application program number 9.
Application9 = Module.new("Application9")

-- Application program number 9.
-- @param arg Command-line arguments.
function Application9.main(arg)
    print "Application program number 9. (equivalence classes)"
    Algorithms.equivalenceClasses(io.stdin, io.stdout)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application9.main(arg) )
end
