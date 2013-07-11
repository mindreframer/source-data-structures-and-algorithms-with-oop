#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo10.lua,v $
    $Revision: 1.4 $

    $Id: Demo10.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "GraphAsMatrix"
require "DigraphAsMatrix"
require "GraphAsLists"
require "DigraphAsLists"

-- Provides Demonstration program number 10.
Demo10 = Module.new("Demo10")

-- Demonstration program number 10.
-- @param arg Command-line arguments.
function Demo10.main(arg)
    print "Demostration program number 10."
    GraphAsMatrix.main(arg)
    DigraphAsMatrix.main(arg)
    GraphAsLists.main(arg)
    DigraphAsLists.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo10.main(arg) )
end
