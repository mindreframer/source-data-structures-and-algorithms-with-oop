#!/usr/local/bin/lua
--[[

Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

$Author: brpreiss $
$Date: 2004/12/12 14:26:31 $
$RCSfile: Algorithms.lua,v $
$Revision: 1.8 $

$Id: Algorithms.lua,v 1.8 2004/12/12 14:26:31 brpreiss Exp $

--]]

require "Object"
require "Array"
require "DenseMatrix"
require "StackAsLinkedList"
require "QueueAsLinkedList"
require "ChainedHashTable"
require "Association"
require "AVLTree"
require "PartitionAsForest"
require "BinaryHeap"
require "GraphAsLists"
require "DigraphAsMatrix"
require "DigraphAsLists"
require "Integer"

--{
-- Provides a bunch of algorithms.
Algorithms = Module.new("Algorithms")

-- Calls the given visitor function
-- for the keys in the given tree
-- in breadth-first traversal order.
-- @param tree A tree.
function Algorithms.breadthFirstTraversal(tree, visitor)
    local queue = QueueAsLinkedList.new()
    if not tree:is_empty() then
	queue:enqueue(tree)
    end
    while not queue:is_empty() do
	local t = queue:dequeue()
	visitor(t:get_key())
	for i = 0, t:get_degree() - 1 do
	    local subTree = t:get_subtree(i)
	    if not subTree:is_empty() then
		queue:enqueue(subTree)
	    end
	end
    end
end
--}>a

--{
-- Computes equivalence classes using a partition.
-- First reads an integer from the input stream that
-- specifies the size of the universal set.
-- Then reads pairs of integers from the input stream
-- that denote equivalent items in the universal set.
-- Prints the partition on end-of-file.
-- @param input Input stream.
-- @param output Output stream.
function Algorithms.equivalenceClasses(input, output)
    local n = input:read("*number")
    local p = PartitionAsForest.new(tonumber(n))
    while true do
	i = input:read("*number"); if not i then break end
	j = input:read("*number"); if not j then break end
	s = p:find(i)
	t = p:find(j)
	if s:is_not(t) then
	    p:join(s, t)
	else
	    output:write(string.format(
		"redundant pair: %d, %d\n", i, j))
	end
    end
    output:write(string.format("%s\n",tostring(p)))
end
--}>b

--{
-- Dijkstra's algorithm to solve the single-source,
-- shortest path problem
-- for the given edge-weighted, directed graph.
-- @param g An edge-weighted, directed graph.
-- @param s A node in the graph.
function Algorithms.dijkstrasAlgorithm(g, s)
    local n = g:get_numberOfVertices()
    local table = Array.new(n)
    for v = 0, n - 1 do
	table[v] = Algorithms.Entry.new()
    end
    table[s].distance = box(0)
    local queue = BinaryHeap.new(g:get_numberOfEdges())
    queue:enqueue(Association.new(box(0), g[s]))
    while not queue:is_empty() do
	local assoc = queue:dequeueMin()
	local v0 = assoc:get_value()
	if not table[v0:get_number()].known then
	    table[v0:get_number()].known = true
	    for e in v0:emanatingEdges() do
		local v1 = e:mateOf(v0)
		local d = table[v0:get_number()].distance +
						e:get_weight()
		if table[v1:get_number()].distance > d then

		    table[v1:get_number()].distance = d
		    table[v1:get_number()].predecessor =
						v0:get_number()
		    queue:enqueue(Association.new(d, v1))
		end
	    end
	end
    end
    local result = DigraphAsLists.new(n)
    for v = 0, n - 1 do
	result:addVertex(v, table[v].distance)
    end
    for v = 0, n - 1 do
	if v ~= s then
	    result:addEdge(v, table[v].predecessor)
	end
    end
    return result
end
--}>c

