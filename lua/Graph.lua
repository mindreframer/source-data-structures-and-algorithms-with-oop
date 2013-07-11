#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 02:33:07 $
    $RCSfile: Graph.lua,v $
    $Revision: 1.2 $

    $Id: Graph.lua,v 1.2 2004/12/02 02:33:07 brpreiss Exp $

--]]

require "Container"
require "Vertex"
require "Edge"
require "Array"
require "QueueAsLinkedList"

--{
-- Abstract base class from which all graph classes are derived.
Graph = Class.new("Graph", Container)

-- Represents a vertex in a graph.
Graph.Vertex = Class.new("Graph.Vertex", Vertex)

-- Constructs a vertex in the given graph
-- with the given number and (optional) weight.
-- @param graph The graph of this vertex.
-- @param number The number of this vertex.
-- @param weight The weight on this vertex.
function Graph.Vertex.methods:initialize(graph, number, weight)
    Graph.Vertex.super(self)
    self.graph = graph
    self.number = number
    self.weight = weight
end

-- Represents an edge in a graph.
Graph.Edge = Class.new("Graph.Edge", Edge)

-- Constructs an edge in the given graph
-- between the given vertices and with the given (optional) weight.
-- @param graph The graph of this vertex.
-- @param v0 The number of vertex v0.
-- @param v1 The number of vertex v1.
-- @param weight The weight on this vertex.
function Graph.Edge.methods:initialize(graph, v0, v1, weight)
    Graph.Edge.super(self)
    self.graph = graph
    self.v0 = v0
    self.v1 = v1
    self.weight = weight
end
--}>a

--{
-- Constructs a graph with the given maximum number of vertices.
-- @param size The maximum number of vertices.
function Graph.methods:initialize(size)
    Graph.super(self)
    self.numberOfVertices = 0
    self.numberOfEdges = 0
    self.vertex = Array.new(size)
    self.directed = false
end

-- The number of vertices.
Graph:attr_reader("numberOfVertices")

-- The number of edges.
Graph:attr_reader("numberOfEdges")

-- The maximum number of vertices.
function Graph.methods:size()
    return self.vertex:get_length()
end

-- Returns the specified vertex.
-- @param v A vertex number.
function Graph.methods:getitem(v)
    return self.vertex[v]
end
--}>b

--{
-- True if this graph is directed.
Graph:abstract_method("is_directed")
-- True if this graph is connected.
Graph:abstract_method("is_connected")
-- True if this graph is cyclic.
Graph:abstract_method("is_cyclic")
-- Returns an iterator that enumerates
-- the vertices of this graph.
Graph:abstract_method("vertices")
-- Returns an iterator that enumerates
-- the edges of this graph.
Graph:abstract_method("edges")
-- Adds a vertex to this graph with the (optional) weight.
-- @param v The number of the vertex.
-- @param weight The weight of the vertex.
Graph:abstract_method("addVertex")
-- Returns the specified vertex of this graph.
-- @param v The number of the vertex.
Graph:abstract_method("get_vertex")
-- Adds an edge to this graph between the given vertices
-- and with the (optional) weight.
Graph:abstract_method("addEdge")
-- Returns the specified edge of this graph.
Graph:abstract_method("get_edge")
-- True if there is an edge in this graph connecting the given vertices.
Graph:abstract_method("is_edge")
-- Calls the given visitor function for the vertices in this graph
-- in depth-first traversal order
-- starting from the given vertex.
-- @param start A vertex in this graph.
-- @param visitor A visitor function.
Graph:abstract_method("depthFirstTraversal")
-- Calls the given visitor function for the vertices in this graph
-- this graph in breadth-first traversal order
-- starting from the given vertex.
-- @param start A vertex in this graph.
-- @param visitor A visitor function.
Graph:abstract_method("breadthFirstTraversal")
-- Returns an iterator that enumerates
-- the edges incident upon the given vertex in this graph.
-- @param v A vertex in this graph.
Graph:abstract_method("incidentEdges")
-- Returns an iterator that enumerates
-- the edges emanating from the given vertex in this graph.
-- @param v A vertex in this graph.
Graph:abstract_method("emanatingEdges")
--}>c

