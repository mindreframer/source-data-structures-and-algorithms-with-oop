#
# This file contains the Ruby code from Program 7.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_10.txt
#
class OrderedListAsArray < OrderedList

    class Cursor

        def withdraw
	    raise IndexError if \
		not (0 ... @list.count) === @offset
	    raise ContainerEmpty if @list.count == 0
            i = @offset
            while i < @list.count - 1
                @list.array[i] = @list.array[i + 1]
                i += 1
	    end
            @list.array[i] = nil
            @list.count -= 1
	end

    end

end
