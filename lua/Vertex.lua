#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 23:30:16 $
    $RCSfile: Vertex.lua,v $
    $Revision: 1.1 $

    $Id: Vertex.lua,v 1.1 2004/11/28 23:30:16 brpreiss Exp $

--]]

require "Class"

--{
-- Abstract base class from which all vertex classes are derived.
Vertex = Class.new("Vertex")

-- Constructor
function Vertex.methods:initialize()
    Vertex.super(self)
end

-- The number of this vertex.
Vertex:abstract_method("get_number")

-- The weight on this vertex.
Vertex:abstract_method("get_weight")

-- Returns an iterator that enumerates
-- the incident edges of of this vertex.
Vertex:abstract_method("incidentEdges")

-- Returns an iterator that enumerates
-- the emanating edges of of this vertex.
Vertex:abstract_method("emanatingEdges")

-- Returns an iterator that enumerates
-- the predecessor vertices of of this vertex.
Vertex:abstract_method("predecessors")

-- Returns an iterator that enumerates
-- the successor vertices of of this vertex.
Vertex:abstract_method("successors")
--}>a
