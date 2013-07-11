#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: DepthFirstSolver.lua,v $
    $Revision: 1.1 $

    $Id: DepthFirstSolver.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Solver"

--{
-- Depth-first solver.
DepthFirstSolver = Class.new("DepthFirstSolver", Solver)

-- Constructor.
function DepthFirstSolver.methods:initialize()
    DepthFirstSolver.super(self)
end

-- Does a depth-first traversal of the solution space
-- starting from the given node.
-- @param current A node in the solution space of a problem.
function DepthFirstSolver.methods:search(current)
    if current:is_complete() then
	self:updateBest(current)
    else
	for succ in current:successors() do
	    self:search(succ)
	end
    end
end
--}>a
