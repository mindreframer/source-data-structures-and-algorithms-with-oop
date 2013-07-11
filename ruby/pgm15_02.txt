#
# This file contains the Ruby code from Program 15.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_02.txt
#
class StraightInsertionSorter < Sorter

    def initialize
        super
    end

    def doSort
        for i in 1 ... @n
            j = i
            while j > 0 and @array[j - 1] > @array[j]
                swap(j, j - 1)
                j -= 1
	    end
	end
    end

end
