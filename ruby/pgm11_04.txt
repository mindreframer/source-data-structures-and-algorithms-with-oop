#
# This file contains the Ruby code from Program 11.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_04.txt
#
class BinaryHeap < PriorityQueue

    def enqueue(obj)
	raise ContainerFull if @count == @array.length
        @count += 1
        i = @count
        while i > 1 and @array[i/2] > obj
            @array[i] = @array[i / 2]
            i /= 2
	end
        @array[i] = obj
    end

end
