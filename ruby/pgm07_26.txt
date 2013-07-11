#
# This file contains the Ruby code from Program 7.26 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_26.txt
#
class SortedListAsArray < OrderedListAsArray

    def findOffset(obj)
        left = 0
        right = @count - 1
        while left <= right
            middle = (left + right) / 2
            if obj > @array[middle]
                left = middle + 1
            elsif obj < @array[middle]
                right = middle - 1
            else
                return middle
	    end
	end
        return -1
    end

end
