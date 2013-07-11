#
# This file contains the Ruby code from Program 6.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_04.txt
#
class StackAsArray < Stack

    def each
        for i in 0 ... @count
	    yield @array[i]
	end
    end

end
