#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: ScalesBalancingProblem.lua,v $
    $Revision: 1.1 $

    $Id: ScalesBalancingProblem.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Solution"
require "Solver"
require "Array"

-- Represents a scales-balancing problem.
ScalesBalancingProblem = Class.new("ScalesBalancingProblem")

-- Constructs a scales balancing problem with the given array of weights.
-- @param weight An array of weights.
function ScalesBalancingProblem.methods:initialize(weight)
    ScalesBalancingProblem.super(self)
    self.weight = weight
    self.numberOfWeights = weight.length
end

-- The weights array.
ScalesBalancingProblem:attr_reader("weight")

-- The number of weights.
ScalesBalancingProblem:attr_reader("numberOfWeights")

-- Solves this scales balancing problem using the given problem solver.
-- @param solver A problem solver.
function ScalesBalancingProblem.methods:solve(solver)
    assert(solver:is_instanceOf(Solver), "TypeError")
    return solver:solve(ScalesBalancingProblem.Node.new(self))
end

-- Represents a node in the solution space of a scales balancing problem.
ScalesBalancingProblem.Node = Class.new("ScalesBalancingProblem.Node", Solution)

-- Constructs a node in the solution space
-- of the given scales balancing problem.
-- +problem+:: A scales balancing problem.
function ScalesBalancingProblem.Node.methods:initialize(problem)
    ScalesBalancingProblem.Node.super(self)
    self.problem = problem
    self.diff = 0
    self.unplacedTotal = 0
    self.numberPlaced = 0
    self.pan = Array.new(self.problem.numberOfWeights)
    for i = 0, self.problem.numberOfWeights - 1 do
	self.unplacedTotal = self.unplacedTotal + self.problem.weight[i]
    end
end

-- The difference in weights between the left and right pans.
ScalesBalancingProblem.Node:attr_accessor("diff")

-- The number of weights placed in pans.
ScalesBalancingProblem.Node:attr_accessor("numberPlaced")

-- The total weight of the weights not yet placed in pans.
ScalesBalancingProblem.Node:attr_accessor("unplacedTotal")

-- Array of 0/1 values indicating
-- the pan in which each weight has been placed.
ScalesBalancingProblem.Node:attr_accessor("pan")

-- Returns a clone of this node.
function ScalesBalancingProblem.Node.methods:clone()
    result = ScalesBalancingProblem.Node.new(self.problem)
    result.diff = self.diff
    result.numberPlaced = self.numberPlaced
    for i = 0, self.problem.numberOfWeights - 1 do
	result.pan[i] = self.pan[i]
    end
    result.unplacedTotal = self.unplacedTotal
    return result
end

-- The value of the objective function for this node.
function ScalesBalancingProblem.Node.methods:get_objective()
    return math.abs(self.diff)
end

-- The lower-bound on the objective function value
-- for all the successors of this node in the solution space.
function ScalesBalancingProblem.Node.methods:get_bound()
    if math.abs(self.diff) > self.unplacedTotal then
	return math.abs(self.diff) - self.unplacedTotal
    else
	return 0
    end
end

-- True if this node is a feasible solution.
function ScalesBalancingProblem.Node.methods:is_feasible()
    return true
end

-- True if ths node is a complete solution.
function ScalesBalancingProblem.Node.methods:is_complete()
    return self.numberPlaced == self.problem.numberOfWeights
end

-- Places the next unplaced weight in the specified pan.
-- @param pan The pan in which to place the next weight.
function ScalesBalancingProblem.Node.methods:placeNext(pan)
    self.pan[self.numberPlaced] = pan
    if pan == 0 then
	self.diff = self.diff + self.problem.weight[self.numberPlaced]
    else
	self.diff = self.diff - self.problem.weight[self.numberPlaced]
    end
    self.unplacedTotal = self.unplacedTotal -
			    self.problem.weight[self.numberPlaced]
    self.numberPlaced = self.numberPlaced + 1
    return self
end

-- Returns a string representation of this node.
function ScalesBalancingProblem.Node.methods:toString()
    local s = ""
    for i = 0, self.numberPlaced - 1 do
	if s ~= "" then
	    s = s .. ", "
	end
	s = s .. tostring(self.pan[i])
    end
    s = s .. ", diff = " .. tostring(self.diff)
    return s
end

-- Returns an iterator that enumerates
-- the immediate successors
-- of this node in the solution space.
function ScalesBalancingProblem.Node.methods:successors()
    local pan = 0 -- Iterator state.
    return
	function()
	    result = nil
	    if pan <= 1 then
		result = self:clone():placeNext(pan)
		pan = pan + 1
	    end
	    return result
	end
end
