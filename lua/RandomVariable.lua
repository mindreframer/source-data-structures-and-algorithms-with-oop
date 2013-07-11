#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/28 18:26:55 $
    $RCSfile: RandomVariable.lua,v $
    $Revision: 1.1 $

    $Id: RandomVariable.lua,v 1.1 2004/11/28 18:26:55 brpreiss Exp $

--]]

require "Class"

--{
-- Abstract base class from which all random variables are derived.
RandomVariable = Class.new("RandomVariable")

-- Constructor.
function RandomVariable.methods:initialize()
    RandomVariable.super(self)
end

-- Returns the next sample.
RandomVariable:abstract_method("next")
--}>a
