#
# This file contains the Ruby code from Program 9.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_11.txt
#
class GeneralTree < Tree

    attr_reader :key

    def getSubtree(i)
	raise IndexError if not (0 .. degree) === i
        ptr = @list.head
        for j in 0 ... i
            ptr = ptr.succ
	end
        ptr.datum
    end

    def attachSubtree(t)
        @list.append(t)
        @degree += 1
    end

    def detachSubtree(t)
        @list.extract(t)
        @degree -= 1
        return t
    end

end
