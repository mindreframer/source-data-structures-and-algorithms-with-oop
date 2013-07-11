#
# This file contains the Ruby code from Program 12.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_11.txt
#
class MultisetAsArray < Multiset

    def insert(item)
        @array[item] += 1
    end

    def withdraw(item)
	raise ArgumentEerror if @array[item] == 0
        @array[item] -= 1
    end

    def member?(item)
        @array[item] > 0
    end

end
