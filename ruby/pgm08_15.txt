#
# This file contains the Ruby code from Program 8.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_15.txt
#
class OpenScatterTable < HashTable

    EMPTY = 0
    OCCUPIED = 1
    DELETED = 2

    class Entry

        def initialize(state, obj)
            @state = state
            @obj = obj
	end

	attr_accessor :state

	attr_accessor :obj

    end

end
