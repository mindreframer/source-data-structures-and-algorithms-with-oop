#
# This file contains the Ruby code from Program 7.28 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_28.txt
#
class SortedListAsArray < OrderedListAsArray

    def withdraw(obj)
	raise ContainerEmpty if @count == 0
        offset = findOffset(obj)
	raise ArgumentError if offset < 0
        i = offset
        while i < @count
            @array[i] = @array[i + 1]
            i += 1
	end
        @array[i] = nil
        @count -= 1
    end

end
