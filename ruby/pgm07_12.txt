#
# This file contains the Ruby code from Program 7.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_12.txt
#
class OrderedListAsLinkedList < OrderedList

    def insert(obj)
        @linkedList.append(obj)
        @count += 1
    end

    def [](offset)
	raise IndexError if not (0 ... @count) === offset
        ptr = @linkedList.head
        i = 0
        while i < offset and not ptr.nil?
            ptr = ptr.succ
            i += 1
	end
        ptr.datum
    end

end
