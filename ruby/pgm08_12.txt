#
# This file contains the Ruby code from Program 8.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_12.txt
#
class ChainedScatterTable < HashTable

    def initialize(length)
        super()
        @array = Array.new(length)
        for i in 0 ... length
            @array[i] = Entry.new(nil, NULL)
	end
    end

    def length
        @array.length
    end

    def purge
        for i in 0 ... length
            @array[i] = Entry.new(nil, NULL)
	end
        @count = 0
    end

end
