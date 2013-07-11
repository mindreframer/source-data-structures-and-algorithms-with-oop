#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:41:41 $
    $RCSfile: Application2.lua,v $
    $Revision: 1.1 $

    $Id: Application2.lua,v 1.1 2004/12/01 00:41:41 brpreiss Exp $

--]]

require "Algorithms"
require "NaryTree"

-- Provides application program number 2.
Application2 = Module.new("Application2")

-- Builds an N-ary tree that contains character keys in the given range.
-- @param lo The lower bound of the range.
-- @param hi The upper bound of the range.
function Application2.buildTree(lo, hi)
    local mid = math.floor((lo + hi) / 2)
    local result = NaryTree.new(2, box(string.char(mid)))
    if lo < mid then
	result:attachSubtree(0, Application2.buildTree(lo, mid - 1))
    end
    if hi > mid then
	result:attachSubtree(1, Application2.buildTree(mid + 1, hi))
    end
    return result
end

-- Application program number 2.
-- @param arg Command-line arguments.
function Application2.main(arg)
    print "Application program number 2."
    print "Should be: dbfaceg."
    local tree = Application2.buildTree(string.byte("a"), string.byte("g"))
    Algorithms.breadthFirstTraversal(tree,
	function(obj)
	    print(obj)
	end
    )
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application2.main(arg) )
end
