#
# This file contains the Ruby code from Program 8.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_17.txt
#
class OpenScatterTable < HashTable

    def c(i)
        i
    end

    def findUnoccupied(obj)
        hash = h(obj)
        for i in 0 .. @count
            probe = (hash + c(i)) % length
	    return probe if @array[probe].state != OCCUPIED
	end
        raise ContainerFull
    end

    def insert(obj)
	raise ContainerFull if @count == length
        offset = findUnoccupied(obj)
        @array[offset] = Entry.new(OCCUPIED, obj)
        @count += 1
    end

end
