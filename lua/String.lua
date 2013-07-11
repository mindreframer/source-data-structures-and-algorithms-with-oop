#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 14:47:20 $
    $RCSfile: String.lua,v $
    $Revision: 1.12 $

    $Id: String.lua,v 1.12 2004/12/05 14:47:20 brpreiss Exp $

--]]

require "Class"
require "Integer"

-- Wrapper class for strings.
String = Class.new("String", Object)

-- Constructs an string with the given value.
-- @param value A string value.
function String.methods:initialize(value)
    String.super(self)
    assert(type(value) == "string", "DomainError")
    self.value = value
end

-- The value of this string.
String:attr_reader("value")

-- Compares this string with the given string.
function String.methods:compare(obj)
    if self.value < obj.value then
	return -1
    elseif self.value > obj.value then
	return 1
    else
	return 0
    end
end

-- Returns a string representation of the given string.
function String.methods:toString()
    return self.value
end

-- Returns the concatenation of this string and the given string.
function String.methods:concat(obj)
    return String.new(self.value .. obj.value)
end

--{
-- Provides a hash method for the String class.

-- Used in the hash method.
String.SHIFT = Integer.new(6)

-- Used in the hash method.
String.MASK =
    Integer.new(0):NOT():lshift(Integer.BITS - String.SHIFT)

-- Returns a hash value for the given String.
function String.methods:hash()
    local result = Integer.new(0)
    for i = 1, string.len(self.value) do
	local c = Integer.new(string.byte(self.value, i))
	result = ( result:AND(String.MASK):XOR(
		    result:lshift(String.SHIFT) ) ):XOR(c)
    end
    return tonumber(result)
end
--}>a

-- String hash test program.
function String.testHash()
    print "String hash test program."
    printf("ett=0%o", hash("ett"))
    printf("tva=0%o", hash("tva"))
    printf("tre=0%o", hash("tre"))
    printf("fyra=0%o", hash("fyra"))
    printf("fem=0%o", hash("fem"))
    printf("sex=0%o", hash("sex"))
    printf("sju=0%o", hash("sju"))
    printf("atta=0%o", hash("atta"))
    printf("nio=0%o", hash("nio"))
    printf("tio=0%o", hash("tio"))
    printf("elva=0%o", hash("elva"))
    printf("tolv=0%o", hash("tolv"))
    printf("abcdefghijklmnopqrstuvwxy=0%o",
	    hash("abcdefghijklmnopqrstuvwxyz"))
    printf("ece.uwaterloo.ca=0%o", hash("ece.uwaterloo.ca"))
    printf("cs.uwaterloo.ca=0%o", hash("cs.uwaterloo.ca"))
    printf("un=0%o", hash("un"))
    printf("deux=0%o", hash("deux"))
    printf("trois=0%o", hash("trois"))
    printf("quatre=0%o", hash("quatre"))
    printf("cinq=0%o", hash("cinq"))
    printf("six=0%o", hash("six"))
    printf("sept=0%o", hash("sept"))
    printf("huit=0%o", hash("huit"))
    printf("neuf=0%o", hash("neuf"))
    printf("dix=0%o", hash("dix"))
    printf("onze=0%o", hash("onze"))
    printf("douze=0%o", hash("douze"))
end

-- String test program.
-- @param arg Command-line arguments.
function String.main(arg)
    print "String test program."
    local s1 = box("one")
    local s2 = box("one")
    local s3 = box("two")
    print("s1 = ", s1)
    print("s2 = ", s2)
    print("s3 = ", s3)
    print("s1 < s2", s1 < s2)
    print("s1 == s2", s1 == s2)
    print("s1:is(s2)", s1:is(s2))
    print("s1 > s2", s1 > s2)
    print("s1 .. s2", s1 .. s2)
    print(unbox(s1))
    print(unbox(s2))
    print(unbox(s3))
    String.testHash()
    print(String)
end

if _REQUIREDNAME == nil then
    os.exit( String.main(arg) )
end
