#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 02:33:07 $
    $RCSfile: GraphAsLists.lua,v $
    $Revision: 1.2 $

    $Id: GraphAsLists.lua,v 1.2 2004/12/02 02:33:07 brpreiss Exp $

--]]

require "Graph"
require "Array"
require "LinkedList"

--{
-- Graph implemented using adjacency lists.
GraphAsLists = Class.new("GraphAsLists", Graph)

-- Constructs a graph with the given maximum number of vertices.
-- @param size The size of this graph.
function GraphAsLists.methods:initialize(size)
    GraphAsLists.super(self, size)
    self.adjacencyList = Array.new(size)
    for i = 0, size - 1 do
	self.adjacencyList[i] = LinkedList.new()
    end
end
--}>a

-- Purges this graph.
function GraphAsLists.methods:purge()
    for i = 0, self.numberOfVertices - 1 do
	self.adjacencyList[i]:purge()
    end
    Graph.methods.purge(self)
end

-- Adds an edge to this graph that connects the given vertices
-- and with the given weight.
-- @param v A vertex number.
-- @param w A vertex number.
-- @param weight A weight.
function GraphAsLists.methods:addEdge(v, w, weight)
    if not v or not w then
	error "ArgumentError"
    end
    self.adjacencyList[v]:append(Graph.Edge.new(self, v, w, weight))
    --self.adjacencyList[w]:append(Graph.Edge.new(self, w, v, weight))
    self.numberOfEdges = self.numberOfEdges + 1
end

-- Returns the edge connecting the given vertices in this graph.
-- @param v A vertex number.
-- @param w A vertex number.
function GraphAsLists.methods:getEdge(v, w)
    assert(v >= 0 and v < self.numberOfVertices, "IndexError")
    assert(w >= 0 and w < self.numberOfVertices, "IndexError")
    local ptr = self.adjacencyList[v]:get_head()
    while ptr do
	local edge = ptr:get_datum()
	if edge:get_v1():get_number() == w then
	    return edge
	end
	ptr = ptr:get_succ()
    end
    error "ArgumentError"
end

-- True if there is an the edge connecting the given vertices in this graph.
-- @param v A vertex number.
-- @param w A vertex number.
function GraphAsLists.methods:is_edge(v, w)
    assert(v >= 0 and v < self.numberOfVertices, "IndexError")
    assert(w >= 0 and w < self.numberOfVertices, "IndexError")
    local ptr = self.adjacencyList[v]:get_head()
    while ptr do
	local edge = ptr:get_datum()
	if edge:get_v1():get_number() == w then
	    return true
	end
	ptr = ptr:get_succ()
    end
    return false
end

-- Returns an interator that enumerates
-- the edges of this graph.
function GraphAsLists.methods:edges()
    local v = 0 -- Iterator state.
    local ptr = self.adjacencyList[v]:get_head() -- Iterator state.
    while v < self.numberOfVertices do
	if ptr then
	    break
	end
	v = v + 1
	ptr = self.adjacencyList[v]:get_head()
    end
    return
	function()
	    local result = nil
	    if v < self.numberOfVertices then
		result = ptr:get_datum()
		ptr = ptr:get_succ()
		while v < self.numberOfVertices do
		    if ptr then
			break
		    end
		    v = v + 1
		    ptr = self.adjacencyList[v]:get_head()
		end
	    end
	    return result
	end
end

-- Returns an iterator that enumerates
-- the edges emanating from the given vertex in this graph.
-- @param v A vertex number.
function GraphAsLists.methods:emanatingEdges(v)
    local ptr = self.adjacencyList[v:get_number()]:get_head() -- Iterator stat.
    return
	function()
	    local result = nil
	    if ptr then
		result = ptr:get_datum()
		ptr = ptr:get_succ()
	    end
	    return result
	end
end

-- GraphAsLists test program.
-- @param arg Command-line arguments.
function GraphAsLists.main(arg)
    print "GraphAsLists test program."
    local g = GraphAsLists.new(32)
    Graph.test(g)
    g:purge()
    Graph.testWeighted(g)
    g:purge()
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( GraphAsLists.main(arg) )
end
