#
# This file contains the Ruby code from Program 4.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_02.txt
#
class Array

    alias_method :getitem, :[]

    alias_method :setitem, :[]=

    protected :getitem, :setitem

    def getOffset(index)
	@baseIndex = 0 if @baseIndex.nil?
	raise IndexError if not \
	    (@baseIndex ... @baseIndex + length) === index
	return index - @baseIndex
    end

    def [](index)
	getitem(getOffset(index))
    end

    def []=(index, value)
	setitem(getOffset(index), value)
    end

end
