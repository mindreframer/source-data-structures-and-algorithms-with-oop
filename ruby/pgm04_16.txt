#
# This file contains the Ruby code from Program 4.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_16.txt
#
class LinkedList

    def append(item)
        tmp = Element.new(self, item, nil)
        if @head.nil?
            @head = tmp
        else
            @tail.succ = tmp
	end
        @tail = tmp
    end

end
