#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: SparseMatrixAsLinkedList.lua,v $
    $Revision: 1.6 $

    $Id: SparseMatrixAsLinkedList.lua,v 1.6 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "SparseMatrix"
require "Array"
require "LinkedList"

-- Sparse matrix implemented using a linked list of matrix entries.
SparseMatrixAsLinkedList = Class.new("SparseMatrixAsLinkedList", SparseMatrix)

SparseMatrixAsLinkedList.Entry = Class.new("SparseMatrixAsLinkedList.Entry")

-- Constructs an entry with the given row and column indices
-- and data value.
-- @param row Row index.
-- @param column Column index.
-- @param datum A value.
function SparseMatrixAsLinkedList.Entry.methods:initialize(row, column, datum)
    SparseMatrixAsLinkedList.Entry.super(self)
    self.row = row
    self.column = column
    self.datum = datum
end

-- The row index.
SparseMatrixAsLinkedList.Entry:attr_accessor("row")

-- The column index.
SparseMatrixAsLinkedList.Entry:attr_accessor("column")

-- The value.
SparseMatrixAsLinkedList.Entry:attr_accessor("datum")


-- Constructs a sparse matrix with the given number of rows and columns.
-- @param arg[1] The dimensions of the matrix.
function SparseMatrixAsLinkedList.methods:initialize(dimensions)
    SparseMatrixAsLinkedList.super(self, dimensions[1], dimensions[2])
    self.lists = Array.new(self.numberOfRows)
    for i = 0, self.numberOfRows - 1 do
	self.lists[i] = LinkedList.new()
    end
end

SparseMatrixAsLinkedList:attr_accessor("lists")

-- Returns the value at the given indices in this sparse matrix.
-- @param indices The indices.
function SparseMatrixAsLinkedList.methods:getitem(indices)
    local i = indices[1]
    local j = indices[2]
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    local ptr = self.lists[i]:get_head()
    while ptr do
	local entry = ptr:get_datum()
	if entry:get_column() == j then
	    return entry:get_datum()
	end
	if entry:get_column() > j then
	    break
	end
	ptr = ptr:get_succ()
    end
    return 0
end

-- Sets the entry at the given indices in this sparse matrix
-- to the given value
-- @param indices The indices.
-- @param value A value.
function SparseMatrixAsLinkedList.methods:setitem(indices, value)
    local i = indices[1]
    local j = indices[2]
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    ptr = self.lists[i]:get_head()
    while ptr do
	local entry = ptr:get_datum()
	if entry:get_column() == j then
	    entry:set_datum(value)
	    return
	elseif entry:get_column() > j then
	    ptr:insertBefore(SparseMatrixAsLinkedList.Entry.new(i, j, value))
	    return
	end
	ptr = ptr:get_succ()
    end
    self.lists[i]:append(SparseMatrixAsLinkedList.Entry.new(i, j, value))
end

-- Sets the entry at the given indices in this sparse matrix to zero.
-- to the given value
-- @param i Row index.
-- @param j Column index.
function SparseMatrixAsLinkedList.methods:putZero(i, j)
    if i < 0 or i >= self.numberOfRows then
	error "IndexError"
    end
    if j < 0 or j >= self.numberOfColumns then
	error "IndexError"
    end
    ptr = lists[i]:get_head()
    while ptr do
	entry = ptr:get_datum()
	if entry:get_column() == j then
	    self.lists[i]:extract(entry)
	    return
	end
	ptr = ptr:get_succ()
    end
end

-- Returns the transpose of this sparse matrix.
function SparseMatrixAsLinkedList.methods:transpose()
    local result = SparseMatrixAsLinkedList.new{
	self.numberOfColumns, self.numberOfRows}
    for i = 0, self.numberOfColumns - 1 do
	ptr = self.lists[i]:get_head()
	while ptr do
	    entry = ptr:get_datum()
	    result.lists[entry:get_column()]:append(
		SparseMatrixAsLinkedList.Entry.new(
		    entry:get_column(), entry:get_row(), entry:get_datum()))
	    ptr = ptr:get_succ()
	end
    end
    return result
end

-- SparseMatrixAsLinkedList test program.
-- @param arg Command-line arguments.
function SparseMatrixAsLinkedList.main(arg)
    print "SparseMatrixAsLinkedList test program."
    local mat = SparseMatrixAsLinkedList.new{6, 6}
    --Matrix.TestMatrix(mat)
    Matrix.testTranspose(mat)
    --Matrix.TestTimes(mat, mat)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( SparseMatrixAsLinkedList.main(arg) )
end
