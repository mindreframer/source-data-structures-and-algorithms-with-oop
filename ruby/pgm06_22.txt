#
# This file contains the Ruby code from Program 6.22 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_22.txt
#
class DequeAsLinkedList < QueueAsLinkedList

    def tail
	raise ContainerEmpty if @count == 0
        @list.last
    end

    alias_method :enqueueTail, :enqueue

    def dequeueTail
	raise ContainerEmpty if @count == 0
        result = @list.last
        @list.extract(result)
        @count -= 1
        result
    end

end
