#
# This file contains the Ruby code from Program 10.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_16.txt
#
class MWayTree < SearchTree

    def findIndex(obj)
	return 0 if empty? or obj < @key[1]
        left = 1
        right = @count
        while left < right
            middle = (left + right + 1) / 2
            if obj < @key[middle]
                right = middle - 1
            else
                left = middle
	    end
	end
        return left
    end

    def find(obj)
	return nil if empty?
        index = findIndex(obj)
        if index != 0 and @key[index] == obj
            return @key[index]
        else
            return @subtree[index].find(obj)
	end
    end

end
