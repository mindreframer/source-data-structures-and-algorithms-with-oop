#
# This file contains the Ruby code from Program 15.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_04.txt
#
class BubbleSorter < Sorter

    def initialize
	super
    end

    def doSort
        i = @n
        while i > 1
            for j in 0 ... i - 1
		swap(j, j + 1) if @array[j] > @array[j + 1]
	    end
            i -= 1
	end
    end

end
