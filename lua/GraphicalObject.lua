#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/04 01:00:53 $
    $RCSfile: GraphicalObject.lua,v $
    $Revision: 1.1 $

    $Id: GraphicalObject.lua,v 1.1 2004/12/04 01:00:53 brpreiss Exp $

--]]

require "Object"
require "Point"

--{
-- Base class from which graphical object classes are derived.
GraphicalObject = Class.new("GraphicalObject", Object)

-- Constructs a graphical object with the given center point.
-- @param center A point.
function GraphicalObject.methods:initialize(center)
    GraphicalObject.super(self)
    self.center = center
end

-- Draws this graphical object.
GraphicalObject:abstract_method("draw")

-- Erases this graphical object.
function GraphicalObject.methods:erase()
    self:setPenColor(GraphicalObject.BACKGROUND_COLOR)
    self:draw()
    self:setPenColor(GraphicalObject.FOREGROUND_COLOR)
end

-- Moves this graphical object to the given point.
-- @param p A point.
function GraphicalObject.methods:moveTo(p)
    self:erase()
    self.center = p
    self:draw()
end
--}>a

-- Background color.
GraphicalObject.BACKGROUND_COLOR = 0

-- Foreground color.
GraphicalObject.FOREGROUND_COLOR = 1

-- Sets the pen color to the given color.
-- @param color A color.
function GraphicalObject.methods:setPenColor(color)
end

-- GraphicalObject test program.
-- @param go The graphical object to test.
function GraphicalObject.test(go)
    print "GraphicalObject test program."
    go:draw()
    go:moveTo(Point.new(1,1))
    go:erase()
end
