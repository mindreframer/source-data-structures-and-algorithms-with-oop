#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: SparseMatrix.lua,v $
    $Revision: 1.4 $

    $Id: SparseMatrix.lua,v 1.4 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Matrix"

SparseMatrix = Class.new("SparseMatrix", Matrix)

-- Constructs a sparse matrix
-- with the given number of rows and columns.
-- @param numberOfRows The number of rows.
-- @param numberOfColumns The number of columns.
function SparseMatrix.methods:initialize(numberOfRows, numberOfColumns)
    SparseMatrix.super(self, numberOfRows, numberOfColumns)
end