--{
-- Pre-visit mode.
Graph.PREVISIT = -1
-- Post-visit mode.
Graph.POSTVISIT = 1

-- Calls the given visitor function for the vertices in this graph
-- in depth-first traversal order
-- starting from the given vertex.
-- @param start A vertex in this graph.
-- @param visitor A visitor function.
function Graph.methods:depthFirstTraversal(start, visitor)
    local visited = Array.new(self.numberOfVertices)
    for v = 0,  self.numberOfVertices - 1 do
	visited[v] = false
    end
    self:doDepthFirstTraversal(self[start], visited, visitor)
end

-- Calls the given visitor function for the vertices in this graph
-- in depth-first traversal order
-- @param start A vertex in this graph.
-- @param visitor Boolean array used to keep track of the visited vertices.
-- @param visitor A visitor function.
function Graph.methods:doDepthFirstTraversal(v, visited, visitor)
    visitor(v, Graph.PREVISIT)
    visited[v:get_number()] = true
    for to in v:successors() do
	if not visited[to:get_number()] then
	    self:doDepthFirstTraversal(to, visited, visitor)
	end
    end
    visitor(v, Graph.POSTVISIT)
end
--}>d

--{
-- Calls the given visitor function for the vertices in this graph
-- this graph in breadth-first traversal order
-- @param start A vertex in this graph.
-- @param visitor A visitor function.
function Graph.methods:breadthFirstTraversal(start, visitor)
    local enqueued = Array.new(self.numberOfVertices)
    for v = 0, self.numberOfVertices - 1 do
	enqueued[v] = false
    end
    local queue = QueueAsLinkedList.new()
    queue:enqueue(self[start])
    enqueued[start] = true
    while not queue:is_empty() do
	v = queue:dequeue()
	visitor(v)
	for to in v:successors() do
	    if not enqueued[to:get_number()] then
		queue:enqueue(to)
		enqueued[to:get_number()] = true
	    end
	end
    end
end
--}>e

--{
-- True if this graph is connected.
function Graph.methods:is_connected()
    local count = 0
    self:depthFirstTraversal(0,
	function(obj, mode)
	    if mode == Graph.PREVISIT then
		count = count + 1
	    end
	end
    )
    return count == self.numberOfVertices
end
--}>f

-- Purges this graph.
function Graph.methods:purge()
    for i = 0, self.numberOfVertices - 1 do
	self.vertex[i] = nil
    end
    self.numberOfVertices = 0
    self.numberOfEdges = 0
end

-- Adds a vertex to this graph with the (optional) weight.
-- @param v The number of the vertex.
-- @param w The weight of the vertex.
function Graph.methods:addVertex(v, weight)
    if self.numberOfVertices == self.vertex:get_length() then
	error "ContainerFull"
    end
    if v ~= self.numberOfVertices then
	error "ArgumentError"
    end
    self.vertex[self.numberOfVertices] = Graph.Vertex.new(self, v, weight)
    self.numberOfVertices = self.numberOfVertices + 1
end

-- Returns the specified vertex of this graph.
-- @param v The number of the vertex.
function Graph.methods:get_vertex(v)
    return self.vertex[v]
end

-- True if this graph is directed.
function Graph.methods:is_directed()
    return self.directed
end

-- Calls the given visitor function for each vertex in this graph.
-- @param visitor A visitor function.
function Graph.methods:each(visitor)
    for v in self:vertices() do
	visitor(v)
    end
end

-- Returns an interator that enumerates the vertices of this graph.
function Graph.methods:vertices()
    local v = 0 -- Iterator state.
    return
	function()
	    local result = nil
	    if v < self.numberOfVertices then
		result = self.vertex[v]
		v = v + 1
	    end
	    return result
	end
end

-- Returns a string representation of this graph.
function Graph.methods:toString()
    local s = ""
    for v in self:vertices() do
	for e in self:emanatingEdges(v) do
	    s = s .. "    " .. tostring(e) .. "\n"
	end
    end
    return class(self) .. "{\n" .. s .. "}"
end

-- The number of this vertex.
Graph.Vertex:attr_reader("number")

-- The weight of this vertex.
Graph.Vertex:attr_reader("weight")

-- Returns the hash value of this vertex.
function Graph.Vertex.methods:hash()
    local result = self.number
    if self.weight then
	result = reslt + hash(self.weight)
    end
    return result
end

-- Returns a string representation of this vertex.
function Graph.Vertex.methods:toString()
    if self.weight then
	return string.format("Vertex {%d, weight = %s}",
	    self.number, tostring(self.weight))
    else
	return string.format("Vertex {%d}", self.number)
    end
