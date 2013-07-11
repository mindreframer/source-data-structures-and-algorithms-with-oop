#
# This file contains the Ruby code from Program 7.25 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_25.txt
#
class SortedListAsArray < OrderedListAsArray

    def insert(obj)
	raise ContainerFull if @count == @array.length
        i = @count
        while i > 0 and @array[i - 1] > obj
            @array[i] = @array[i - 1]
            i -= 1
	end
        @array[i] = obj
        @count += 1
    end

end
