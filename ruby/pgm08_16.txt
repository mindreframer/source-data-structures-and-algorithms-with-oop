#
# This file contains the Ruby code from Program 8.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_16.txt
#
class OpenScatterTable < HashTable

    def initialize(length)
        super()
        @array = Array.new(length)
        for i in 0 ... length
            @array[i] = Entry.new(EMPTY, nil)
	end
    end

    def length
        @array.length
    end

    def purge
        for i in 0 ... length
            @array[i] = Entry.new(EMPTY, nil)
	end
        @count = 0
    end

end
