#
# This file contains the Ruby code from Program 11.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_03.txt
#
class BinaryHeap < PriorityQueue

    def initialize(length = 0)
	super()
        @array = Array.new(length, 1) # Base index is 1.
    end

    def purge
        while @count > 0
            @array[@count] = nil
            @count -= 1
	end
    end

end
