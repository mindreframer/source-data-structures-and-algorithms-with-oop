#
# This file contains the Ruby code from Program 7.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_06.txt
#
class OrderedListAsArray < OrderedList

    def withdraw(obj)
	raise ContainerEmpty if @count == 0
        i = 0
        while i < @count and not @array[i].equal?(obj)
            i += 1
	end
	raise ArgumentError if i == @count
        while i < @count - 1
            @array[i] = @array[i + 1]
            i += 1
	end
        @array[i] = nil
        @count -= 1
    end

end