end

-- Returns an iterator that enumerates
-- the edges incident upon this vertex.
function Graph.Vertex.methods:incidentEdges()
    return self.graph:incidentEdges(self)
end

-- Returns an iterator that enumerates
-- the edges emanating from this vertex.
function Graph.Vertex.methods:emanatingEdges()
    return self.graph:emanatingEdges(self)
end

-- Returns an iterator that enumerates
-- the predecessors of this vertex.
function Graph.Vertex.methods:predecessors()
    local f = self:incidentEdges() -- Iterator state.
    return
	function()
	    local result = nil
	    local e = f()
	    if e then
	    result = e:mateOf(self.graph[self.number])
	end
	return result
    end
end

-- Returns an iterator that enumerates
-- the successors of this vertex.
function Graph.Vertex.methods:successors()
    local f = self:emanatingEdges() -- Iterator state.
    return
	function()
	    local result = nil
	    local e = f()
	    if e then
		result = e:mateOf(self.graph[self.number])
	    end
	    return result
	end
end

-- Vertex v0 of this edge.
function Graph.Edge.methods:get_v0()
    return self.graph[self.v0]
end

-- Vertex v1 of this edge.
function Graph.Edge.methods:get_v1()
    return self.graph[self.v1]
end

-- The weight on this edge.
Graph.Edge:attr_reader("weight")

-- The mate of the given vertex of this edge.
-- @param v A vertex of this edge.
function Graph.Edge.methods:mateOf(v)
    if v.number == self.v0 then
	return self.graph[self.v1]
    elseif v.number == self.v1 then
	return self.graph[self.v0]
    else
	error "ArgumentError"
    end
end

-- True if this edge is directed.
function Graph.Edge.methods:is_directed()
    return self.graph.directed
end

-- Returns the hash value of this edge.
function Graph.Edge.methods:hash()
    local result = self.v0 * self.graph.numberOfVertices + self.v1
    if self.weight then
	result = result + hash(self.weight)
    end
    return result
end

-- Returns a string representation of this edge.
function Graph.Edge.methods:toString()
    local s = tostring(self.v0)
    if self:is_directed() then
	s = s .. "->" .. tostring(self.v1)
    else
	s = s .. "--" .. tostring(self.v1)
    end
    if self.weight ~= nil then
	s = s .. ", weight = " .. tostring(self.weight)
    end
    return "Edge {" .. s .. "}"
end

-- Returns a preorder visitor that is composed with the given visitor function.
-- @param visitor A visitor function.
function Graph.preOrder(visitor)
    return
	function(obj, mode)
	    if mode == Graph.PREVISIT then
		visitor(obj)
	    end
	end
end

-- Returns a postorder visitor that is composed with the given visitor function.
-- @param visitor A visitor function.
function Graph.postOrder(visitor)
    return
	function(obj, mode)
	    if mode == Graph.POSTVISIT then
		visitor(obj)
	    end
	end
end

-- Graph test program.
-- @param g The graph to test.
function Graph.test(g)
    print "Graph test program."
    g:addVertex(0)
    g:addVertex(1)
    g:addVertex(2)
    g:addEdge(0, 1)
    g:addEdge(0, 2)
    g:addEdge(1, 2)
    print(g)
    print("is_directed returns ", g:is_directed())
    print "Using vertex iterator"
    for v in g:vertices() do
	print(v)
    end
    print "Using edge iterator"
    for v in g:edges() do
	print(v)
    end

    print "DepthFirstTraversal"
    g:depthFirstTraversal(0, Graph.preOrder(
	function(obj)
	    print(obj)
	end
    ))

    print "BreadthFirstTraversal"
    g:breadthFirstTraversal(0,
	function(obj)
	    print(obj)
	end
    )

    print("is_connected returns ", g:is_connected())
end

-- Weighted graph test program.
-- @parm g The weighted graph to test.
function Graph.testWeighted(g)
    print "Weighted graph test program."
    g:addVertex(0, box(123))
    g:addVertex(1, box(234))
    g:addVertex(2, box(345))
    g:addEdge(0, 1, box(3))
    g:addEdge(0, 2, box(1))
    g:addEdge(1, 2, box(4))
    print(g)
    print "Using vertex iterator"
    for v in g:vertices() do
	print(v)
    end
    print "Using edge iterator"
    for e in g:edges() do
	print(e)
    end
end
