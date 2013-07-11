#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/29 00:58:33 $
    $RCSfile: DigraphAsLists.lua,v $
    $Revision: 1.1 $

    $Id: DigraphAsLists.lua,v 1.1 2004/11/29 00:58:33 brpreiss Exp $

--]]

require "Digraph"
require "GraphAsLists"

-- Directed graph implemented using adjacency lists.
DigraphAsLists = Class.new("DigraphAsLists", GraphAsLists)

DigraphAsLists:include(DigraphMethods)

-- Constructs a graph with the given maximum number of vertices.
-- self.param size The size of this graph.
function DigraphAsLists.methods:initialize(size)
    DigraphAsLists.super(self, size)
    self.directed = true
end

-- Adds an edge to this graph that connects the given vertices
-- and with the given weight.
-- @param v A vertex number.
-- @param w A vertex number.
-- @param weight A weight.
function DigraphAsLists.methods:addEdge(v, w, weight)
    if not v or not w then
	error "ArgumentError"
    end
    self.adjacencyList[v]:append(Graph.Edge.new(self, v, w, weight))
    self.numberOfEdges = self.numberOfEdges + 1
end

-- DigraphAsLists test program.
-- @param arg Command-line arguments.
function DigraphAsLists.main(arg)
    print "DigraphAsLists test program."
    local dg = DigraphAsLists.new(32)
    Graph.test(dg)
    dg:purge()
    Graph.testWeighted(dg)
    dg:purge()
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( DigraphAsLists.main(arg) )
end
