#
# This file contains the Ruby code from Program 15.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_12.txt
#
class HeapSorter < Sorter

    def doSort
	base = @array.baseIndex
	@array.baseIndex = 1
        buildHeap
        i = @n
        while i >= 2
            swap(i, 1)
            percolateDown(1, i - 1)
            i -= 1
	end
	@array.baseIndex = base
    end

end
