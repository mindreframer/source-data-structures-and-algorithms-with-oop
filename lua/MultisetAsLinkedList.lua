#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: MultisetAsLinkedList.lua,v $
    $Revision: 1.2 $

    $Id: MultisetAsLinkedList.lua,v 1.2 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Multiset"
require "LinkedList"

--{
-- Multiset implemented using a linked list of elements.
MultisetAsLinkedList =
    Class.new("MultisetAsLinkedList", Multiset)

-- Constructs a multiset with the given universe size.
-- @param  n The size of the universal set.
function MultisetAsLinkedList.methods:initialize(n)
    MultisetAsLinkedList.super(self, n)
    self.list = LinkedList.new()
end

-- The linked list.
MultisetAsLinkedList:attr_accessor("list")
--}>a

--{
-- Multiset union operator.
-- Returns the union of this multiset and the given multiset.
-- @param set The multiset to add to this multiset.
function MultisetAsLinkedList.methods:add(set)
    assert(set:is_a(MultisetAsLinkedList))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsLinkedList.new(self.universeSize)
    local p = self.list:get_head()
    local q = set.list:get_head()
    while p and q do
	if p:get_datum() <= q:get_datum() then
	    result.list:append(p:get_datum())
	    p = p:get_succ()
	else
	    result.list:append(q:get_datum())
	    q = q:get_succ()
	end
    end
    while p do
	result.list:append(p:get_datum())
	p = p:get_succ()
    end
    while q do
	result.list:append(q:get_datum())
	q = q:get_succ()
    end
    return result
end
--}>b

--{
-- Multiset intersection operator.
-- Returns the intersection
-- of this multiset and the given multiset.
-- @param set The multiset to intersect with this multiset.
function MultisetAsLinkedList.methods:mul(set)
    assert(set:is_a(MultisetAsLinkedList))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsLinkedList.new(self.universeSize)
    local p = self.list:get_head()
    local q = set.list:get_head()
    while p and q do
	local diff = p:get_datum() - q:get_datum()
	if diff == 0 then
	    result.list:append(p:get_datum())
	end
	if diff <= 0 then
	    p = p:get_succ()
	end
	if diff >= 0 then
	    q = q:get_succ()
	end
    end
    return result
end
--}>c

-- Inserts the given item into this multiset.
-- @param item An integer.
function MultisetAsLinkedList.methods:insert(item)
    local ptr = self.list:get_head()
    local prevPtr = nil
    while ptr do
	if ptr:get_datum() >= item then
	    break
	end
	prevPtr = ptr
	ptr = ptr:get_succ()
    end
    if prevPtr == nil then
	self.list:prepend(item)
    else
	prevPtr:insertAfter(item)
    end
end

-- Withdraws the given item from this multiset.
-- @param item An integer.
function MultisetAsLinkedList.methods:withdraw(item)
    local ptr = self.list:get_head()
    while ptr do
	if ptr:get_datum() == item then
	    list:extract(ptr)
	    return
	end
	ptr = ptr:get_succ()
    end
end

-- True if the given item is in this multiset.
-- @param item An integer.
function MultisetAsLinkedList.methods:contains(item)
    local ptr = self.list:get_head()
    while ptr do
	if ptr:get_datum() == item then
	    return true
	end
	ptr = ptr:get_succ()
    end
    return false
end

-- Purges this multiset.
function MultisetAsLinkedList.methods:purge()
    self.list = LinkedList.new()
end

-- The number of items in this multiset.
function MultisetAsLinkedList.methods:get_count()
    local result = 0
    local ptr = self.list:get_head()
    while ptr do
	result = result + 1
	ptr = ptr:get_succ()
    end
    return result
end

-- Calls the given visitor method for each item in this multiset.
-- @param visitor A visitor method.
function MultisetAsLinkedList.methods:each(visitor)
    local ptr = self.list:get_head()
    while ptr do
	visitor(ptr:get_datum())
	ptr = ptr:get_succ()
    end
end

-- Returns an iterator that enumerates
-- the items of this multiset.
function MultisetAsLinkedList.methods:iter()
    local position = self.list:get_head() -- Iterator state.
    return
	function()
	    local result = nil
	    if position then
		result = position:get_datum()
		position = position:get_succ()
	    end
	    return result
	end
end

-- Multiset difference operator.
-- Returns the difference of this multiset
-- and the given multiset.
-- @param set The multiset to subtract from this multiset.
function MultisetAsLinkedList.methods:sub(set)
    assert(set:is_a(MultisetAsLinkedList))
    assert(self.universeSize == set.universeSize)
    local result = MultisetAsLinkedList.new(self.universeSize)
    local p = self.list:get_head()
    local q = set.list:get_head()
    while p and q do
	local diff = p:get_datum() - q:get_datum()
	if diff < 0 then
	    result.list:append(p:get_datum())
	end
	if diff <= 0 then
	    p = p:get_succ()
	end
	if diff >= 0 then
	    q = q:get_succ()
	end
    end
    while p do
	result.list:append(p:get_datum())
	p = p:get_succ()
    end
    return result
end

-- Multiset equality operator.
-- Returns true if this multiset equals the given multiset.
-- @param set The multiset to compare with this multiset.
function MultisetAsLinkedList.methods:eq(set)
    assert(set:is_a(MultisetAsLinkedList))
    assert(self.universeSize == set.universeSize)
    local p = self.list:get_head()
    local q = set.list:get_head()
    while p and q do
	if p:get_datum() ~= q:get_datum() then
	    return false
	end
	p = p:get_succ()
	q = q:get_succ()
    end
    return (p == nil and q == nil)
end

-- Subset operator.
-- Returns true if this multiset
-- is a subset of the given multiset.
-- @param set The multiset to compare with this multiset.
function MultisetAsLinkedList.methods:le(set)
    assert(set:is_a(MultisetAsLinkedList))
    assert(self.universeSize == set.universeSize)
    local p = self_list:get_head()
    local q = set.list:get_head()
    while p and q do
	local diff = p:get_datum() - q:get_datum()
	if diff == 0 then
	    p = p:get_succ()
	    q = q:get_succ()
	elseif diff > 0 then
	    q = q:get_succ()
	else
	    return false
	end
    end
    return p == nil
end

-- MultisetAsLinkedList test program.
-- @param arg Command-line arguments.
function MultisetAsLinkedList.main(arg)
    print "MultisetAsLinkedList test program."
    print(MultisetAsLinkedList)
    Multiset.test(
	MultisetAsLinkedList.new(32),
	MultisetAsLinkedList.new(32),
	MultisetAsLinkedList.new(32))
    return 0
end

if _REQUIREDNAME == nil then
    os.exit( MultisetAsLinkedList.main(arg) )
end
