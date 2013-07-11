#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 16:50:11 $
    $RCSfile: Meta.lua,v $
    $Revision: 1.20 $

    $Id: Meta.lua,v 1.20 2004/12/05 16:50:11 brpreiss Exp $

--]]

-- Meta table for all Objects.
Meta = {}

-- Look up the value for the given key in this object.
-- If the key is a string, search the class hierarchy.
-- Otherwise, call the __setitem meta-method.
-- @param key A key.
function Meta:__index(key)
    if type(key) == "string" then
	--print("LOOKUP", key)
	local result = nil
	local ptr = self.class
	while ptr do
	    --print("LOOKING IN", rawget(ptr,"name"))
	    result = rawget(ptr.methods, key)
	    if result then
		--print("FOUND!")
		break
	    end
	    local mixin = rawget(ptr, "mixin")
	    if mixin then
		result = rawget(mixin.methods, key)
	    end
	    if result then
		--print("FOUND!")
		break
	    end
	    ptr = rawget(ptr, "superclass")
	end
	return result
    else
	return Meta.__getitem(self, key)
    end
end

-- Assign the given value to the given key in this object.
-- If the key is a string, set the key in this object.
-- Otherwise, call __getitem meta-method.
-- @param key The key.
-- @param value The value.
function Meta:__newindex(key, value)
    if type(key) == "string" then
	rawset(self, key, value)
    else
	Meta.__setitem(self, key, value)
    end
end

-- Tests if the value of this object is equal to
-- the value of the given object.
-- @param obj An object.
function Meta:__eq(obj)
    return self:eq(obj)
end

-- Tests if the value of this object is less than
-- the value of the given object.
-- @param obj An object.
function Meta:__lt(obj)
    return self:lt(obj)
end

-- Tests if the value of this object is less than or equal to
-- the value of the given object.
-- @param obj An object.
function Meta:__le(obj)
    return self:le(obj)
end

-- Returns a textual representation of this object.
function Meta:__tostring()
    return self:toString()
end

-- Returns a numeric representation of this object.
function Meta:__tonumber()
    return self:toNumber()
end

-- Returns the value in this object at the given index.
-- @param index An index (or indices).
function Meta:__getitem(index)
    return self:getitem(index)
end

-- Sets the value in this object at the given index to the given value.
-- @param index An index (or indices).
-- @param value A value.
function Meta:__setitem(index, value)
    self:setitem(index, value)
end

-- Returns the hash value of this object.
function Meta:__hash()
    return self:hash()
end

-- Returns the sum of this object and the given object.
-- @param obj An object.
function Meta:__add(obj)
    return self:add(obj)
end

-- Returns the difference of this object and the given object.
-- @param obj An object.
function Meta:__sub(obj)
    return self:sub(obj)
end

-- Returns the product of this object and the given object.
-- @param obj An object.
function Meta:__mul(obj)
    return self:mul(obj)
end

-- Returns the quotient of this object and the given object.
-- @param obj An object.
function Meta:__div(obj)
    return self:div(obj)
end

-- Returns the negation of this object.
function Meta:__unm()
    return self:unm()
end

-- Returns this object raised to the given exponent object.
-- @param obj An Object.
function Meta:__pow(obj)
    return self:pow(obj)
end

-- Returns the concatenation of this object and the given object.
-- @param obj An object
function Meta:__concat(obj)
    return self:concat(obj)
end

-- Box function.
function box(item)
    if item == nil then
	return item
    elseif type(item) == "Object" then
	return item
    elseif type(item) == "number" then
	require "Number"
	return Number.new(item)
    elseif type(item) == "string" then
	require "String"
	return String.new(item)
    elseif type(item) == "table" then
	require "Array"
	return Array.new(item)
    else
	error "TypeError"
    end
end

-- Unbox function.
function unbox(obj)
    assert(type(obj) == "Object", "TypeError")
    require "Number"
    require "String"
    if obj:is_a(Number) then
	return tonumber(obj)
    elseif obj:is_a(String) then
	return tostring(obj)
    else
	error "TypeError"
    end
end

-- Hash function.
function hash(item)
    if type(item) == "Object" then
	return Object.meta.__hash(item)
    else
	return hash(box(item))
    end
end

-- Class function.
function class(item)
    if type(item) == "Object" then
	return item.class:get_name()
    else
	return type(item)
    end
end

-- Compare function.
function cmp(obj1, obj2)
    if type(obj1) == "Object" and type(obj2) == "Object" then
	return obj1:cmp(obj2)
    elseif type(obj1) == "number" and type(obj2) == "number" then
	return obj1 - obj2
    end
end

do
    local original = tonumber

    -- Improved tonumber function.
    function tonumber(item, ...)
	if type(item) == "Object" then
	    return Object.meta.__tonumber(item, unpack(arg))
	elseif type(item) == "userdata" then
	    local mt = getmetatable(item)
	    if mt.__tonumber then
		return mt.__tonumber(item, unpack(arg))
	    else
		return original(item, unpack(arg))
	    end
	else
	    return original(item, unpack(arg))
	end
    end
end

do
    local original = type

    -- Improved type function.
    function type(item)
	local result = original(item)
	if result == "table" and getmetatable(item) == Object.meta then
	    result = "Object"
	end
	return result
    end
end

-- Printf function.
function printf(fmt, ...)
    print(string.format(fmt, unpack(arg)))
end
