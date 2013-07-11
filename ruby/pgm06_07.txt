#
# This file contains the Ruby code from Program 6.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_07.txt
#
class StackAsLinkedList < Stack

    def push(obj)
        @list.prepend(obj)
        @count += 1
    end

    def pop
	raise ContainerEmpty if @count == 0
        result = @list.first
        @list.extract(result)
        @count -= 1
        return result
    end

    def top
	raise ContainerEmpty if @count == 0
        return @list.first
    end

end
