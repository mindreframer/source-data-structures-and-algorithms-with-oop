#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo4.lua,v $
    $Revision: 1.4 $

    $Id: Demo4.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "String"
require "ChainedHashTable"
require "ChainedScatterTable"
require "OpenScatterTable"
require "OpenScatterTableV2"

-- Provides demonstration program number 4.
Demo4 = Module.new("Demo4")

-- Demonstration program number 4.
-- @param arg Command-line arguments.
function Demo4.main(arg)
    print "Demostration program number 4."
    String.testHash()
    ChainedHashTable.main(arg)
    ChainedScatterTable.main(arg)
    OpenScatterTable.main(arg)
    OpenScatterTableV2.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo4.main(arg) )
end
