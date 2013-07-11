#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: SparseMatrixAsVector.lua,v $
    $Revision: 1.7 $

    $Id: SparseMatrixAsVector.lua,v 1.7 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "SparseMatrix"
require "Array"

-- Sparse matrix implemented as a vector of non-zero entries.
SparseMatrixAsVector = Class.new("SparseMatrixAsVector", SparseMatrix)

SparseMatrixAsVector.Entry = Class.new("SparseMatrixAsVector.Entry")

-- Constructs an entry with the given row and column indices
-- and data value.
-- @param row Row index.
-- @param column Column index.
-- @param datum A value.
function SparseMatrixAsVector.Entry.methods:initialize(row, column, datum)
    SparseMatrixAsVector.Entry.super(self)
    self.row = row
    self.column = column
    self.datum = datum
end

-- The row index.
SparseMatrixAsVector.Entry:attr_accessor("row")

-- The column index.
SparseMatrixAsVector.Entry:attr_accessor("column")

-- The value.
SparseMatrixAsVector.Entry:attr_accessor("datum")

-- Constructs a sparse matrix with the given number of
-- rows, columns, and non-zero elements.
-- @param dimensions  The dimensions.
-- @param numberOfElements The number of non-zero elements.
function SparseMatrixAsVector.methods:initialize(dimensions, numberOfElements)
    SparseMatrixAsVector.super(self, dimensions[1], dimensions[2])
    self.numberOfElements = numberOfElements
    self.array = Array.new(numberOfElements)
    for i = 0, self.numberOfElements - 1 do
	self.array[i] = SparseMatrixAsVector.Entry.new(0, 0, 0)
    end
end

-- The array of non-zero elements.
SparseMatrixAsVector:attr_accessor("array")

-- The number of non-zero elements.
SparseMatrixAsVector:attr_accessor("numberOfElements")

-- Returns the position in the vector of the entry with the given indices.
-- @param i Row index.
-- @param j Column index.
function SparseMatrixAsVector.methods:findPosition(i, j)
    local target = i * self.numberOfColumns + j
    local left = 0
    local right = self.numberOfElements - 1
    while left <= right do
	local middle = math.floor((left + right) / 2)
	local probe = self.array[middle]:get_row() * self.numberOfColumns
	    + self.array[middle]:get_column()
	if target > probe then
	    left = middle + 1
	elseif target < probe then
	    right = middle - 1
	else
	    return middle
	end
    end
    return -1
end

-- Returns the matrix entry at the given indices.
-- @param indices The indices.
function SparseMatrixAsVector.methods:getitem(indices)
    local i = indices[1]
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    local j = indices[2]
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    local position = self:findPosition(i, j)
    if position >= 0 then
	return self.array[position]:get_datum()
    else
	return 0
    end
end

-- Sets the matrix entry at the given indices to the given (non-zero) value.
-- @param indices The indices.
-- @param value A value.
function SparseMatrixAsVector.methods:setitem(indices, value)
    local i = indices[1]
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    local j = indices[2]
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    local position = self:findPosition(i, j)
    if position >= 0 then
	self.array[position].datum = value
    else
	if self.array:get_length() == self.numberOfElements then
	    local newArray = Array.new(2 * self.array:get_length())
	    for p = 0, self.array:get_length() - 1 do
		newArray[p] = self.array[p]
	    end
	    for p = self.array:get_length(), newArray:get_length() - 1 do
		newArray[p] = SparseMatrixAsVector.Entry.new(0, 0, 0)
	    end
	    self.array = newArray
	end
	k = self.numberOfElements
	while k > 0 and (self.array[k - 1]:get_row() > i or
		self.array[k - 1]:get_row() == i and
		self.array[k - 1]:get_column() >= j) do
	    self.array[k] = self.array[k - 1]
	    k = k - 1
	end
	self.array[k] = SparseMatrixAsVector.Entry.new(i, j, value)
	self.numberOfElements = self.numberOfElements + 1
    end
