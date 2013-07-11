#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 23:30:16 $
    $RCSfile: Edge.lua,v $
    $Revision: 1.1 $

    $Id: Edge.lua,v 1.1 2004/11/28 23:30:16 brpreiss Exp $

--]]

require "Class"

--{
-- Abstract base class from which all graph edge classes are derived.
Edge = Class.new("Edge")

-- Constructor.
function Edge.methods:initialize()
    Edge.super(self)
end

-- The vertex at the tail of the edge.
Edge:abstract_method("get_v0")

-- The vertex at the head of the edge.
Edge:abstract_method("get_v1")

-- The weight on the vertex.
Edge:abstract_method("get_weight")

-- True if the edge is directed.
Edge:abstract_method("is_directed")

-- Returns the mate of the given vertex of this edge
-- @param v A vertex of this edge.
Edge:abstract_method("mateOf")
--}>a
