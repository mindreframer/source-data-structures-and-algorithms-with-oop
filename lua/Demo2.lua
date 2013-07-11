#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo2.lua,v $
    $Revision: 1.4 $

    $Id: Demo2.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "Class"
require "StackAsArray"
require "StackAsLinkedList"
require "QueueAsArray"
require "QueueAsLinkedList"
require "DequeAsArray"
require "DequeAsLinkedList"

-- Provides Demonstration program number 2.
Demo2 = Module.new("Demo")

-- Demonstration program number 2.
-- @param arg Command-line arguments.
function Demo2.main(arg)
    print "Demonstration program number 2."
    StackAsArray.main(arg)
    StackAsLinkedList.main(arg)
    QueueAsArray.main(arg)
    QueueAsLinkedList.main(arg)
    DequeAsArray.main(arg)
    DequeAsLinkedList.main(arg)
end

if _REQUIREDNAME == nil then
    os.exit( Demo2.main(arg) )
end
