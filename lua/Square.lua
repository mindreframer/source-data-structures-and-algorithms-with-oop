#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/04 01:00:53 $
    $RCSfile: Square.lua,v $
    $Revision: 1.1 $

    $Id: Square.lua,v 1.1 2004/12/04 01:00:53 brpreiss Exp $

--]]

require "Rectangle"
require "GraphicalObject"
require "Point"

--{
-- A square.
Square = Class.new("Square", Rectangle)

-- Constructs a square with the given center point and dimensions.
-- @param center A point.
-- @param width The width (and height) of the square.
function Square.methods:initialize(center, width)
    Square.super(self, center, width, width)
end
--}>a

-- Square test program.
-- +argv+:: Command-line arguments.
function Square.main(arg)
    print "Square test program."
    local c = Square.new(Point.new(0,0), 1)
    GraphicalObject.test(c)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Square.main(arg) )
end
