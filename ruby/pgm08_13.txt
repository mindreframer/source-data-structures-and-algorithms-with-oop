#
# This file contains the Ruby code from Program 8.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_13.txt
#
class ChainedScatterTable < HashTable

    def insert(obj)
	raise ContainerFull if @count == length
        probe = h(obj)
        if not @array[probe].obj.nil?
            while @array[probe].succ != NULL
                probe = @array[probe].succ
	    end
            tail = probe
            probe = (probe + 1) % length
            while not @array[probe].obj.nil?
                probe = (probe + 1) % length
	    end
            @array[tail].succ = probe
	end
        @array[probe] = Entry.new(obj, NULL)
        @count += 1
    end

    def find(obj)
        probe = h(obj)
        while probe != NULL
	    return @array[probe].obj if @array[probe].obj == obj
            probe = @array[probe].succ
	end
        nil
    end

end
