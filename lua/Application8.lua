#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:41:41 $
    $RCSfile: Application8.lua,v $
    $Revision: 1.1 $

    $Id: Application8.lua,v 1.1 2004/12/02 01:41:41 brpreiss Exp $

--]]

require "Simulation"

-- Provides application program number 8.
Application8 = Module.new("Application8")

-- Application program number 8.
-- @param arg Command-line arguments.
function Application8.main(arg)
    print "Application program number 8."
    local simulation = Simulation.new()
    simulation:run(10000)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application8.main(arg) )
end
