#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 18:50:06 $
    $RCSfile: Circle.lua,v $
    $Revision: 1.2 $

    $Id: Circle.lua,v 1.2 2004/12/05 18:50:06 brpreiss Exp $

--]]

require "GraphicalObject"
require "Point"

--{
-- A circle.
Circle = Class.new("Circle", GraphicalObject)

-- Constructs a circle with the given center point and radius.
-- @param center A point.
-- @param radius The radius.
function Circle.methods:initialize(center, radius)
    Circle.super(self, center)
    self.radius = radius
end

-- Draws this circle.
function Circle.methods:draw()
    -- ...
--<
    print("CIRCLE", self.center, self.radius)
-->
end
--}>a

-- Circle test program.
-- @param arg Command-line arguments.
function Circle.main(arg)
    print "Circle test program."
    local c = Circle.new(Point.new(0,0), 1)
    GraphicalObject.test(c)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Circle.main(arg) )
end
