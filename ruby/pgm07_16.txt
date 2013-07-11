#
# This file contains the Ruby code from Program 7.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_16.txt
#
class OrderedListAsLinkedList < OrderedList

    def findPosition(obj)
        ptr = @linkedList.head
        while not ptr.nil?
	    break if ptr.datum == obj
            ptr = ptr.succ
	end
        Cursor.new(self, ptr)
    end

end
