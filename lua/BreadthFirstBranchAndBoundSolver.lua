#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: BreadthFirstBranchAndBoundSolver.lua,v $
    $Revision: 1.1 $

    $Id: BreadthFirstBranchAndBoundSolver.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Solver"
require "QueueAsLinkedList"

-- Breadth-first branch-and-bound problem solver.
BreadthFirstBranchAndBoundSolver =
    Class.new("BreadthFirstBranchAndBoundSolver", Solver)

-- Constructor.
function BreadthFirstBranchAndBoundSolver.methods:initialize()
    BreadthFirstBranchAndBoundSolver.super(self)
end

-- Does a breadth-first traversal of the solution space
-- starting from the given initial node.
-- Prunes subtrees from the search space when the lower bound
-- on the value of the objective function for a subtree 
-- exceeds that of the best solution already found.
-- +initial+:: A node in the solution space of a problem.
function BreadthFirstBranchAndBoundSolver.methods:search(initial)
    local queue = QueueAsLinkedList.new()
    if initial:is_feasible() then
	queue:enqueue(initial)
    end
    while not queue:is_empty() do
	local current = queue:dequeue()
	if current:is_complete() then
	    self:updateBest(current)
	else
	    for succ in current:successors() do
		if succ:is_feasible() and
			succ:get_bound() < self.bestObjective then
		    queue:enqueue(succ)
		end
	    end
	end
    end
end
