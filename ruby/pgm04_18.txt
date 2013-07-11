#
# This file contains the Ruby code from Program 4.18 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_18.txt
#
class LinkedList

    def extract(item)
        ptr = @head
        prevPtr = nil
        while not ptr.nil? and not ptr.datum.equal?(item)
            prevPtr = ptr
            ptr = ptr.succ
	end
	raise ArgumentError if ptr.nil?
        if ptr == @head
            @head = ptr.succ
        else
            prevPtr.succ = ptr.succ
	end
        if ptr == @tail
            @tail = prevPtr
	end
    end

end
