#
# This file contains the Ruby code from Program 6.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_14.txt
#
class QueueAsArray < Queue

    def head
	raise ContainerEmpty if @count == 0
        @array[@head]
    end

    def enqueue(obj)
	raise ContainerFull if @count == @array.length
        @tail = @tail + 1
        if @tail == @array.length
            @tail = 0
	end
        @array[@tail] = obj
        @count += 1
    end

    def dequeue
	raise ContainerEmpty if @count == 0
        result = @array[@head]
        @array[@head] = nil
        @head = @head + 1
        if @head == @array.length
            @head = 0
	end
        @count -= 1
        result
    end

end
