#
# This file contains the Ruby code from Program 8.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_19.txt
#
class OpenScatterTable < HashTable

    def withdraw(obj)
	raise ContainerEmpty if @count == 0
        offset = findInstance(obj)
	raise ArgumentError if offset < 0
        @array[offset] = Entry.new(DELETED, nil)
        @count -= 1
    end

end
