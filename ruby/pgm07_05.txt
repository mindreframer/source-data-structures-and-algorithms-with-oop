#
# This file contains the Ruby code from Program 7.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_05.txt
#
class OrderedListAsArray < OrderedList

    def member?(obj)
        for i in 0 ... @count
	    return true if @array[i].equal?(obj)
	end
        false
    end

    def find(obj)
        for i in 0 ... @count
	    return @array[i] if @array[i] == obj
	end
        nil
    end

end
