#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 01:17:12 $
    $RCSfile: Object.lua,v $
    $Revision: 1.18 $

    $Id: Object.lua,v 1.18 2004/11/27 01:17:12 brpreiss Exp $

--]]

require "Meta"

-- Forward declaration of Class
Class =
{
    id = 0
}

-- Object class.
Object =
{
    -- instance attributes
    id = 1,
    name = "Object",
    class = Class,
    superclass = nil,
    mixin = nil,
    -- class attribributes
    meta = Meta,
    methods = {},
    nextId = 2
}
setmetatable(Class, Object.meta)
setmetatable(Object, Object.meta)

-- Creates a new Object instance of the given class.
function Object.new(class)
    local obj = {}
    obj.id = Object.newId()
    obj.class = class
    setmetatable(obj, Object.meta)
    return obj
end

-- Initializes this Object.
function Object.methods:initialize()
end

-- Returns the next Object id.
function Object.newId()
    result = Object.nextId
    Object.nextId = Object.nextId + 1
    return result
end

-- Returns true if self is the given object.
function Object.methods:is(obj)
    return self.id == obj.id
end

-- Returns true if self is not the given object.
function Object.methods:is_not(obj)
    return not self:is(obj)
end

-- Compares self with the given object.
-- Return a number less than zero, equal to zero, or greater than zero
-- depending on whether self is less than, equal to, or greather than
-- the given object (respectively).
function Object.methods:compare(obj)
    error "Object:compare called."
end

-- Compares self with the given object.
-- Return a number less than zero, equal to zero, or greater than zero
-- depending on whether self is less than, equal to, or greather than
-- the given object (respectively).
function Object.methods:cmp(obj)
    if self.class:is(obj.class) then
	return self:compare(obj)
    else
	if self.class.name < obj.class.name then
	    return -1
	elseif self.class.name == obj.class.name then
	    return 0
	else
	    return 1
	end
    end
end

-- Returns true if self is equal to the given object.
-- @param obj An object.
function Object.methods:eq(obj)
    return self:cmp(obj) == 0
end

-- Returns true if self is less than the given object.
-- @param obj An object.
function Object.methods:lt(obj)
    return self:cmp(obj) < 0
end

-- Returns true if self is less than or equal to the given object.
-- @param obj An object.
function Object.methods:le(obj)
    return self:cmp(obj) <= 0
end

-- Returns a string representation of self.
function Object.methods:toString()
    return self.class.name .. "(id=" .. self.id .. ")"
end

-- Returns a number representation of self.
function Object.methods:toNumber()
    error "Object:toNumber called."
end

-- Returns the item in this table at the given numeric index.
function Object.methods:getitem(index)
    error "Object:getitem called."
end

-- Set the item in this table at the given numeric index to the give value.
function Object.methods:setitem(index, value)
    error "Object:setitem called."
end

-- Returns a (shallow) clone of this object.
function Object.methods:clone()
    local obj = {}
    for k,v in pairs(self) do
	obj[k] = v
    end
    obj.id = Object.newId()
    setmetatable(obj, Object.meta)
    return obj
end

-- Returns a hash value for this object.
function Object.methods:hash()
    return obj.id
end

-- Returns the sum of this object and the given object.
-- @param obj An object.
function Object.methods:add(obj)
    error "Object:add called."
end

-- Returns the difference of this object and the given object.
-- @param obj An object.
function Object.methods:sub(obj)
    error "Object:sub called."
end

-- Returns the product of this object and the given object.
-- @param obj An object.
function Object.methods:mul(obj)
    error "Object:mul called."
end

-- Returns the quotient of this object and the given object.
-- @param obj An object.
function Object.methods:div(obj)
    error "Object:div called."
end

-- Returns the negation of this object.
function Object.methods:unm()
    error "Object:unm called."
end

-- Returns this object raised to the given object.
-- @param obj An object.
function Object.methods:pow(obj)
    error "Object:pow called."
end

-- Returns the concatenation of this object and the given object.
-- @param obj An object.
function Object.methods:concat(obj)
    error "Object:concat called."
end

-- Returns true if this object is an instance of the given class.
-- @param cls A class.
function Object.methods:is_a(cls)
    assert(type(cls) == "Object" and class(cls) == "Class", "DomainError")
    return self.class:is(cls)
end

-- Returns true if this object is is an instance of the given class,
-- or an instance of one of the superclassclasses of the given class,
-- or an module include in the given class.
-- @param cls
function Object.methods:is_instanceOf(cls)
    assert( type(cls) == "Object" and
	    (class(cls) == "Class" or class(cls) == "Module"), "DomainError")
    local result = false
    local ptr = self.class
    while not result and ptr do
	if ptr:is(cls) then
	    result = true
	end
	if ptr.mixin then
	    if ptr.mixin:is(cls) then
		result = true
	    end
	end
	ptr = ptr.superclass
    end
    return result
end

-- Object class test program.
-- @param arg Command-line arguments.
function Object.main(arg)
    print "Object test program."
    if not Module then
	require "Module"
	require "Class"
    end
    local status, err = pcall(
	function()
	    local obj = Object.new(Object)
	    print(obj)
	    print(class(obj))
	    print("type = ", type(obj))
	    print("obj:is_a(Object)", obj:is_a(Object))
	    print("obj:is_a(Module)", obj:is_a(Module))
	    print("obj:is_a(Class)", obj:is_a(Class))
	    print("obj:is_instanceOf(Object)", obj:is_instanceOf(Object))
	    print("obj:is_instanceOf(Module)", obj:is_instanceOf(Module))
	    print("obj:is_instanceOf(Class)", obj:is_instanceOf(Class))
	    print("Object:is_a(Object)", Object:is_a(Object))
	    print("Object:is_a(Module)", Object:is_a(Module))
	    print("Object:is_a(Class)", Object:is_a(Class))
	    print("Object:is_instanceOf(Object)", Object:is_instanceOf(Object))
	    print("Object:is_instanceOf(Module)", Object:is_instanceOf(Module))
	    print("Object:is_instanceOf(Class)", Object:is_instanceOf(Class))
	    local test = obj < obj
	end
    )
    if not status then
	print("Caught error:", err)
    end
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Object.main(arg) )
end
