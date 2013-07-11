#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: OpenScatterTableV2.lua,v $
    $Revision: 1.3 $

    $Id: OpenScatterTableV2.lua,v 1.3 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "OpenScatterTable"

--{
-- Open scatter table implemented using an array.
-- This version provides an improved withdraw method.
OpenScatterTableV2 =
    Class.new("OpenScatterTableV2", OpenScatterTable)

-- Constructs an open scatter table with the given size.
-- @param length The length of the array.
function OpenScatterTableV2.methods:initialize(length)
    OpenScatterTableV2.super(self, length)
end

-- Withdraws the given object from this hash table.
-- @param obj The object to withdraw.
function OpenScatterTableV2.methods:withdraw(obj)
    if self.count == 0 then
	error "ContainerEmpty"
    end
    local i = self:findInstance(obj)
    if i < 0 then
	error "ArgumentError"
    end
    while true do
	local j = math.mod(i + 1, self:get_length())
	while self.array[j].state == OpenScatterTable.OCCUPIED do
	    local h = self:h(self.array[j].obj)
	    if ((h <= i and i < j) or
		    (i < j and j < h) or
		    (j < h and h <= i)) then
		break
	    end
	    j = math.mod(j + 1, self:get_length())
	end
	if self.array[j].state == OpenScatterTable.EMPTY then
	    break
	end
	self.array[i] = self.array[j]
	i = j
    end
    self.array[i] = OpenScatterTable.Entry.new(
	OpenScatterTable.EMPTY, nil)
    self.count = self.count - 1
end
--}>a

-- OpenScatterTableV2 test program.
-- @param arg Command-line arguments.
function OpenScatterTableV2.main(arg)
    print "OpenScatterTableV2 test program."
    local hashTable = OpenScatterTableV2.new(57)
    HashTable.test(hashTable)
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( OpenScatterTableV2.main(arg) )
end
