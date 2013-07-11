#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 02:19:31 $
    $RCSfile: Solution.lua,v $
    $Revision: 1.1 $

    $Id: Solution.lua,v 1.1 2004/12/03 02:19:31 brpreiss Exp $

--]]

require "Class"

--{
-- Represents a node in the solution-space of a problem.
Solution = Class.new("Solution", Object)

-- Constructor.
function Solution.methods:initialize()
    Solution.super(self)
end

-- True if this node represents a feasible solution.
Solution:abstract_method("is_feasible")

-- True if this node represents a complete solution.
Solution:abstract_method("is_complete")

-- The value of objective function for this node.
Solution:abstract_method("get_objective")

-- Upper bound on the value of objective function for this node
-- and all it successors in the solution space.
Solution:abstract_method("get_bound")

-- Returns an iterator that enumerates
-- the immediate successors of this node.
Solution:abstract_method("successors")
--}>a
