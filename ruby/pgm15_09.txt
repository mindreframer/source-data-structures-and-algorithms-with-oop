#
# This file contains the Ruby code from Program 15.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_09.txt
#
class StraightSelectionSorter < Sorter

    def initialize
	super
    end

    def doSort
        i = @n
        while i > 1
            max = 0
            for j in 0 ... i
		max = j if @array[j] > @array[max]
	    end
            swap(i - 1, max)
            i -= 1
	end
    end

end
