#
# This file contains the Ruby code from Program 8.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_20.txt
#
class OpenScatterTableV2 < OpenScatterTable

    def initialize(length = 0)
	super
    end

    def withdraw(obj)
	raise ContainerEmpty if @count == 0
        i = findInstance(obj)
	raise ArgumentError if i < 0
        loop do
            j = (i + 1) % length
            while @array[j].state == OCCUPIED
                h = h(@array[j].obj)
                break if ((h <= i and i < j) \
		    or (i < j and j < h) \
		    or (j < h and h <= i))
                j = (j + 1) % length
	    end
	    break if @array[j].state == EMPTY
            @array[i] = @array[j]
            i = j
	end
        @array[i] = Entry.new(EMPTY, nil)
        @count -= 1
    end

end
