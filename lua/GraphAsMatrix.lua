#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 23:30:16 $
    $RCSfile: GraphAsMatrix.lua,v $
    $Revision: 1.1 $

    $Id: GraphAsMatrix.lua,v 1.1 2004/11/28 23:30:16 brpreiss Exp $

--]]

require "Graph"
require "DenseMatrix"

--{
-- Graph implemented using an adjacency matrix.
GraphAsMatrix = Class.new("GraphAsMatrix", Graph)

-- Constructs a graph with the given maximum number of vertices.
-- @param size The size of the graph.
function GraphAsMatrix.methods:initialize(size)
    GraphAsMatrix.super(self, size)
    self.matrix = DenseMatrix.new{size, size}
end
--}>a

-- Purges this graph.
function GraphAsMatrix.methods:purge()
    for i = 0, self.numberOfVertices - 1 do
	for j = 0, self.numberOfVertices - 1 do
	    self.matrix[{i, j}] = nil
	end
    end
    Graph.methods.purge(self)
end

-- Adds an edge to this graph connecting the given vertices
-- and with the given weight.
-- @param v A vertex number.
-- @param w A vertex number.
-- @param weight A weight.
function GraphAsMatrix.methods:addEdge(v, w, weight)
    if not v or not w then
	error "ArgumentError"
    end
    if self.matrix[{v, w}] then
	error "ArgumentError"
    end
    local edge = Graph.Edge.new(self, v, w, weight)
    self.matrix[{v, w}] = edge
    self.matrix[{w, v}] = edge
    self.numberOfEdges = self.numberOfEdges + 1
end

-- Returns the edge connecting the given vertices.
-- @param v A vertex number.
-- @param w A vertex number.
function GraphAsMatrix.methods:get_edge(v, w)
    local result = self.matrix[{v, w}]
    if not result then
	error "ArgumentError"
    end
    return result
end

-- True if there is an edge connecting the given vertices.
-- @param v A vertex number.
-- @param w A vertex number.
function GraphAsMatrix.methods:is_edge(v, w)
    return self.matrix[{v, w}]
end

-- Returns an iterator that enumerates
-- the edges of this graph.
function GraphAsMatrix.methods:edges()
    local v = 0 -- Iterator state.
    local w = 0 -- Iterator state.
    while v < self.numberOfVertices and w < self.numberOfVertices do
	if self.matrix[{v, w}] then
	    break
	end
	w = w + 1
	if w == self.numberOfVertices then
	    v = v + 1
	    w = v
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
		    w = v
		end
		while v < self.numberOfVertices and w < self.numberOfVertices do
		    if self.matrix[{v, w}] then
			break
		    end
		    w = w + 1
		    if w == self.numberOfVertices then
			v = v + 1
			w = v
		    end
		end
	    end
	    return result
	end
end

-- Returns an iterator that enumerates
-- the edges emanating from the given vertex of this graph.
-- @param v A vertex number.
function GraphAsMatrix.methods:emanatingEdges(v)
    v = v:get_number()
    local w = v -- Iterator state.
    while w < self.numberOfVertices do
	if self.matrix[{v, w}] then
	    break
	end
	w = w + 1
    end
    return
	function()
	    local result = nil
	    if w < self.numberOfVertices then
		result = self.matrix[{v, w}]
		w = w + 1
		while w < self.numberOfVertices do
		    if self.matrix[{v, w}] then
			break
		    end
		    w = w + 1
		end
	    end
	    return result
	end
end

-- Returns an interator that enumerates
-- the edges incident upon the given vertex of this graph.
-- @parma w A vertex number.
function GraphAsMatrix.methods:incidentEdges(w)
    w = w:get_number()
    local v = 0 -- Iterator state.
    while v <= w do
	if self.matrix[{v, w}] then
	    break
	end
	v = v + 1
    end
    return
	function()
	    local result = nil
	    if v <= w then
		result = self.matrix[{v, w}]
		v = v + 1
		while v <= w do
		    if self.matrix[{v, w}] then
			break
		    end
		    v = v + 1
		end
	    end
	    return result
	end
end

-- GraphAsMatrix test program.
-- @param arg Command-line arguments.
function GraphAsMatrix.main(arg)
    print "GraphAsMatrix test program."
    local g = GraphAsMatrix.new(32)
    Graph.test(g)
    g:purge()
    Graph.testWeighted(g)
    g:purge()
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( GraphAsMatrix.main(arg) )
end
