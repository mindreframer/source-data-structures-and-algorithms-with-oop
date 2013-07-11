#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:18:55 $
    $RCSfile: Application7.lua,v $
    $Revision: 1.1 $

    $Id: Application7.lua,v 1.1 2004/12/02 01:18:55 brpreiss Exp $

--]]

require "Algorithms"

-- Provides application program number 7.
Application7 = Module.new("Application7")

-- Application program number 7.
-- @param arg Command-line arguments.
function Application7.main(arg)
    print "Application program number 7. (translator)"
    Algorithms.translate(io.open("dict.txt", "r"), io.stdin, io.stdout)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application7.main(arg) )
end