--{
-- Floyd's algorithm to solve the all-pairs,
-- shortest path problem
-- for the given edge-weighted, directed graph.
-- @param g An edge-weighted, directed graph.
function Algorithms.floydsAlgorithm(g)
    local n = g:get_numberOfVertices()
    local distance = DenseMatrix.new{n, n}
    for v = 0, n - 1 do
	for w = 0, n - 1 do
	    distance[{v, w}] = Integer.MAX
	end
    end
    for e in g:edges() do
	distance[{e:get_v0():get_number(),
		    e:get_v1():get_number()}] = 
			toint(e:get_weight())
    end
    for i = 0, n - 1 do
	for v = 0, n - 1 do
	    for w = 0,  n - 1 do
		if distance[{v, i}] ~= Integer.MAX and 
			distance[{i, w}] ~= Integer.MAX then
		    local d = distance[{v, i}] + distance[{i, w}]
		    if distance[{v, w}] > d then
			distance[{v, w}] = d
		    end
		end
	    end
	end
    end
    local result = DigraphAsMatrix.new(n)
    for v = 0, n - 1 do
	result:addVertex(v)
    end
    for v = 0, n - 1 do
	for w = 0, n - 1 do
	    if distance[{v, w}] ~= Integer.MAX then
		result:addEdge(v, w, distance[{v, w}])
	    end
	end
    end
    return result
end
--}>d

--{
-- Prim's algorithm to find a minimum-cost spanning tree
-- for the given edge-weighted, undirected graph.
-- @param g An edge-weighted, undirected graph.
-- @param s A node in the graph.
function Algorithms.primsAlgorithm(g, s)
    local n = g:get_numberOfVertices()
    local table = Array.new(n)
    for v = 0, n - 1 do
	table[v] = Algorithms.Entry.new()
    end
    table[s].distance = box(0)
    local queue = BinaryHeap.new(g:get_numberOfEdges())
    queue:enqueue(Association.new(box(0), g[s]))
    while not queue:is_empty() do
	local assoc = queue:dequeueMin()
	local v0 = assoc:get_value()
	if not table[v0:get_number()].known then
	    table[v0:get_number()].known = true
	    for e in v0:emanatingEdges() do
		local v1 = e:mateOf(v0)
		local d = e:get_weight()
		if not table[v1:get_number()].known and
			table[v1:get_number()].distance > d then
		    table[v1:get_number()].distance = d
		    table[v1:get_number()].predecessor =
						v0:get_number()
		    queue:enqueue(Association.new(d, v1))
		end
	    end
	end
    end
    local result = GraphAsLists.new(n)
    for v = 0, n - 1 do
	result:addVertex(v)
    end
    for v = 0, n - 1 do
	if v ~= s then
	    result:addEdge(v, table[v].predecessor)
	end
    end
    return result
end
--}>e

--{
-- Kruskal's algorithm to find a minimum-cost spanning tree
-- for the given edge-weighted, undirected graph.
-- @param g An edge-weighted, undirected graph.
function Algorithms.kruskalsAlgorithm(g)
    local n = g:get_numberOfVertices()
    local result = GraphAsLists.new(n)
    for v = 0, n - 1 do
	result:addVertex(v)
    end
    local queue = BinaryHeap.new(g:get_numberOfEdges())
    for e in g:edges() do
	queue:enqueue(Association.new(e:get_weight(), e))
    end
    local partition = PartitionAsForest.new(n)
    while not queue:is_empty() and partition:get_count() > 1 do
	local e = queue:dequeueMin():get_value()
	local n0 = e:get_v0():get_number()
	local n1 = e:get_v1():get_number()
	local s = partition:find(n0)
	local t = partition:find(n1)
	if s:is_not(t) then
	    partition:join(s, t)
	    result:addEdge(n0, n1)
	end
    end
    return result
end
--}>f

--{
-- Structure used in Dijkstra's and Prim's algorithms.
Algorithms.Entry = Class.new("Algorithms.Entry")

-- Constructor.
function Algorithms.Entry.methods:initialize()
    Algorithms.Entry.super(self)
    self.known = false
    self.distance = box(tonumber(Integer.MAX))
    self.predecessor = -1
end

-- Distance known.
Algorithms.Entry:attr_accessor("known")

-- Distance.
Algorithms.Entry:attr_accessor("distance")

-- Predecessor node.
Algorithms.Entry:attr_accessor("predecessor")
--}>g

