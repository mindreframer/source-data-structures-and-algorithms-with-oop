#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/04 01:00:53 $
    $RCSfile: Point.lua,v $
    $Revision: 1.1 $

    $Id: Point.lua,v 1.1 2004/12/04 01:00:53 brpreiss Exp $

--]]

--{
-- Represents a point in the Cartesian plane.
require "Class"

Point = Class.new("Point")

-- Constructs a point with the given coordinates.
-- @param x The abcissa.
-- @param y The ordinate.
function Point.methods:initialize(x, y)
    self.x = x
    self.y = y
end

-- The abcissa.
Point:attr_reader("x")

-- The ordinate.
Point:attr_reader("y")
--}>a

-- Returns a string representation of this point.
function Point.methods:toString()
    return string.format("Point(%d,%d)", self.x, self.y)
end
