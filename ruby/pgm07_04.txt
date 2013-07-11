#
# This file contains the Ruby code from Program 7.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_04.txt
#
class OrderedListAsArray < OrderedList

    def insert(obj)
	raise ContainerFull if @count == @array.length
        @array[@count] = obj
        @count += 1
    end

end
