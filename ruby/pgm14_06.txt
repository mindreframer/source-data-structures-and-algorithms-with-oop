#
# This file contains the Ruby code from Program 14.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_06.txt
#
def binarySearch(array, target, i, n)
    case n
    when 0
        raise ArgumentError
    when 1
        if array[i] == target
            return i
	else
	    raise ArgumentError
	end
    else
        j = i + n / 2
        if array[j] <= target
            return binarySearch(array, target, j, n - n/2)
        else
            return binarySearch(array, target, i, n/2)
	end
    end
end
