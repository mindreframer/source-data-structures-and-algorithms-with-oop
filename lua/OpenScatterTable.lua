#!/usr/local/bin/lua
--[[

Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

$Author: brpreiss $
$Date: 2004/12/05 14:47:20 $
$RCSfile: OpenScatterTable.lua,v $
$Revision: 1.4 $

$Id: OpenScatterTable.lua,v 1.4 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "HashTable"
require "Array"

--{
-- Open scatter table implemented using an array.
OpenScatterTable = Class.new("OpenScatterTable", HashTable)

-- Entry state is empty.
OpenScatterTable.EMPTY = 0
-- Entry state is occupied.
OpenScatterTable.OCCUPIED = 1
-- Entry state is deleted.
OpenScatterTable.DELETED = 2

-- An entry in an open scatter table.
OpenScatterTable.Entry = Class.new("OpenScatterTable.Entry")

-- Constructs an entry in an open scatter table
-- with the given state and object.
-- @param state The state of the entry.
-- @param obj An object.
function OpenScatterTable.Entry.methods:initialize(state, obj)
    OpenScatterTable.Entry.super(self)
    self.state = state
    self.obj = obj
end

-- The state of this entry.
OpenScatterTable.Entry:attr_accessor("state")

-- The object.
OpenScatterTable.Entry:attr_accessor("obj")
--}>a

--{
-- Constructs an open scatter table with the given size.
-- @param length The length of the array.
function OpenScatterTable.methods:initialize(length)
    OpenScatterTable.super(self)
    self.array = Array.new(length)
    for i = 0, length - 1 do
	self.array[i] = OpenScatterTable.Entry.new(
	    OpenScatterTable.EMPTY, nil)
    end
end

-- The length of the array.
function OpenScatterTable.methods:get_length()
    return self.array:get_length()
end

-- Purges this hash table.
function OpenScatterTable.methods:purge()
    for i = 0, self:get_length() - 1 do
	self.array[i] = OpenScatterTable.Entry.new(
	    OpenScatterTable.EMPTY, nil)
    end
    self.count = 0
end
--}>b

--{
-- The probing sequence function.
-- @param i The probe number.
function OpenScatterTable.methods:c(i)
    return i
end

-- Returns the index of an unoccupied entry
-- where the given object may be inserted.
-- The state of an unoccupied entry is either EMPTY or DELETED.
-- @param obj The object to be inserted.
function OpenScatterTable.methods:findUnoccupied(obj)
    local hash = self:h(obj)
    for i = 0, self:get_length() - 1 do
	local probe =
		math.mod(hash + self:c(i), self:get_length())
	if self.array[probe].state ~=
				OpenScatterTable.OCCUPIED then
	    return probe
	end
    end
    error "ContainerFull"
end

-- Inserts the given object into this hash table.
-- @param obj An object.
function OpenScatterTable.methods:insert(obj)
    if self.count == self:get_length() then
	error "ContainerFull"
    end
    local offset = self:findUnoccupied(obj)
    self.array[offset] = OpenScatterTable.Entry.new(
	OpenScatterTable.OCCUPIED, obj)
    self.count = self.count + 1
end
--}>c

--{
-- Returns the index of the entry that contain an object
-- that equals the given object.
-- @param obj An object.
function OpenScatterTable.methods:findMatch(obj)
    local hash = self:h(obj)
    for i = 0, self:get_length() do
	probe = math.mod(hash + self:c(i), self:get_length())
	if self.array[probe].state ==
				    OpenScatterTable.EMPTY then
	    break
	end
	if self.array[probe].state ==
			OpenScatterTable.OCCUPIED and
			    self.array[probe].obj == obj then
	    return probe
	end
    end
    return -1
end

-- Returns the object in this hash table
-- that equals the given object.
-- @param obj An object.
function OpenScatterTable.methods:find(obj)
    local offset = self:findMatch(obj)
    if offset >= 0 then
	return self.array[offset].obj
    else
	return nil
    end
end
--}>d

--{
-- Withdraws the given object from this hash table.
-- @param obj The object to withdraw.
function OpenScatterTable.methods:withdraw(obj)
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local offset = self:findInstance(obj)
    if offset < 0 then
	error "ArgumentError"
    end
    self.array[offset] = OpenScatterTable.Entry.new(
	OpenScatterTable.DELETED, nil)
    self.count = self.count - 1
end
--}>e

-- Returns the index of the entry that contains the given object instance.
-- @param obj An object.
function OpenScatterTable.methods:findInstance(obj)
    local hash = self:h(obj)
    for i = 0, self:get_length() do
	local probe =
	    math.mod(hash + self:c(i), self:get_length())
	if self.array[probe].state ==
				    OpenScatterTable.EMPTY then
	    break
	end
	if self.array[probe].state ==
			OpenScatterTable.OCCUPIED and
			    self.array[probe].obj:is(obj) then
	    return probe
	end
    end
    return -1
end

-- True if this hash table is full.
function OpenScatterTable.methods:is_full()
    return self.count == self:get_length()
end

-- Class the given visitor function for each object in this open scatter table.
-- @param visitor A visitor function.
function OpenScatterTable.methods:each(visitor)
    for i = 0, self:get_length() - 1 do
	if self.array[i].state == OpenScatterTable.OCCUPIED then
	    visitor(self.array[i].obj)
	end
    end
end

-- Returns an iterator that enumerates
-- the object contained in an open scatter table.
function OpenScatterTable.methods:iter()
    local position = 0 -- Iterator state.
    while position < self.array:get_length() do
	if self.array[position].state ==
				OpenScatterTable.OCCUPIED then
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
		    if self.array[position].state ==
			    OpenScatterTable.OCCUPIED then
			break
		    end
		    position = position + 1
		end
	    end
	    return result
	end
end

-- True if the given object is in this hash table.
-- @param obj An object.
function OpenScatterTable.methods:contains(obj)
    return self:findInstance(obj) >= 0
end

-- OpenScatterTable test program.
-- @param arg Command-line arguments.
function OpenScatterTable.main(arg)
    print "OpenScatterTable test program."
    local hashTable = OpenScatterTable.new(57)
    print(hashTable)
    HashTable.test(hashTable)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( OpenScatterTable.main(arg) )
end
