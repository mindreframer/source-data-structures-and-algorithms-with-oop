#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo5.lua,v $
    $Revision: 1.8 $

    $Id: Demo5.lua,v 1.8 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "GeneralTree"
require "BinaryTree"
require "NaryTree"
require "BinarySearchTree"
require "AVLTree"
require "MWayTree"
require "BTree"


-- Provides demonstration program number 5.
Demo5 = Module.new("Demo5")

-- Demonstration program number 5.
-- @param arg Command-line arguments.
function Demo5.main(arg)
    print "Demostration program number 5."
    GeneralTree.main(arg)
    BinaryTree.main(arg)
    NaryTree.main(arg)
    BinarySearchTree.main(arg)
    AVLTree.main(arg)
    MWayTree.main(arg)
    BTree.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo5.main(arg) )
end
