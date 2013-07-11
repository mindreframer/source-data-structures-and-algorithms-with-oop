#
# This file contains the Ruby code from Program 7.27 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_27.txt
#
class SortedListAsArray < OrderedListAsArray

    def find(obj)
        offset = findOffset(obj)
        if offset >= 0
            return @array[offset]
        else
            return nil
	end
    end

    class Cursor < OrderedListAsArray::Cursor

        def initialize(list, offset)
	    super
	end

	undef_method :insertAfter

	undef_method :insertBefore

    end

    def findPosition(obj)
        Cursor(self, findOffset(obj))
    end

end
