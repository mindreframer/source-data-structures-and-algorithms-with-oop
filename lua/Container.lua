#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 02:05:25 $
    $RCSfile: Container.lua,v $
    $Revision: 1.7 $

    $Id: Container.lua,v 1.7 2004/11/25 02:05:25 brpreiss Exp $

--]]

require "Class"

--{
-- Abstract base class from which all container classes are derived.
Container = Class.new("Container", Object)

-- Constructs a container.
function Container.methods:initialize()
    Container.super(self)
    self.count = 0
end

-- Container count attribute reader.
Container:attr_reader("count")

-- Purges this container.
function Container.methods:purge()
    self.count = 0
end

-- True if this container is empty.
function Container.methods:is_empty()
    return self.count == 0
end

-- True if this container is full.
function Container.methods:is_full()
    return false
end
--}>a

--{
-- Returns an iterator that enumerates the element of this container.
function Container.methods:iter()
    local elements = {}
    self:each(
	function(obj)
	    table.insert(elements, obj)
	end
    )
    return elements
end
--}>b

--{
-- Calls the given visitor function for each element of this container.
function Container.methods:each(visitor)
    for obj in self:iter() do
	visitor(obj)
    end
end
--}>c

--{
-- Returns a string representation of this container.
function Container.methods:toString()
    local result = ""
    self:each(
	function(obj)
	    if result ~= "" then
		result = result .. ", "
	    end
	    result = result .. tostring(obj or "(nil)")
	end
    )
    return self.class.name .. "{" .. result .. "}"
end
--}>d

--{
-- Returns a hash value for this container.
function Container.methods:hash()
    local result = 0
    self:each(
	function(obj)
	    result = result + hash(obj)
	end
    )
    return result + hash(self.class.name)
end
--}>e

-- Container test program.
-- @param arg Command-line arguments.
function Container.main(arg)
    print "Container test program."

    local TestContainer = Class.new("TestContainer", Container)

    function TestContainer.methods:initialize()
	TestContainer.super(self)
    end

    function TestContainer.methods:each(visitor)
	visitor(1)
	visitor(2)
	visitor(3)
    end

    local container = TestContainer.new()
    print(container)
    print("hash =", hash(container))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Container.main(arg) )
end
