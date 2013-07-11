#
# This file contains the Ruby code from Program 6.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_19.txt
#
class DequeAsArray < QueueAsArray

    alias_method :queueHead, :head

    include DequeMethods

    def initialize(size = 0)
        super(size)
    end

    alias_method :head, :queueHead

    def enqueueHead(obj)
	raise ContainerFull if @count == @array.length
        if @head == 0
            @head = @array.length - 1
        else
            @head = @head - 1
	end
        @array[@head] = obj
        @count += 1
    end

    alias_method :dequeueHead, :dequeue

end
