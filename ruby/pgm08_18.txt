#
# This file contains the Ruby code from Program 8.18 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_18.txt
#
class OpenScatterTable < HashTable

    def findMatch(obj)
        hash = h(obj)
        for i in 0 ... length
            probe = (hash + c(i)) % length
	    break if @array[probe].state == EMPTY
            if @array[probe].state == OCCUPIED and \
                    @array[probe].obj == obj
                return probe
	    end
	end
        return -1
    end

    def find(obj)
        offset = findMatch(obj)
        if offset >= 0
            return @array[offset].obj
        else
            return nil
	end
    end

end
