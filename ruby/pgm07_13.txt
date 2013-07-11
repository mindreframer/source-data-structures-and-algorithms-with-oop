#
# This file contains the Ruby code from Program 7.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_13.txt
#
class OrderedListAsLinkedList < OrderedList

    def member?(obj)
        ptr = @linkedList.head
        while not ptr.nil?
	    return true if ptr.datum.equal?(obj)
            ptr = ptr.succ
	end
        false
    end

    def find(arg)
        ptr = @linkedList.head
        while not ptr.nil?
	    return ptr.datum if ptr.datum == arg
            ptr = ptr.succ
	end
	nil
    end

end
