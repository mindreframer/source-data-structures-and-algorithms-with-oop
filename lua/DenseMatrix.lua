#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: DenseMatrix.lua,v $
    $Revision: 1.7 $

    $Id: DenseMatrix.lua,v 1.7 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Matrix"
require "MultiDimensionalArray"

--{
-- A dense matrix implemented as
-- a multi-dimensional array with 2 dimensions.
DenseMatrix = Class.new("DenseMatrix", Matrix)

-- Constructs a dense matrix
-- with the given number of rows and columns.
-- @param dimensions The array dimensions.
function DenseMatrix.methods:initialize(dimensions)
    DenseMatrix.super(self, dimensions[1], dimensions[2])
    self.array = MultiDimensionalArray.new(dimensions)
end

-- Returns the item in this matrix at the given indices.
-- @param indices The indices.
function DenseMatrix.methods:getitem(indices)
    return self.array[indices]
end

-- Sets the item in this matrix at the given indices
-- to the given value.
-- @param indices The row index.
-- @param value A value.
function DenseMatrix.methods:setitem(indices, value)
    self.array[indices] = value
end
--}>a

--{
-- Multiplication operator.
-- Returns the product of this matrix and the given matrix.
-- @param mat A matrix.
function DenseMatrix.methods:mul(mat)
    assert( self.numberOfColumns == mat.numberOfRows,
	    "DomainError")
    local result =
	DenseMatrix.new{self.numberOfRows, mat.numberOfColumns}
    for i = 0, self.numberOfRows - 1 do
	for j = 0, mat.numberOfColumns - 1 do
	    local sum = 0
	    for k = 0, self.numberOfColumns - 1 do
		sum = sum + self[{i,k}] * mat[{k,j}]
	    end
	    result[{i,j}] = sum
	end
    end
    return result
end
--}>b

-- Addition operator.
-- Returns the sum of this matrix and the given matrix.
-- @param mat A matrix.
function DenseMatrix.methods:add(mat)
    assert( self.numberOfColumns == mat.numberOfColumns and
	    self.numberOfRows == mat.numberOfRows, "DomainError")
    local result =
	DenseMatrix.new{self.numberOfRows, self.numberOfColumns}
    for i = 0, self.numberOfRows - 1 do
	for j = 0, self.numberOfColumns - 1 do
	    result[{i,j}] = self[{i,j}] + mat[{i,j}]
	end
    end
    return result
end

-- Returns the transpose of this matrix.
function DenseMatrix.methods:transpose()
    local result =
	DenseMatrix.new{self.numberOfColumns, self.numberOfRows}
    for i = 0, self.numberOfRows - 1 do
	for j = 0, self.numberOfColumns - 1 do
	    result[{i,j}] = self[{j,i}]
	end
    end
    return result
end

-- DenseMatrix test program.
-- @param arg Command-line arguments.
function DenseMatrix.main(arg)
    print "DenseMatrix test program"
    local mat = DenseMatrix.new{6, 6}
    Matrix.test(mat)
    Matrix.testTranspose(mat)
    Matrix.testTimes(mat, mat)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( DenseMatrix.main(arg) )
end
