#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/01 00:43:29 $
    $RCSfile: Demo1.lua,v $
    $Revision: 1.4 $

    $Id: Demo1.lua,v 1.4 2004/12/01 00:43:29 brpreiss Exp $

--]]

require "DenseMatrix"
require "SparseMatrixAsArray"
require "SparseMatrixAsVector"
require "SparseMatrixAsLinkedList"

-- Provides Demonstration program number 1.
Demo1 = Module.new("Demo1")

-- Demonstraction program number 1.
-- @param arg Command-line arguments.
function Demo1.main(arg)
    print "Demostration program number 1."
    DenseMatrix.main(arg)
    SparseMatrixAsArray.main(arg)
    SparseMatrixAsVector.main(arg)
    SparseMatrixAsLinkedList.main(arg)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Demo1.main(arg) )
end
