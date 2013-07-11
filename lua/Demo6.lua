#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo6.lua,v $
    $Revision: 1.4 $

    $Id: Demo6.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "BinaryHeap"
require "LeftistHeap"
require "BinomialQueue"
require "Deap"

-- Provides demonstration program number 6.
Demo6 = Module.new("Demo6")

-- Demonstration program number 6.
-- @param arg Command-line arguments.
function Demo6.main(arg)
    print "Demostration program number 6."
    BinaryHeap.main(arg)
    LeftistHeap.main(arg)
    BinomialQueue.main(arg)
    Deap.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo6.main(arg) )
end
