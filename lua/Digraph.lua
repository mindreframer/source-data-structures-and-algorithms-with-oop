#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: Digraph.lua,v $
    $Revision: 1.2 $

    $Id: Digraph.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Graph"
require "Array"
require "QueueAsLinkedList"

----{
--++
-- Digraph methods.
DigraphMethods = Module.new("DigraphMethods")

-- True if this digraph is strongly connected.
DigraphMethods:abstract_method("is_stronglyConnected")
-- Calls the given visitor function for
-- the vertices of this digraph in topological traversal order.
DigraphMethods:abstract_method("topologicalOrderTraversal")

-- Abstract base class from which Digraph classes are derived.
Digraph = Class.new("Digraph", Graph)

-- Constructs a digraph
-- with the given maximum number of vertices.
-- +size+:: The maximum number of vertices.
function Digraph.methods:initialize(size)
    Digraph.super(self, size)
    self.directed = true
end

Digraph:include(DigraphMethods)
--}>a

--{
-- Calls the given visitor function for
-- the vertices of this digraph in topological traversal order.
function DigraphMethods.methods:topologicalOrderTraversal(
							visitor)
    local inDegree = Array.new(self:get_numberOfVertices())
    for v = 0, self:get_numberOfVertices() - 1 do
	inDegree[v] = 0
    end
    for e in self:edges() do
	inDegree[e:get_v1():get_number()] =
	    inDegree[e:get_v1():get_number()] + 1
    end
    local queue = QueueAsLinkedList.new()
    for v = 0, self:get_numberOfVertices() - 1 do
	if inDegree[v] == 0 then
	    queue:enqueue(self[v])
	end
    end
    while not queue:is_empty() do
	v = queue:dequeue()
	visitor(v)
	for to in v:successors() do
	    inDegree[to:get_number()] =
		inDegree[to:get_number()] - 1
	    if inDegree[to:get_number()] == 0 then
		queue:enqueue(to)
	    end
	end
    end
end
--}>b

--{
-- True if this digraph is strongly connected.
function DigraphMethods.methods:is_stronglyConnected()
    for v = 0, self:get_numberOfVertices() - 1 do
	local count = 0
	self:depthFirstTraversal(0,
	    function(obj, mode)
		if mode == Graph.PREVISIT then
		    count = count + 1
		end
	    end
	)
	if count ~= self:get_numberOfVertices() then
	    return false
	end
    end
    return true
end
--}>c

--{
-- True if this digraph is cyclic.
function DigraphMethods.methods:is_cyclic()
    local count = 0
    self:topologicalOrderTraversal(
	    function(obj)
		count = count + 1
	    end
    )
    return count ~= self:get_numberOfVertices()
end
--}>d

-- Digraph test program.
-- @param g The digraph to test.
function Digraph.test(g)
    print "Digraph test program."
    Graph.test(g)

    print "TopologicalOrderTraversal"
    g:topologicalOrderTraversal(
	function(obj)
	    print(obj)
	end
    )

    print("is_cyclic returns", g:is_cyclic())
    print("is_stronglyConnected returns",
	    g:is_stronglyConnected())
end

-- Weighted digraph test program.
-- @param g The weighted digraph to test.
function Digraph.testWeighted(g)
    print "Weighted digraph test program."
    Graph.testWeighted(g)
end
