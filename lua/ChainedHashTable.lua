#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/25 01:28:16 $
    $RCSfile: ChainedHashTable.lua,v $
    $Revision: 1.2 $

    $Id: ChainedHashTable.lua,v 1.2 2004/11/25 01:28:16 brpreiss Exp $

--]]

require "HashTable"
require "Array"
require "LinkedList"

--{
--++
-- Hash table implemented as an array of linked lists.
ChainedHashTable = Class.new("ChainedHashTable", HashTable)

-- Constructs a chained hash table with the given size.
-- @param size The size of the chained hash table array.
function ChainedHashTable.methods:initialize(size)
    ChainedHashTable.super(self)
    self.array = Array.new(size)
    for i = 0, size - 1 do
	self.array[i] = LinkedList.new()
    end
end

-- The length of the chained hash table array.
function ChainedHashTable.methods:get_length()
    return self.array:get_length()
end

-- Purges this hash table.
function ChainedHashTable.methods:purge()
    for i = 0, self:get_length() - 1 do
	self.array[i]:purge()
    end
    self.count = 0
end
--}>a

--{
-- Inserts the given object into this hash table.
-- @param obj An object.
function ChainedHashTable.methods:insert(obj)
    self.array[self:h(obj)]:append(obj)
    self.count = self.count + 1
end

-- Withdraws the given object from this hash table.
-- @param obj The object to withdraw.
function ChainedHashTable.methods:withdraw(obj)
    self.array[self:h(obj)]:extract(obj)
    self.count = self.count - 1
end
--}>b

--{
-- Returns the object in this hash table that equals the given object.
-- @param obj An object.
function ChainedHashTable.methods:find(obj)
    local ptr = self.array[self:h(obj)]:get_head()
    while ptr do
	if ptr:get_datum() == obj then
	    return ptr:get_datum()
	end
	ptr = ptr:get_succ()
    end
    return nil
end
--}>c

-- True if the given object is in this hash table.
-- @param obj An object.
function ChainedHashTable.methods:contains(obj)
    local ptr = self.array[self:h(obj)]:get_head()
    while not ptr do
	if ptr:get_datum():is(obj) then
	    return true
	end
	ptr = ptr:get_succ()
    end
    return false
end

-- Calls the given visitor function for each object in this chained hash table.
-- @param visitor A visitor function.
function ChainedHashTable.methods:each(visitor)
    for i = 0, self:get_length() - 1 do
	local ptr = self.array[i]:get_head()
	while ptr do
	    visitor(ptr:get_datum())
	    ptr = ptr:get_succ()
	end
    end
end

-- Returns an iterator that enumerates the objectsin this hash table.
function ChainedHashTable.methods:iter()
    local i = 0 -- Iterator state.
    local ptr = nil -- Iterator state.
    while i < self.array:get_length() do
	ptr = self.array[i]:get_head()
	if ptr then
	    break
	end
	i = i + 1
    end
    return
	function()
	    local result = nil
	    if ptr then
		result = ptr:get_datum()
		ptr = ptr:get_succ()
		if not ptr then
		    i = i + 1
		    while i < self.array:get_length() do
			ptr = self.array[i]:get_head()
			if ptr then
			    break
			end
			i = i + 1
		    end
		end
	    end
	    return result
	end
end

-- Chained hash table test program.
-- @param arg Command-line arguments.
function ChainedHashTable.main(arg)
    print "ChainedHashTable test program."
    print(ChainedHashTable)
    hashTable = ChainedHashTable.new(57)
    HashTable.test(hashTable)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( ChainedHashTable.main(arg) )
end
