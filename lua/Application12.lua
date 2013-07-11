#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 16:50:11 $
    $RCSfile: Application12.lua,v $
    $Revision: 1.2 $

    $Id: Application12.lua,v 1.2 2004/12/05 16:50:11 brpreiss Exp $

--]]

require "Array"
require "DepthFirstSolver"
require "DepthFirstBranchAndBoundSolver"
require "BreadthFirstSolver"
require "BreadthFirstBranchAndBoundSolver"
require "ScalesBalancingProblem"
require "ZeroOneKnapsackProblem"

-- Provides application program number 12.
Application12 = Module.new("Application12")

-- Application program number 12.
-- @param arg Command-line arguments.
function Application12.main(arg)
    print "Application12 test program."
    local solver1 = DepthFirstSolver.new()
    local solver2 = DepthFirstBranchAndBoundSolver.new()
    local solver3 = BreadthFirstSolver.new()
    local solver4 = BreadthFirstBranchAndBoundSolver.new()

    local weights = box{20, 20, 2, 2, 1}
    local scales = ScalesBalancingProblem.new(weights)
    print(scales:solve(solver1))
    print(scales:solve(solver2))
    print(scales:solve(solver3))
    print(scales:solve(solver4))


    local weights = box{100, 50, 45, 20, 10, 5}
    local profits = box{ 40, 35, 18,  4, 10, 2}
    local knapsack = ZeroOneKnapsackProblem.new(weights, profits, 100)
    print(knapsack:solve(solver1))
    print(knapsack:solve(solver2))
    print(knapsack:solve(solver3))
    print(knapsack:solve(solver4))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Application12.main(arg) )
end
