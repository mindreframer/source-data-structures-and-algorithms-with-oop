#
# This file contains the Ruby code from Program 6.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_20.txt
#
class DequeAsArray < QueueAsArray

    def tail
	raise ContainerEmpty if @count == 0
        @array[@tail]
    end

    alias_method :enqueueTail, :enqueue

    def dequeueTail
	raise ContainerEmpty if @count == 0
        result = @array[@tail]
        @array[@tail] = nil
        if @tail == 0
            @tail = @array.length - 1
        else
            @tail = @tail - 1
	end
        @count -= 1
        result
    end

end
