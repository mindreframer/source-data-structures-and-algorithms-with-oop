#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:32:16 $
    $RCSfile: Application1.lua,v $
    $Revision: 1.1 $

    $Id: Application1.lua,v 1.1 2004/12/01 00:32:16 brpreiss Exp $

--]]

require "Algorithms"

-- Provides application program number 1.
Application1 = Module.new("Application")

-- Application program number 1.
-- @param arg Command-line arguments.
function Application1.main(arg)
    print "Application program number 1. (calculator)"
    Algorithms.calculator(io.stdin, io.stdout)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application1.main(arg) )
end
