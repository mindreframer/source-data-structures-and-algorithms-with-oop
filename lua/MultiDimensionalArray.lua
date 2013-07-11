#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: MultiDimensionalArray.lua,v $
    $Revision: 1.6 $

    $Id: MultiDimensionalArray.lua,v 1.6 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Array"

--{
-- Represents a multi-dimensional array.
MultiDimensionalArray = Class.new("MultiDimensionalArray")

-- Constructs a multi-dimensional array
-- with the given dimensions.
-- @param dimensions The dimensions.
function MultiDimensionalArray.methods:initialize(dimensions)
    MultiDimensionalArray.super(self)
    self.dimensions = Array.new(table.getn(dimensions), 1)
    self.factors = Array.new(table.getn(dimensions), 1)
    local product = 1
    local i = table.getn(dimensions)
    while i > 0 do
	self.dimensions[i] = dimensions[i]
	self.factors[i] = product
	product = product * self.dimensions[i]
	i = i - 1
    end
    self.data = Array.new(product)
end
--}>a

--{
-- Returns the offset for the given indices.
-- @param indices Array indices.
function MultiDimensionalArray.methods:getOffset(indices)
    assert( table.getn(indices) == self.dimensions:get_length(),
	    "IndexError")
    local offset = 0
    for i = 1, self.dimensions:get_length() do
	assert( indices[i] >= 0 and
		indices[i] < self.dimensions[i], "IndexError")
	offset = offset + self.factors[i] * indices[i]
    end
    return offset
end

-- Returns the item in this matrix at the position given by the indices.
-- @param indices Array indices
function MultiDimensionalArray.methods:getitem(indices)
    return self.data[self:getOffset(indices)]
end

-- Sets the item in this matrix
-- at the position given by the indices
-- to the given value.
-- @param indices array indices.
-- @param value A value.
function MultiDimensionalArray.methods:setitem(indices, value)
    self.data[self:getOffset(indices)] = value
end
--}>b

-- Returns a string representation
-- of this multi-dimensional array.
function MultiDimensionalArray.methods:toString()
    return string.format (
	"MultiDimensionalArray" ..
	"{dimensions = %s, factors = %s, data = %s}",
	tostring(self.dimensions),
	tostring(self.factors),
	tostring(self.data))
end

-- MultiDimensionalArray test program.
-- @param arg Command-line arguments.
function MultiDimensionalArray.main(arg)
    print "MultiDimensionalArray test program."
    local m = MultiDimensionalArray.new{2, 3, 4}
    m[{1, 2, 3}] = 57
    print(m[{1, 2, 3}])
    print(m)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( MultiDimensionalArray.main(arg) )
end
