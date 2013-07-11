#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: BreadthFirstSolver.lua,v $
    $Revision: 1.1 $

    $Id: BreadthFirstSolver.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Solver"
require "QueueAsLinkedList"

--{
-- Breadth-first problem solver.
BreadthFirstSolver = Class.new("BreadthFirstSolver", Solver)

-- Constructor.
function BreadthFirstSolver.methods:initialize()
    BreadthFirstSolver.super(self)
end

-- Does a breadth-first traversal of the solution space
-- starting from the given node.
-- @param current A node in the solution space of a problem.
function BreadthFirstSolver.methods:search(initial)
    local queue = QueueAsLinkedList.new()
    queue:enqueue(initial)
    while not queue:is_empty() do
	local current = queue:dequeue()
	if current:is_complete() then
	    self:updateBest(current)
	else
	    for succ in current:successors() do
		queue:enqueue(succ)
	    end
	end
    end
end
--}>a
