#
# This file contains the Ruby code from Program 6.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_13.txt
#
class QueueAsArray < Queue

    def initialize(size = 0)
	super()
        @array = Array.new(size)
        @head = 0
        @tail = size - 1
    end

    def purge
        while @count > 0
            @array[@head] = nil
            @head = @head + 1
            if @head == @array.length
                @head = 0
	    end
            @count -= 1
	end
    end

end