end

-- Sets the matrix entry at the given indices to zero.
-- @param i Row index.
-- @param j Column index.
function SparseMatrixAsVector.methods:putZero(i, j)
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    local position = self:findPosition(i, j)
    if position >= 0 then
	self.numberOfElements = self.numberOfElements - 1
	for k = position, self.numberOfElements - 1 do
	    self.array[k] = self.array[k + 1]
	end
	self.array[k] = SparseMatrixAsVector.Entry.new(i, j, 0)
    end
end

-- Returns the transpose of this sparse matrix.
function SparseMatrixAsVector.methods:transpose()
    local result  = SparseMatrixAsVector.new(
	{self.numberOfColumns, self.numberOfRows}, self.numberOfElements)
    offset = Array.new(self.numberOfColumns)
    for i = 0, self.numberOfColumns - 1 do
	offset[i] = 0
    end
    for i = 0, self.numberOfElements - 1 do
	offset[self.array[i]:get_column()] =
	    offset[self.array[i]:get_column()] + 1
    end
    local sum = 0
    for i = 0, self.numberOfColumns - 1 do
	local tmp = offset[i]
	offset[i] = sum
	sum = sum + tmp
    end
    for i = 0, self.numberOfElements - 1 do
	result.array[offset[self.array[i].column]] =
	    SparseMatrixAsVector.Entry.new(
		self.array[i]:get_column(),
		self.array[i]:get_row(),
		self.array[i]:get_datum())
	offset[self.array[i]:get_column()] =
	    offset[self.array[i]:get_column()] + 1
    end
    result.numberOfElements = self.numberOfElements
    return result
end

-- Multiplication operator.
-- Returns the product of this sparse matrix and the given sparse matrix.
-- @param mat A sparse matrix.
function SparseMatrixAsVector.methods:mul(mat)
    assert(self.numberOfColumns == mat.numberOfRows, "DomainError")
    local matT = mat:transpose()
    local result = SparseMatrixAsVector.new(
	{self.numberOfRows, matT.numberOfRows},
	self.numberOfRows + matT.numberOfRows)
    local iPosition = 0
    while iPosition < self.numberOfElements do
	local i = self.array[iPosition]:get_row()
	local jPosition = 0
	while jPosition < matT.numberOfElements do
	    local j = matT.array[jPosition]:get_row()
	    local sum = 0
	    local k1 = iPosition
	    local k2 = jPosition
	    while k1 < self.numberOfElements
		    and self.array[k1]:get_row() == i
		    and k2 < matT.numberOfElements
		    and matT.array[k2]:get_row() == j do
		if self.array[k1]:get_column()
			< matT.array[k2]:get_column() then
		    k1 = k1 + 1
		elseif self.array[k1]:get_column()
			> matT.array[k2]:get_column() then
		    k2 = k2 + 1
		else
		    sum = sum + self.array[k1]:get_datum()
			    * matT.array[k2]:get_datum()
		    k1 = k1 + 1
		    k2 = k2 + 1
		end
	    end
	    if sum ~= 0 then
		result[{i, j}] = sum
	    end
	    while jPosition < matT.numberOfElements and
		    matT.array[jPosition]:get_row() == j do
		jPosition = jPosition + 1
	    end
	end
	while iPosition < self.numberOfElements and
		self.array[iPosition]:get_row() == i do
	    iPosition = iPosition + 1
	end
    end
    return result
end

-- SparseMatrixAsVector test program.
-- @param arg Command-line arguments.
function SparseMatrixAsVector.main(arg)
    print "SparseMatrixAsVector test program."
    local mat = SparseMatrixAsVector.new({6, 6}, 12)
    --Matrix:TestMatrix(mat)
    Matrix.testTranspose(mat)
    Matrix.testTimes(mat, mat)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SparseMatrixAsVector.main(arg) )
end
