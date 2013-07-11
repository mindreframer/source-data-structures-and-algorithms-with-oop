#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: Matrix.lua,v $
    $Revision: 1.6 $

    $Id: Matrix.lua,v 1.6 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Class"

--{
-- Abstract base class from which all matrix classes are derived.
Matrix = Class.new("Matrix")

-- Constructs a matrix with the given number of rows and columns.
-- @param numberOfRows The number of rows.
-- @param numberOfColumns The number of columns.
function Matrix.methods:initialize(numberOfRows, numberOfColumns)
    assert(numberOfRows >= 0, "DomainError")
    assert(numberOfColumns >= 0, "DomainError")
    Matrix.super(self)
    self.numberOfRows = numberOfRows
    self.numberOfColumns = numberOfColumns
end

-- The number of rows.
Matrix:attr_reader("numberOfRows")

-- The number of columns.
Matrix:attr_reader("numberOfColumns")

-- Addition operator.
-- Returns the sum of this matrix and the given matrix.
-- @param mat A matrix
Matrix:abstract_method("add")

-- Multiplication operator for matrices.
-- Returns the product of this matrix and the given matrix.
-- @param mat A matrix
Matrix:abstract_method("mul")

-- Returns the transpose of this matrix.
Matrix:abstract_method("transpose")
--}>a

-- Returns a string representation of this matrix.
function Matrix.methods:toString()
    local s = ""
    for i = 0, self.numberOfRows - 1 do
	for j = 0, self.numberOfColumns - 1 do
	    s = s .. tostring(self[{i,j}]) .. " "
	end
	s = s .. "\n"
    end
    return s
end

-- Matrix test program
-- @param mat The matrix to test.
function Matrix.test(mat)
    print "Matrix test program."
    local k = 0
    for i = 0, mat.numberOfRows - 1 do
	for j = 0, mat.numberOfColumns - 1 do
	    mat[{i, j}] = k
	    k = k + 1
	end
    end
    print(mat)
    mat = mat + mat
    print(mat)
end

-- Matrix transpose test program.
-- @param mat The matrix to test.
function Matrix.testTranspose(mat)
    print "Matrix transpose test program."
    mat[{0,0}] = 31
    mat[{0,2}] = 41
    mat[{0,3}] = 59
    mat[{1,1}] = 26
    mat[{2,3}] = 53
    mat[{2,4}] = 58
    mat[{4,2}] = 97
    mat[{5,1}] = 93
    mat[{5,5}] = 23
    print(mat)
    mat[{2,4}] = 0
    mat[{5,3}] = 0
    mat = mat:transpose()
    print(mat)
end

-- Matrix times test program.
-- @param mat The matrix to test.
function Matrix.testTimes(mat1, mat2)
    print "Matrix multiply test program."
    mat1[{0, 0}] = 1
    mat1[{0, 1}] = 2
    mat1[{0, 2}] = 3
    mat2[{0, 0}] = 1
    mat2[{1, 0}] = 2
    mat2[{2, 0}] = 3
    print(mat1)
    print(mat2)
    mat1 = mat2 * mat1
    print(mat1)
end
