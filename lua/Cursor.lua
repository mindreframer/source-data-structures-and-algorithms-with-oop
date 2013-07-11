#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: Cursor.lua,v $
    $Revision: 1.5 $

    $Id: Cursor.lua,v 1.5 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "Class"

--{
-- Base class from which all cursor classes are derived.
Cursor = Class.new("Cursor", Object)

-- Constructor.
function Cursor.methods:initialize()
    Cursor.super(self)
end

-- The datum at the current position.
Cursor:abstract_method("get_datum")

-- Inserts the given item after the current position.
-- @param obj The object to insert.
Cursor:abstract_method("insertAfter")

-- Inserts the given item before the current position.
-- @param obj The object to insert.
Cursor:abstract_method("insertBefore")

-- Withdraws the item from the current position.
Cursor:abstract_method("withdraw")
--}>a
