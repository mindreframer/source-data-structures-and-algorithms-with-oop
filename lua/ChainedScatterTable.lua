#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: ChainedScatterTable.lua,v $
    $Revision: 1.5 $

    $Id: ChainedScatterTable.lua,v 1.5 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "HashTable"
require "Array"

--{
-- Chained scatter table implemented using an array.
ChainedScatterTable = Class.new("ChainedScatterTable", HashTable)

-- Used to indicate the end of a chain.
ChainedScatterTable.NULL = -1

-- Represents an entry in a chained scatter table.
ChainedScatterTable.Entry =
			Class.new("ChainedScatterTable.Entry")

-- Constructs an entry in a chained scatter table
-- that contains the given object and successor index.
-- @param obj An object.
-- @param succ Index of the successor.
function ChainedScatterTable.Entry.methods:initialize(obj, succ)
    ChainedScatterTable.Entry.super(self)
    self.obj = obj
    self.succ = succ
end

-- The object.
ChainedScatterTable.Entry:attr_accessor("obj")

-- The successor.
ChainedScatterTable.Entry:attr_accessor("succ")
--}>a

--{
-- Constructs a chained scatter table with the given size.
-- @param length The length of the array.
function ChainedScatterTable.methods:initialize(length)
    ChainedScatterTable.super(self)
    self.array = Array.new(length)
    for i = 0, length - 1 do
	self.array[i] = ChainedScatterTable.Entry.new(
	    nil, ChainedScatterTable.NULL)
    end
end

-- The length of the array.
function ChainedScatterTable.methods:get_length()
    return self.array:get_length()
end

-- Purges this scatter table.
function ChainedScatterTable.methods:purge()
    for i = 0, self:get_length() - 1 do
	self.array[i] = ChainedScatterTable.Entry.new(nil,
	    ChainedScatterTable.NULL)
    end
    self.count = 0
end
--}>b

--{
-- Inserts the given object into this hash table.
-- @param obj An object.
function ChainedScatterTable.methods:insert(obj)
    if self.count == self:get_length() then
	error "ContainerFull"
    end
    local probe = self:h(obj)
    if self.array[probe].obj then
	while self.array[probe].succ ~=
				    ChainedScatterTable.NULL do
	    probe = self.array[probe].succ
	end
	local tail = probe
	probe = math.mod(probe + 1, self:get_length())
	while self.array[probe].obj do
	    probe = math.mod(probe + 1, self:get_length())
	end
	self.array[tail].succ = probe
    end
    self.array[probe] = ChainedScatterTable.Entry.new(obj,
	ChainedScatterTable.NULL)
    self.count = self.count + 1
end

-- Returns the object in this chained hash table
-- that equals the given object.
-- @param obj An object.
function ChainedScatterTable.methods:find(obj)
    local probe = self:h(obj)
    while probe ~= ChainedScatterTable.NULL do
	if self.array[probe].obj == obj then
	    return self.array[probe].obj
	end
	probe = self.array[probe].succ
    end
    return nil
end
--}>c

--{
-- Withdraws the given object from this hash table.
-- @param obj The object to withdraw.
function ChainedScatterTable.methods:withdraw(obj)
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local i = self:h(obj)
    while i ~= ChainedScatterTable.NULL and
				self.array[i].obj:is_not(obj) do
	i = self.array[i].succ
    end
    assert(i ~= ChainedScatterTable.NULL, "ArgumentError")
    while true do
	local j = self.array[i].succ
	while j ~= ChainedScatterTable.NULL do
	    local h = self:h(self.array[j].obj)
	    local contained = false
	    local k = self.array[i].succ
	    while k ~= self.array[j].succ and not contained do
		if k == h then
		    contained = true
		end
		k = self.array[k].succ
	    end
	    if not contained then
		break
	    end
	    j = self.array[j].succ
	end
	if j == ChainedScatterTable.NULL then
	    break
	end
	self.array[i].obj = self.array[j].obj
	i = j
    end
    self.array[i] = ChainedScatterTable.Entry.new(nil,
	ChainedScatterTable.NULL)
    local j = math.mod(i + self:get_length() - 1,
			self:get_length())
    while j ~= i do
	if self.array[j].succ == i then
	    self.array[j].succ = ChainedScatterTable.NULL
	    break
	end
	j = math.mod(j + length - 1, sefl:get_length())
    end
    self.count = self.count - 1
end
--}>d

-- True if this hash table is full.
function ChainedScatterTable.methods:is_full()
    return self.count == self:get_length()
end

-- Calls the given visitor function
-- for each object in this chained scatter table.
-- @param visitor A visitor function.
function ChainedScatterTable.methods:each(visitor)
    for i = 0, self:get_length() - 1 do
	if self.array[i].obj then
	    visitor(self.array[i].obj)
	end
    end
end

-- Returns an iterator that enumerates
-- the objects in a chained scatter table.
function ChainedScatterTable.methods:iter()
    local position = 0 -- Iterator state.
    while position < self.array:get_length() do
	if self.array[position].obj then
	    break
	end
	position = position + 1
    end
    return
	function()
	    local result = nil
	    if position < self.array:get_length() then
		result = self.array[position].obj
		position = position + 1
		while position < self.array:get_length() do
		    if self.array[position].obj then
			break
		    end
		    position = position + 1
		end
	    end
	    return result
	end
end

-- True if the given object is in this hash table.
function ChainedScatterTable.methods:contains(obj)
    probe = self:h(obj)
    while probe ~= ChainedScatterTable.NULL do
	if array[probe].obj:is(obj) then
	    return true
	end
	probe = array[probe].succ
    end
    return false
end

-- ChainedScatterTable test program.
-- @param arg Command-line arguments.
function ChainedScatterTable.main(arg)
    print "ChainedScatterTable test program."
    local hashTable = ChainedScatterTable.new(57)
    HashTable.test(hashTable)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( ChainedScatterTable.main(arg) )
end
