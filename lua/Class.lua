#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 20:04:16 $
    $RCSfile: Class.lua,v $
    $Revision: 1.14 $

    $Id: Class.lua,v 1.14 2004/12/05 20:04:16 brpreiss Exp $

--]]
require "Module"

-- Class class.
Class.name = "Class"
Class.class = Class
Class.superclass = Module
Class.mixin = nil
Class.methods = {}

-- Creates a new Class instance with the given name and superclass class.
function Class.new(name, superclass)
    local cls = Object.new(Class)
    cls.name = name
    cls.superclass = superclass or Object
    cls.mixin = nil
    cls.methods = {}

    -- Creates a new instance of the given class.
    function cls.new(...)
	local obj = Object.new(cls)
	obj:initialize(unpack(arg))
	return obj
    end

    function cls:super(...)
	cls.superclass.methods.initialize(self, unpack(arg))
    end

    return cls
end

-- Returns the name of this class.
Class:attr_reader("name")

-- Returns the superclassclass of this class.
Class:attr_reader("superclass")

-- Include the given module into this class.
function Class.methods:include(module)
    local bottom = self
    local top = bottom.superclass
    local proxy = Class.new("Proxy<" .. module.name .. ">", top)
    proxy.mixin = module

    -- Insert proxy
    bottom.superclass = proxy

    -- Proxy constructor.
    function proxy.methods:initialize(...)
	proxy.super(self, unpack(arg))
    end

    -- Replace super method
    function bottom:super(...)
	bottom.superclass.methods.initialize(self, unpack(arg))
    end
end

-- Returns a textual representation of this Class instance.
function Class.methods:toString()
    return self.class.name .. "{name=" .. self.name .. "}"
end

-- Collects the names of all the instance methods of this class.
-- @param methods Table of methods.
function Class.methods:collectMethods(methods)
    Module.methods.collectMethods(self, methods)
    if self.mixin then
	self.mixin:collectMethods(methods)
    end
    if self.superclass then
	self.superclass:collectMethods(methods)
    end
end
