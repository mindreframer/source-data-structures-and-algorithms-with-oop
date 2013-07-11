#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo7.lua,v $
    $Revision: 1.6 $

    $Id: Demo7.lua,v 1.6 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "SetAsArray"
require "SetAsBitVector"
require "MultisetAsArray"
require "MultisetAsLinkedList"
require "PartitionAsForest"
require "PartitionAsForestV2"
require "PartitionAsForestV3"

-- Provides demonstration program number 7
Demo7 = Module.new("Demo7")

-- Demonstration program number 7.
-- @param arg Command-line arguments.
function Demo7.main(arg)
    print "Demostration program number 7."
    SetAsArray.main(arg)
    SetAsBitVector.main(arg)
    MultisetAsArray.main(arg)
    MultisetAsLinkedList.main(arg)
    PartitionAsForest.main(arg)
    PartitionAsForestV2.main(arg)
    PartitionAsForestV3.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo7.main(arg) )
end
