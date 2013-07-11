#
# This file contains the Ruby code from Program 7.30 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_30.txt
#
class SortedListAsLinkedList < OrderedListAsLinkedList

    def insert(obj)
        prevPtr = nil
        ptr = @linkedList.head
        while not ptr.nil?
	    break if ptr.datum >= obj
            prevPtr = ptr
            ptr = ptr.succ
	end
        if prevPtr.nil?
            @linkedList.prepend(obj)
        else
            prevPtr.insertAfter(obj)
	end
        @count += 1
    end

end
