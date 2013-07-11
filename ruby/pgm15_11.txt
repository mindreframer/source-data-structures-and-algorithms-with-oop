#
# This file contains the Ruby code from Program 15.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_11.txt
#
class HeapSorter < Sorter

    def buildHeap
        i = @n / 2
        while i > 0
            percolateDown(i, @n)
            i -= 1
	end
    end

end
