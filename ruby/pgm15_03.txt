#
# This file contains the Ruby code from Program 15.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_03.txt
#
class BinaryInsertionSorter < Sorter

    def initialize
	super
    end

    def doSort
        for i in 1 ... @n
            tmp = @array[i]
            left = 0
            right = i
            while left < right
                middle = (left + right) / 2
                if tmp >= @array[middle]
                    left = middle + 1
                else
                    right = middle
		end
	    end
            j = i
            while j > left
                swap(j - 1, j)
                j -= 1
	    end
	end
    end

end
