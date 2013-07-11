#
# This file contains the Ruby code from Program 16.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_08.txt
#
class GraphAsLists < Graph

    def initialize(size)
        super(size)
        @adjacencyList = Array.new(size)
        for i in 0 ... size
            @adjacencyList[i] = LinkedList.new
	end
    end

end
