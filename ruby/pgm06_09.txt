#
# This file contains the Ruby code from Program 6.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_09.txt
#
class LinkedList

    def each
	ptr = @head
	while not ptr.nil?
	    yield ptr.datum
	    ptr = ptr.succ
	end
    end

end
