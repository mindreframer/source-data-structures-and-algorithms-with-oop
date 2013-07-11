#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/02 01:41:41 $
    $RCSfile: Association.lua,v $
    $Revision: 1.4 $

    $Id: Association.lua,v 1.4 2004/12/02 01:41:41 brpreiss Exp $

--]]

require "Class"

--{
-- Represents a (key, value) pair.
Association = Class.new("Association", Object)

-- Constructor.
-- @param key A key.
-- @param value A value.
function Association.methods:initialize(key, value)
    Association.super(self)
    self.key = box(key)
    self.value = box(value)
end
--}>a

--{
-- The key.
Association:attr_reader("key")

-- The value.
Association:attr_accessor("value")
--}>b

--{
-- Compares this association with the given association.
-- @param +assoc+:: An association.
function Association.methods:compare(assoc)
    assert(assoc:is_instanceOf(Association))
    return self.key:compare(assoc.key)
end

-- Returns a string representation of this association.
function Association.methods:toString()
    return string.format("%s{%s, %s}",
	class(self), tostring(self.key), tostring(self.value))
end
--}>c

--{
-- Returns a hash value for this association.
function Association.methods:hash()
    return self.key:hash()
end
--}>d

-- Association test program.
-- @param arg Command-line arguments.
function Association.main(arg)
    print "Association test program. "
    print(Association)
    local a = Association.new(1,2)
    print(a, a:get_key(), a:get_value())
    print(a:hash())
    print(Association.new(2,2) > Association.new(3,2))
    local b = Association.new(3)
    print(b)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( Association.main(arg) )
end
