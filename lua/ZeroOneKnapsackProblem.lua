#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: ZeroOneKnapsackProblem.lua,v $
    $Revision: 1.1 $

    $Id: ZeroOneKnapsackProblem.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Object"
require "Solution"
require "Solver"

-- Represents a 0-1 knapsack problem.
ZeroOneKnapsackProblem = Class.new("ZeroOneKnapsackProblem", Object)

-- Constructs a 0-1 knapsack problem with the given
-- arrays of weights and profits and the given knapsack capacity.
-- @param weight Array of weights.
-- @param profit Array of profits.
-- @param capacity Knapsack capacity.
function ZeroOneKnapsackProblem.methods:initialize(weight, profit, capacity)
    ZeroOneKnapsackProblem.super(self)
    self.numberOfItems = weight.length
    self.weight = weight
    self.profit = profit
    self.capacity = capacity
end

-- The number of items.
ZeroOneKnapsackProblem:attr_reader("numberOfItems")

-- The weights of the items.
ZeroOneKnapsackProblem:attr_reader("weight")

-- The profits of the items.
ZeroOneKnapsackProblem:attr_reader("profit")

-- The knapsack capacity.
ZeroOneKnapsackProblem:attr_reader("capacity")

-- Solves this 0-1 knapsack problem using the given problem solver.
-- @param solver A problem solver.
function ZeroOneKnapsackProblem.methods:solve(solver)
    assert(solver:is_instanceOf(Solver), "TypeError")
    return solver:solve(ZeroOneKnapsackProblem.Node.new(self))
end

-- Represents a node in the solutions space of a 0-1 knapsack problem.
ZeroOneKnapsackProblem.Node =
    Class.new("ZeroOneKnapsackProblem.Node", Solution)

-- Constructs a node in the solution space of the given
-- 0-1 knapsack problem.
-- +problem+:: A 0-1 knapsack problem.
function ZeroOneKnapsackProblem.Node.methods:initialize(problem)
    ZeroOneKnapsackProblem.Node.super(self)
    self.problem = problem
    self.totalWeight = 0
    self.totalProfit = 0
    self.unplacedProfit = 0
    self.numberPlaced = 0
    self.x = Array.new(problem.numberOfItems)
    for i = 0, self.problem.numberOfItems - 1 do
	self.unplacedProfit = self.unplacedProfit + self.problem.profit[i]
    end
end

-- The total weight of the weights in the knapsack.
ZeroOneKnapsackProblem.Node:attr_accessor("totalWeight")

-- The total profit of the weights in the knapsack.
ZeroOneKnapsackProblem.Node:attr_accessor("totalProfit")

-- The total profit of the weights not yet placed.
ZeroOneKnapsackProblem.Node:attr_accessor("unplacedProfit")

-- The number of weights placed in or out of the knapsack.
ZeroOneKnapsackProblem.Node:attr_accessor("numberPlaced")

-- An array of 0/1 values indicating the placement of weights.
-- The value 1 indicates the weight is placed in the knapsack.
ZeroOneKnapsackProblem.Node:attr_accessor("x")

-- Returns a clone of this node.
function ZeroOneKnapsackProblem.Node.methods:clone()
    result = ZeroOneKnapsackProblem.Node.new(self.problem)
    result.totalWeight = self.totalWeight
    result.totalProfit = self.totalProfit
    result.numberPlaced = self.numberPlaced
    for i = 0, self.problem.numberOfItems - 1 do
	result.x[i] = self.x[i]
    end
    result.unplacedProfit = self.unplacedProfit
    return result
end

-- Returns the value of the objective function for this node.
function ZeroOneKnapsackProblem.Node.methods:get_objective()
    return -self.totalProfit
end

-- Returns an lower bound on the value of the objective function
-- for all the successors of this node in the solution space.
function ZeroOneKnapsackProblem.Node.methods:get_bound()
    return -(self.totalProfit + self.unplacedProfit)
end

-- True if this node represents a feasible solution.
function ZeroOneKnapsackProblem.Node.methods:is_feasible()
    return self.totalWeight <= self.problem.capacity
end

-- True if this node represents a complete solution.
function ZeroOneKnapsackProblem.Node.methods:is_complete()
    return self.numberPlaced == self.problem.numberOfItems
end

-- Places the next unplaced weight in or out of the knapsack
-- according to the given value.
-- @param value 0 indicate the weight is left out of the knapsack;
--              1 indicates the weight is placed into the knapsack.
function ZeroOneKnapsackProblem.Node.methods:placeNext(value)
    self.x[self.numberPlaced] = value
    if value == 1 then
	self.totalWeight =
	    self.totalWeight + self.problem.weight[self.numberPlaced]
	self.totalProfit =
	    self.totalProfit + self.problem.profit[self.numberPlaced]
	self.unplacedProfit =
	    self.unplacedProfit - self.problem.profit[self.numberPlaced]
    end
    self.numberPlaced = self.numberPlaced + 1
    return self
end

-- Returns a string representation of this node.
function ZeroOneKnapsackProblem.Node.methods:toString()
    local s = ""
    for i = 0, self.numberPlaced - 1 do
	if s ~= "" then
	    s = s .. ", "
	end
	s = s .. tostring(self.x[i])
    end
    s = s .. ", total weight = " .. tostring(self.totalWeight)
    s = s .. ", total profit = " .. tostring(self.totalProfit)
    return s
end

-- Returns an iterator that enumerates
-- the immediates successors of this node
-- in the solution space.
function ZeroOneKnapsackProblem.Node.methods:successors()
    local x = 0 -- Iterator state.
    return
	function()
	    local result = nil
	    if x <= 1 then
		result = self:clone():placeNext(x)
		x = x + 1
	    end
	    return result
	end
end
