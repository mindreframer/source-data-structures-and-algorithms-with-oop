#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: HashTable.lua,v $
    $Revision: 1.3 $

    $Id: HashTable.lua,v 1.3 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "SearchableContainer"
require "String"
require "Association"

--{
-- Abstract base class from which all hash table classes are derived.
HashTable = Class.new("HashTable", SearchableContainer)

-- Constructor.
function HashTable.methods:initialize()
    HashTable.super(self)
end

-- The length of this hash table.
HashTable:abstract_method("get_length")

-- The load factor of this hash table.
function HashTable.methods:loadFactor()
    return self:get_count() / self:get_length()
end
--}>a

--{
-- Returns the hash of the given object.
-- @param obj The object to hash.
function HashTable.methods:f(obj)
    return obj:hash()
end

-- Hashes an integer using the division method.
-- @param obj An integer.
function HashTable.methods:g(x)
    return math.mod(math.abs(x), self:get_length())
end

-- Composition of g and f.
-- @param obj The object to hash.
function HashTable.methods:h(obj)
    return self:g(self:f(obj))
end
--}>b

-- HashTable test program.
-- @param hashTable Command-line arguments.
function HashTable.test(hashTable)
    print "HashTable test program."
    print(hashTable)
    hashTable:insert(Association.new("foo", 12))
    hashTable:insert(Association.new("bar", 34))
    hashTable:insert(Association.new("foo", 56))
    print(hashTable)
    local obj = hashTable:find(Association.new("foo"))
    print(obj)
    hashTable:withdraw(obj)
    print(hashTable)
    print "Using each"
    hashTable:each(
	function(obj)
	    print(obj)
	end
    )
    print "Using Iterator"
    for obj in hashTable:iter() do
	print(obj)
    end
    hashTable:purge()
    print(hashTable)
end
