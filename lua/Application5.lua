#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:05:55 $
    $RCSfile: Application5.lua,v $
    $Revision: 1.1 $

    $Id: Application5.lua,v 1.1 2004/12/02 01:05:55 brpreiss Exp $

--]]

require "Algorithms"

-- Provides application program number 5.
Application5 = Module.new("Application5")

-- Application program number 5.
-- @param arg Command-line arguments.
function Application5.main(arg)
    print "Application program number 5. (word counter)"
    Algorithms.wordCounter(io.stdin, io.stdout)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application5.main(arg) )
end
