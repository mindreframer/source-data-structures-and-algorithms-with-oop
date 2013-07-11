#
# This file contains the Ruby code from Program 7.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_08.txt
#
class OrderedListAsArray < OrderedList

    def findPosition(obj)
        i = 0
        while i < @count and not @array[i] == obj
            i += 1
	end
        Cursor.new(self, i)
    end

    def [](offset)
	raise IndexError if not (0 ... @count) === offset
        @array[offset]
    end

end
