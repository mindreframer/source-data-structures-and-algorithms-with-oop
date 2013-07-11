#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/11/27 18:20:25 $
    $RCSfile: Multiset.lua,v $
    $Revision: 1.2 $

    $Id: Multiset.lua,v 1.2 2004/11/27 18:20:25 brpreiss Exp $

--]]

require "Set"

--{
-- Base class from which all multiset classes are derived.
Multiset = Class.new("Multiset", Set)

-- Constructs a multiset with the given universal set size.
-- @param universeSize The size of the universal set.
function Multiset.methods:initialize(universeSize)
    Multiset.super(self, universeSize)
end
--}>a

-- Multiset test program.
function Multiset.test(s1, s2, s3)
    print "Multiset test program."
    for i = 0, 3 do
	s1:insert(i)
    end
    for i = 2, 5 do
	s2:insert(i)
    end
    s3:insert(0)
    s3:insert(2)
    print(s1)
    print(s2)
    print(s3)
    print(s1 + s2) -- union
    print(s1 * s3) -- intersection
    print(s1 - s3) -- difference
    print "Using each"
    s3:each(
	function(obj)
	    print(obj)
	end
    )
    print "Using Iterator"
    for obj in s3:iter() do
	print(obj)
    end
end
