#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 22:00:28 $
    $RCSfile: Parent.lua,v $
    $Revision: 1.1 $

    $Id: Parent.lua,v 1.1 2004/12/03 22:00:28 brpreiss Exp $

--]]


--{
require "Person"

-- Represents a parent.
Parent = Class.new("Parent", Person)

-- Constructs a parent with the given name, sex, and children.
-- @param name A name.
-- @param sex A sex.
-- @param children The children of the parent.
function Parent.methods:initialize(name, sex, children)
    Parent.super(self, name, sex)
    self.children = children
end

-- Returns the selected child of this parent.
-- +i+:: An index.
function Parent.methods:child(i)
    return self.children[i]
end

-- Returns a textual representation of this parent.
function Parent.methods:toString()
    -- ...
end
--}>a
--++
