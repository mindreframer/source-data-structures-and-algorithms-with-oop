#
# This file contains the Ruby code from Program 7.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_09.txt
#
class OrderedListAsArray < OrderedList

    class Cursor < Cursor

        def insertAfter(obj)
	    raise IndexError if \
		not (0 ... @list.count) === @offset
	    raise ContainerFull if \
		@list.count == @list.array.length
            insertPosition = @offset + 1
            i = @list.count
            while i > insertPosition
                @list.array[i] = @list.array[i - 1]
                i -= 1
	    end
            @list.array[insertPosition] = obj
            @list.count += 1
	end

    end

end
