#
# This file contains the Ruby code from Program 15.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_10.txt
#
class HeapSorter < Sorter

    def initialize
	super
    end


    def percolateDown(i, length)
        while 2 * i <= length
            j = 2 * i
	    j += 1 if j < length and @array[j + 1] > @array[j]
	    break if @array[i] >= @array[j]
            swap(i, j)
            i = j
	end
    end

end