--{
-- Computes the critical path in an event-node graph.
-- @param g An event-node graph.
function Algorithms.criticalPathAnalysis(g)
    local n = g:get_numberOfVertices()

    local earliestTime = Array.new(n)
    earliestTime[0] = 0
    g:topologicalOrderTraversal(
	function(w)
	    local t = 0
	    for e in w:incidentEdges() do
		t = math.max(t,
			earliestTime[e:get_v0():get_number()]
			    + tonumber(e:get_weight()))
	    end
	    earliestTime[w:get_number()] = t
	end
    )

    local latestTime = Array.new(n)
    latestTime[n - 1] = earliestTime[n - 1]
    g:depthFirstTraversal(0,
	function(v, mode)
	    if mode == Graph.POSTVISIT then
		local t = tonumber(Integer.MAX)
		for e in v:emanatingEdges() do
		    t = math.min(t,
			latestTime[e:get_v1():get_number()]
			    - tonumber(e:get_weight()))
		end
		latestTime[v:get_number()] = t
	    end
	end
    )

    local slackGraph = DigraphAsLists.new(n)
    for v = 0, n - 1 do
	slackGraph:addVertex(v)
    end
    for e in g:edges() do
	local slack = latestTime[e:get_v1():get_number()] -
	    earliestTime[e:get_v0():get_number()] -
		tonumber(e:get_weight())
	slackGraph:addEdge(
	    e:get_v0():get_number(), e:get_v1():get_number(),
	    e:get_weight())
    end
    return Algorithms.dijkstrasAlgorithm(slackGraph, 0)
end
--}>h

--{
-- A very simple reverse-Polish calculator.
-- @param input Input stream.
-- @param output Output stream.
function Algorithms.calculator(input, output)
    local stack = StackAsLinkedList.new()
    for line in input:lines() do
	for word in string.gfind(line, "%S+") do
	    if word == "+" then
		local arg2 = stack:pop()
		local arg1 = stack:pop()
		stack:push(arg1 + arg2)
	    elseif word == "*" then
		local arg2 = stack:pop()
		local arg1 = stack:pop()
		stack:push (arg1 * arg2)
	    elseif word == "=" then
		local arg = stack:pop()
		output:write(string.format("%s\n",tostring(arg)))
	    else
		n = tonumber(word)
		assert(n, "SyntaxError")
		stack:push(box(n))
	    end
	end
    end
end
--}>j

--{
-- Counts the number of occurrences of each word
-- in the given file.
-- @param input Input stream.
-- @param output Output stream.
function Algorithms.wordCounter(input, output)
    local table = ChainedHashTable.new(1031)
    for line in input:lines() do
	for word in string.gfind(line, "%S+") do
	    local assoc = table:find(Association.new(box(word)))
	    if assoc then
		assoc:set_value(assoc:get_value() + box(1))
	    else
		table:insert(Association.new(box(word), box(1)))
	    end
	end
    end
    output:write(string.format("%s\n",tostring(table)))
end
--}>k

--{
-- Reads all the word pairs from the dictionary file
-- and then reads words from the input file,
-- translates the words (if possible),
-- and writes them to the output file.
-- @param dictionary Dictionary file.
-- @param input Input stream.
-- @param output Output stream.
function Algorithms.translate(dictionary, input, output)
    local searchTree = AVLTree.new()
    for line in dictionary:lines() do
	local words = {}
	for word in string.gfind(line, "%S+") do
	    table.insert(words, word)
	end
	assert(table.getn(words) == 2, "SyntaxError")
	searchTree:insert(
	    Association.new(box(words[1]),box(words[2])))
    end
    for line in input:lines() do
	for word in string.gfind(line, "%S+") do
	    assoc = searchTree:find(Association.new(box(word)))
	    if assoc then
		output:write(string.format(
		    "%s ", tostring(assoc:get_value())))
	    else
		output:write(string.format("%s ", word))
	    end
	end
	output:write("\n")
    end
end
--}>l
