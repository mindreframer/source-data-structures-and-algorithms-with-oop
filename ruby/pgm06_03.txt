#
# This file contains the Ruby code from Program 6.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_03.txt
#
class StackAsArray < Stack

    def push(obj)
	raise ContainerFull if @count == @array.length
        @array[@count] = obj
        @count += 1
    end

    def pop
	raise ContainerEmpty if @count == 0
        @count -= 1
        result = @array[@count]
        @array[@count] = nil
        return result
    end

    def top
	raise ContainerEmpty if @count == 0
        return @array[@count - 1]
    end

end
