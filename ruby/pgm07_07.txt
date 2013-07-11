#
# This file contains the Ruby code from Program 7.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_07.txt
#
class OrderedListAsArray < OrderedList

    class Cursor

        def initialize(list, offset)
	    super()
	    @list = list
            @offset = offset
	end

        def datum
	    raise IndexError if \
		not (0 ... @list.count) === offset
            @list[@offset]
	end

    end

end
