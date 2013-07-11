#
# This file contains the Ruby code from Program 15.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_15.txt
#
class TwoWayMergeSorter < Sorter

    def doSort
        @tempArray = Array.new(@n)
        mergesort(0, @n - 1)
        @tempArray = nil
    end

    def mergesort(left, right)
        if left < right
            middle = (left + right) / 2
            mergesort(left, middle)
            mergesort(middle + 1, right)
            merge(left, middle, right)
	end
    end

end
