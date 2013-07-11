#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 02:33:07 $
    $RCSfile: Application11.lua,v $
    $Revision: 1.1 $

    $Id: Application11.lua,v 1.1 2004/12/02 02:33:07 brpreiss Exp $

--]]

require "GraphAsMatrix"
require "GraphAsLists"
require "DigraphAsMatrix"
require "DigraphAsLists"
require "Algorithms"

-- Provides application program number 11.
Application11 = Module.new("Application11")

-- Weighted graph test program.
-- @param g The weighted graph to test.
function Application11.weightedGraphTest(g)
    print "Weighted graph test program."
    g:addVertex(0, box(123))
    g:addVertex(1, box(234))
    g:addVertex(2, box(345))
    g:addEdge(0, 1, box(3))
    g:addEdge(0, 2, box(1))
    g:addEdge(1, 2, box(4))
    print(g)
    print "Prim's Algorithm"
    local g2 = Algorithms.primsAlgorithm(g, 0)
    print(g2)
    print "Kruskal's Algorithm"
    g2 = Algorithms.kruskalsAlgorithm(g)
    print(g2)
end

-- Weighted digraph test program.
-- @param g The weighted digraph to test.
function Application11.weightedDigraphTest(g)
    print "Weighted digraph test program."
    Application11.weightedGraphTest(g)
    print "Dijkstra's Algorithm"
    local g2 = Algorithms.dijkstrasAlgorithm(g, 0)
    print(g2)
    print "Floyd's Algorithm"
    g2 = Algorithms.floydsAlgorithm(g)
    print(g2)
end

-- Application program number 11.
-- @param arg Command-line arguments.
function Application11.main(arg)
    print "Application11 test program."

    local g = GraphAsMatrix.new(32)
    Application11.weightedGraphTest(g)

    g = GraphAsLists.new(32)
    Application11.weightedGraphTest(g)

    g = DigraphAsMatrix.new(32)
    Application11.weightedDigraphTest(g)

    g = DigraphAsLists.new(32)
    Application11.weightedDigraphTest(g)

    print "Critical path analysis."
    g = DigraphAsMatrix.new(10)
    for v = 0, 9 do
	g:addVertex(v)
    end
    g:addEdge(0, 1, box(3))
    g:addEdge(1, 2, box(1))
    g:addEdge(1, 3, box(4))
    g:addEdge(2, 4, box(0))
    g:addEdge(3, 4, box(0))
    g:addEdge(4, 5, box(1))
    g:addEdge(5, 6, box(9))
    g:addEdge(5, 7, box(5))
    g:addEdge(6, 8, box(0))
    g:addEdge(7, 8, box(0))
    g:addEdge(8, 9, box(2))
    print(g)
    g = Algorithms.criticalPathAnalysis(g)
    print(g)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application11.main(arg) )
end
