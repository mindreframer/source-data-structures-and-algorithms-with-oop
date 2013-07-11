#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 22:16:19 $
    $RCSfile: Module.lua,v $
    $Revision: 1.11 $

    $Id: Module.lua,v 1.11 2004/12/05 22:16:19 brpreiss Exp $

--]]

require "Object"

-- Module class
Module = Object.new(Class)
Module.name = "Module"
Module.superclass = Object
Module.mixin = nil
Module.methods = {}

-- Creates a new Module instance with the given name and superclass module.
function Module.new(name, superclass)
    local mod = Object.new(Module)
    mod.name = name
    mod.superclass = superclass or Object
    mod.mixin = nil
    mod.methods = {}
    return mod
end

-- Defines an attribute reader called get_<name>.
function Module.methods:attr_reader(name)
    self.methods["get_" .. name] = function(obj) return obj[name] end
end

-- Defines an attribute writer called set_<name>.
function Module.methods:attr_writer(name)
    self.methods["set_" .. name] = function(obj, value) obj[name] = value end
end

-- Defines an attribute reader called get_<name>
-- and an attribute writer called set_<name>
function Module.methods:attr_accessor(name)
    self:attr_reader(name)
    self:attr_writer(name)
end

-- Defines an abstract method with the given name.
function Module.methods:abstract_method(name)
    self.methods[name] = function()
	error("Abstract method " .. name .. " called.")
    end
end

-- Undefines the method with the given name.
function Module.methods:undef_method(name)
    self.methods[name] = function()
	error("Undefined method " .. name .. " called.")
    end
end

-- Creates an alias for the given method in this module.
-- @param alias The alias.
-- @param method The method.
function Module.methods:alias_method(alias, method)
    -- The following is a hack.
    -- The __index method expects to be called on an instance of self.
    -- Here we use a fake instance.
    self.methods[alias] = Object.meta.__index({class = self}, method)
end

-- Collects the names of all the statics of this module.
-- @param statics Table of statics.
function Module.methods:collectStatics(statics)
    for k,v in pairs(self) do
	if not statics[k] then
	    if type(v) == "function" then
		statics[k] = string.format("%s.%s", self.name, k)
	    elseif type(v) == "Object" then
		if v:is_instanceOf(Module) then
		    statics[k] = v.name
		else
		    statics[k] = string.format("%s instance", class(v))
		end
	    else
		statics[k] = string.format("%s value", type(v))
	    end
	end
    end
end

-- Collects the names of all the instance methods of this module.
-- @param methods Table of methods.
function Module.methods:collectMethods(methods)
    for k,_ in pairs(self.methods) do
	if not methods[k] then
	    methods[k] = string.format("%s.methods.%s", self.name, k)
	end
    end
end

-- Returns a string that lists all the methods of this module
-- and the module in which the method is defined.
-- @param methods Temporary storage.
function Module.methods:dump()
    local statics = {}
    self:collectStatics(statics)
    local methods = {}
    self:collectMethods(methods)

    local result = self.name .. "\n{\n"

    result = result .. "Statics:\n"

    local keys = {}
    for k,_ in pairs(statics) do
	table.insert(keys, k)
    end
    table.sort(keys)
    for _,k in ipairs(keys) do
	result = result ..  string.format("    %-16s-> %s\n", k, statics[k])
    end

    result = result .. "Instance methods:\n"

    keys = {}
    for k,_ in pairs(methods) do
	table.insert(keys, k)
    end
    table.sort(keys)
    for _,k in ipairs(keys) do
	result = result ..  string.format("    %-16s-> %s\n", k, methods[k])
    end

    result = result .. "}"
    return result
end
