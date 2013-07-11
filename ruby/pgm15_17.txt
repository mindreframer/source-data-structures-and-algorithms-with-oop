#
# This file contains the Ruby code from Program 15.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_17.txt
#
class BucketSorter < Sorter

    def doSort
        for i in 0 ... @m
            @count[i] = 0
	end
        for j in 0 ... @n
            @count[@array[j]] += 1
	end
        j = 0
        for i in 0 ... @m
            while @count[i] > 0
                @array[j] = i
                j += 1
                @count[i] -= 1
	    end
	end
    end

end
