#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: SparseMatrixAsArray.lua,v $
    $Revision: 1.5 $

    $Id: SparseMatrixAsArray.lua,v 1.5 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Matrix"
require "SparseMatrix"
require "MultiDimensionalArray"

-- Sparse matrix implemented using a two-dimensional array.
SparseMatrixAsArray = Class.new("SparseMatrixAsArray", SparseMatrix)

-- Marks the end of a row.
SparseMatrixAsArray.END_OF_ROW = -1

-- Constructs a sparse matrix with the given number of rows and columns
-- and the given row fill.
-- The row fill is the maximum number of non-zero entries allowed
-- in a row of the matrix.
-- @param dimensions The dimensions.
-- @param fill The row fill.
function SparseMatrixAsArray.methods:initialize(dimensions, fill)
    SparseMatrixAsArray.super(self, dimensions[1], dimensions[2])
    self.fill = fill
    self.values = MultiDimensionalArray.new{dimensions[2], fill}
    self.columns = MultiDimensionalArray.new{dimensions[2], fill}
    for i = 0, self.numberOfRows - 1 do
	self.columns[{i, 0}] = self.END_OF_ROW
    end
end

-- Returns the column index where the (i,j) element
-- of this sparse matrix is stored.
-- @param i Row index.
-- @param j Column index.
function SparseMatrixAsArray.methods:findPosition(i, j)
    local k = 0
    while k < self.fill and self.columns[{i, k}] ~= self.END_OF_ROW do
	if self.columns[{i, k}] == j then
	    return k
	end
	k = k + 1
    end
    return -1
end

-- Returns the value at the given indices in this sparse matrix.
-- @param indices Array indices.
function SparseMatrixAsArray.methods:getitem(indices)
    local i = indices[1]
    local j = indices[2]
    assert(i >= 0 and i < self.numberOfRows, "IndexError")
    assert(j >= 0 and j < self.numberOfColumns, "IndexError")
    local position = self:findPosition(i, j)
    if position >= 0 then
	return self.values[{i, position}]
    else
	return 0
    end
end

-- Sets the entry at the given indices in this sparse matrix
-- to the given value.
-- @param indices Array indices.
-- @param value A (non-zero) value.
function SparseMatrixAsArray.methods:setitem(indices, value)
    local i = indices[1]
    local j = indices[2]
    assert(i >= 0 and i < self.numberOfRows, "IndexError")
    assert(j >= 0 and j < self.numberOfColumns, "IndexError")
    local position = self:findPosition(i, j)
    if position >= 0 then
	self.values[{i, position}] = value
    else
	local k = 0
	while k < self.fill and self.columns[{i, k}] ~= self.END_OF_ROW do
	    k = k + 1
	end
	assert(k < self.fill, "IndexError")
	if k < self.fill - 1 then
	    self.columns[{i, k + 1}] = self.END_OF_ROW
	end
	while k > 0 and self.columns[{i, k}] >= j do
	    self.values[{i, k}] = self.values[{i, k - 1}]
	    self.columns[{i, k}] = self.columns[{i, k - 1}]
	    k = k - 1
	end
	self.values[{i, k}] = value
	self.columns[{i, k}] = j
    end
end

-- Sets the entry at the given indices in this sparse matrix to zero.
-- +i+:: Row index.
-- +j+:: Column index.
function SparseMatrixAsArray.methods:putZero(i, j)
    local i = indices[1]
    local j = indices[2]
    assert(i >= 0 and i < self.numberOfRows, "IndexError")
    assert(j >= 0 and j < self.numberOfColumns, "IndexError")
    local position = self:findPosition(i, j)
    if position >= 0 then
	local k = position
	while k < numberOfColumns - 1 and 
		self.columns[{i, k + 1}] ~= END_OF_ROW do
	    self.values[{i, k}] = self.values[{i, k + 1}]
	    self.columns[{i, k}] = self.columns[{i, k + 1}]
	    k = k + 1
	end
	if k < self.numberOfColumns then
	    self.columns[{i, k}] = self.END_OF_ROW
	end
    end
end

-- SparseMatrixAsArray test program.
-- @param arg Command-line arguments.
function SparseMatrixAsArray.main(arg)
    print "SparseMatrixAsArray test program."
    local mat = SparseMatrixAsArray.new({6, 6}, 3)
    --Matrix.test(mat)
    --Matrix:TestTranspose(mat)
    --Matrix:TestTimes(mat, mat)
    print(mat)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SparseMatrixAsArray.main(arg) )
end
