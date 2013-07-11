#
# This file contains the Ruby code from Program 10.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_15.txt
#
class MWayTree < SearchTree

    def find(obj)
	return nil if empty?
        i = @count
        while i > 0
            diff = obj <=> @key[i]
	    return @key[i] if diff == 0
	    break if diff > 0
            i = i - 1
	end
        return @subtree[i].find(obj)
    end
end
