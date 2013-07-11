#
# This file contains the Ruby code from Program 12.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_14.txt
#
class MultisetAsLinkedList < Multiset

    def |(set)
	assert { set.is_a?(MultisetAsLinkedList) }
	assert { @universeSize == set.universeSize }
        result = MultisetAsLinkedList.new(@universeSize)
        p = @list.head
        q = set.list.head
        while not p.nil? and not q.nil?
            if p.datum <= q.datum
                result.list.append(p.datum)
                p = p.succ
            else
                result.list.append(q.datum)
                q = q.succ
	    end
	end
        while not p.nil?
            result.list.append(p.datum)
            p = p.succ
	end
        while not q.nil?
            result.list.append(q.datum)
            q = q.succ
	end
        return result
    end

end
