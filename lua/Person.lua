#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/03 22:00:28 $
    $RCSfile: Person.lua,v $
    $Revision: 1.1 $

    $Id: Person.lua,v 1.1 2004/12/03 22:00:28 brpreiss Exp $

--]]

--{
require "Class"

-- Represents a person.
Person = Class.new("Person")

-- Female sex.
Person.FEMALE = 0
-- Male sex.
Person.MALE = 1

-- Constructs a person with the given name and sex.
-- @param name A name.
-- @param sex A sex.
function Person.methods:initialize(name, sex)
    self.name = name
    self.sex = sex
end

-- Returns a string representation of this person.
function Person.methods:toString()
    return tostring(self.name)
end
--}>a
