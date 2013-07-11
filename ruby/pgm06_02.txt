#
# This file contains the Ruby code from Program 6.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_02.txt
#
class StackAsArray < Stack

    def initialize(size = 0)
        super()
        @array = Array.new(size)
    end

    def purge
        while @count > 0
	    @count -= 1
            @array[@count] = nil
	end
    end

end
