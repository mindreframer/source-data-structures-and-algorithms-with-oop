#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 18:50:06 $
    $RCSfile: Rectangle.lua,v $
    $Revision: 1.2 $

    $Id: Rectangle.lua,v 1.2 2004/12/05 18:50:06 brpreiss Exp $

--]]

require "GraphicalObject"
require "Point"

--{
-- A rectangle.
Rectangle = Class.new("Rectangle", GraphicalObject)

-- Constructs a rectangle with the given center point and dimensions.
-- @param center A point.
-- @param height The height.
-- @param width The width.
function Rectangle.methods:initialize(center, height, width)
    Rectangle.super(self, center)
    self.height = height
    self.width = width
end

-- Draws this rectangle.
function Rectangle.methods:draw()
    -- ...
--<
    print("RECTANGLE", self.center, self.height, self.width)
-->
end
--}>a

-- Rectangle test program.
-- @param arg Command-line arguments.
function Rectangle.main(arg)
    print "Rectangle test program."
    local c = Rectangle.new(Point.new(0,0), 1, 2)
    GraphicalObject.test(c)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Rectangle.main(arg) )
end
