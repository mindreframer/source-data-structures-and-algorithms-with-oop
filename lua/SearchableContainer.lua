#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: SearchableContainer.lua,v $
    $Revision: 1.5 $

    $Id: SearchableContainer.lua,v 1.5 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Container"

--{
-- Methods implemented by searchable containers.
SearchableContainerMethods =
    Module.new("SearchableContainerMethods")

-- True if the given object is contained in this container;
-- false otherwise.
-- @param obj An object
SearchableContainerMethods:abstract_method("contains")

-- Inserts the given object into this container.
-- @param obj An object
SearchableContainerMethods:abstract_method("insert")

-- Withdraws the given object from this container.
-- @param obj An object
SearchableContainerMethods:abstract_method("withdraw")

-- Finds an object in this container
-- that equals the given object.
-- @param obj An object
SearchableContainerMethods:abstract_method("find")

-- Abstract base class
-- from which all searchable containers are derived.
SearchableContainer = Class.new("SearchableContainer", Container)

SearchableContainer:include(SearchableContainerMethods)

-- Constructor.
function SearchableContainer.methods:initialize()
    SearchableContainer.super(self)
end
--}>a
