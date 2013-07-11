#
# This file contains the Ruby code from Program 8.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_10.txt
#
class ChainedHashTable < HashTable

    def find(obj)
        ptr = @array[h(obj)].head
        while not ptr.nil?
	    return ptr.datum if ptr.datum == obj
            ptr = ptr.succ
	end
        nil
    end

end
