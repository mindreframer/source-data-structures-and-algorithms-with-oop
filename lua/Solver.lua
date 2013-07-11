#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: Solver.lua,v $
    $Revision: 1.1 $

    $Id: Solver.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Object"
require "Solution"
require "Integer"

--{
-- Abstract base class from which all problem solver classes are derived.
Solver = Class.new("Solver", Object)

-- Constructor.
function Solver.methods:initialize()
    Solver.super(self)
    self.bestSolution = nil
    self.bestObjective = tonumber(Integer.MAX)
end

-- Searches the solution space.
Solver:abstract_method("search")

-- Solves a problem by searching its solution space starting from
-- the given initial node.
-- @param initial A node in the solution space of a problem.
function Solver.methods:solve(initial)
    assert(initial:is_instanceOf(Solution), "TypeError")
    self.bestSolution = nil
    self.bestObjective = tonumber(Integer.MAX)
    self:search(initial)
    return self.bestSolution
end

-- Updates the current best solution with the given solution
-- if the given solution is complete, feasible,
-- and the value of its objective function is better than
-- the current best solution.
-- @param solution A node in the solution space of a problem.
function Solver.methods:updateBest(solution)
    if solution:is_complete() and solution:is_feasible() and
	    solution:get_objective() < self.bestObjective then
	self.bestSolution = solution
	self.bestObjective = solution:get_objective()
    end
end
--}>a
--++
