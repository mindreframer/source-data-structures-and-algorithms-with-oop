#
# This file contains the Ruby code from Program 15.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_19.txt
#
class RadixSorter < Sorter

    def doSort
        @tempArray = Array.new(@n)
        for i in 0 ... P
            for j in 0 ... CAP_R
                @count[j] = 0
	    end
            for k in 0 ... @n
                @count[(@array[k] >> (R*i)) & (CAP_R-1)] += 1
                @tempArray[k] = @array[k]
	    end
            pos = 0
            for j in 0 ... CAP_R
                tmp = pos
                pos += @count[j]
                @count[j] = tmp
	    end
            for k in 0 ... @n
                j = (@tempArray[k] >> (R*i)) & (CAP_R-1)
                @array[@count[j]] = @tempArray[k]
                @count[j] += 1
	    end
	end
    end

end
