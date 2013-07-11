#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/26 02:35:40 $
    $RCSfile: SearchTree.lua,v $
    $Revision: 1.1 $

    $Id: SearchTree.lua,v 1.1 2004/11/26 02:35:40 brpreiss Exp $

--]]

require "SearchableContainer"
require "Tree"

--{
-- Search tree methods.
SearchTreeMethods = Module.new("SearchTreeMethods")

-- Returns the smallest key in this tree.
SearchTreeMethods:abstract_method("min")

-- Returns the largest key in this tree.
SearchTreeMethods:abstract_method("max")

-- Abstact base class from which search tree implementations are derived.
SearchTree = Class.new("SearchTree", Tree)

function SearchTree.methods:initialize()
    SearchTree.super(self)
end

SearchTree:include(SearchableContainerMethods)
SearchTree:include(SearchTreeMethods)
--}>a

-- SearchTree test program.
-- @param tree The search tree to test.
function SearchTree.test(tree)
    print "SearchTree test program."
    print(tree)
    for i = 1, 8 do
	tree:insert(box(i))
    end
    print(tree)

    print "Breadth-first traversal"
    tree:breadthFirstTraversal(
	function(obj)
	    print(obj)
	end
    )

    print "Preorder traversal"
    tree:depthFirstTraversal(Tree.preOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Inorder traversal"
    tree:depthFirstTraversal(Tree.inOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Postorder traversal"
    tree:depthFirstTraversal(Tree.postOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "Using each"
    tree:each(
	function(obj)
	    print(obj)
	end
    )

    print "Using Iterator"
    for obj in tree:iter() do
	print(obj)
    end

    print "Withdrawing 4"
    local obj = tree:find(box(4))
    local status, err = pcall(
	function()
	    tree:withdraw(obj)
	    print(tree)
	end
    )
    if not status then
	print("Caught error:", err)
    end
end
