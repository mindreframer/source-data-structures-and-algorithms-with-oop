#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo3.lua,v $
    $Revision: 1.4 $

    $Id: Demo3.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "OrderedListAsArray"
require "OrderedListAsLinkedList"
require "SortedListAsArray"
require "SortedListAsLinkedList"

-- Provides demonstration program number 3.
Demo3 = Module.new("Demo3")

-- Demonstration program number 3.
-- @param arg Command-line arguments.
function Demo3.main(arg)
    print "Demostration program number 3."
    OrderedListAsArray.main(arg)
    OrderedListAsLinkedList.main(arg)
    SortedListAsArray.main(arg)
    SortedListAsLinkedList.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo3.main(arg) )
end
