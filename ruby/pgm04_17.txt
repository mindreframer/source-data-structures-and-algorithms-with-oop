#
# This file contains the Ruby code from Program 4.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_17.txt
#
class LinkedList

    def clone
        result = LinkedList.new
        ptr = @head
        while not ptr.nil?
            result.append(ptr.datum)
            ptr = ptr.succ
	end
        result
    end

end
