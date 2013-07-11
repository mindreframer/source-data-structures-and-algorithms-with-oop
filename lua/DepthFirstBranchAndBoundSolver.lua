#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: DepthFirstBranchAndBoundSolver.lua,v $
    $Revision: 1.2 $

    $Id: DepthFirstBranchAndBoundSolver.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Solver"

--{
-- Depth-first branch-and-bound problem solver.
DepthFirstBranchAndBoundSolver =
    Class.new("DepthFirstBranchAndBoundSolver", Solver)

-- Constructor.
function DepthFirstBranchAndBoundSolver.methods:initialize()
    DepthFirstBranchAndBoundSolver.super(self)
end

-- Does a depth-first traversal of the solution space
-- starting from the given initial node.
-- Prunes subtrees from the search space when the lower bound
-- on the value of the objective function for a subtree 
-- exceeds that of the best solution already found.
-- @param current A node in the solution space of a problem.
function DepthFirstBranchAndBoundSolver.methods:search(current)
    if current:is_complete() then
	self:updateBest(current)
    else
	for succ in current:successors() do
	    if succ:is_feasible() and
		    succ:get_bound() < self.bestObjective then
		self:search(succ)
	    end
	end
    end
end
--}>a
