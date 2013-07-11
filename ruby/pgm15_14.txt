#
# This file contains the Ruby code from Program 15.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_14.txt
#
class TwoWayMergeSorter < Sorter

    def merge(left, middle, right)
        i = left
        j = left
        k = middle + 1
        while j <= middle and k <= right
            if @array[j] < @array[k]
                @tempArray[i] = @array[j]
                i += 1
                j += 1
            else
                @tempArray[i] = @array[k]
                i += 1
                k += 1
	    end
	end
        while j <= middle
            @tempArray[i] = @array[j]
            i += 1
            j += 1
	end
        for i in left ... k
            @array[i] = @tempArray[i]
	end
    end

end
