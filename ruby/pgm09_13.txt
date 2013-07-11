#
# This file contains the Ruby code from Program 9.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_13.txt
#
class NaryTree < Tree

    def empty?
        @key.nil?
    end

    def key
	raise StateError if empty?
        return @key
    end

    def attachKey(obj)
	raise StateError if not empty?
        @key = obj
        @subtree = Array.new(degree)
        for i in 0 ... degree
            @subtree[i] = NaryTree.new(degree)
	end
    end

    def detachKey
	raise StateError if not leaf?
        result = @key
        @key = nil
        @subtree = nil
        return result
    end

end
