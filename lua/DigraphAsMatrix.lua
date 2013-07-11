#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/29 00:34:52 $
    $RCSfile: DigraphAsMatrix.lua,v $
    $Revision: 1.1 $

    $Id: DigraphAsMatrix.lua,v 1.1 2004/11/29 00:34:52 brpreiss Exp $

--]]

require "Digraph"
require "GraphAsMatrix"

-- Directed graph implemented using an adjacency matrix.
DigraphAsMatrix = Class.new("DigraphAsMatrix", GraphAsMatrix)

DigraphAsMatrix:include(DigraphMethods)

-- Constructs a digraph with the given maximum number of vertices.
-- @param size The size of this graph.
function DigraphAsMatrix.methods:initialize(size)
    DigraphAsMatrix.super(self, size)
    self.directed = true
end

-- Adds an edge to this digraph connecting the given vertices
-- and with the given weight.
-- @param v A vertex number.
-- @param w A vertex number.
-- @param weight A weight.
function DigraphAsMatrix.methods:addEdge(v, w, weight)
    if not v or not w then
	error "ArgumentError"
    end
    if self.matrix[{v, w}] then
	error "ArgumentError"
    end
    self.matrix [{v, w}] = Graph.Edge.new(self, v, w, weight)
    self.numberOfEdges = self.numberOfEdges + 1
end

-- Returns an iterator that enumerates
-- the edges of this graph.
function DigraphAsMatrix.methods:edges()
    local v = 0 -- Iterator state.
    local w = 0 -- Iterator state.
    while v < self.numberOfVertices and w < self.numberOfVertices do
	if self.matrix[{v, w}] then
	    break
	end
	w = w + 1
	if w == self.numberOfVertices then
	    v = v + 1
	    w = 0
	end
    end
    return
	function()
	    local result = nil
	    if v < self.numberOfVertices and w < self.numberOfVertices then
		result = self.matrix[{v, w}]
		w = w + 1
		if w == self.numberOfVertices then
		    v = v + 1
		    w = 0
		end
		while v < self.numberOfVertices and w < self.numberOfVertices do
		    if self.matrix[{v, w}] then
			break
		    end
		    w = w + 1
		    if w == self.numberOfVertices then
			v = v + 1
			w = 0
		    end
		end
	    end
	    return result
	end
end

-- DigraphAsMatrix test program.
-- @param arg Command-line arguments.
function DigraphAsMatrix.main(arg)
    print "DigraphAsMatrix test program."
    local dg = DigraphAsMatrix.new(32)
    Digraph.test(dg)
    dg:purge()
    Digraph.testWeighted(dg)
    dg:purge()
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( DigraphAsMatrix.main(arg) )
end
