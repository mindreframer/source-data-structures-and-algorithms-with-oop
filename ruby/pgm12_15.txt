#
# This file contains the Ruby code from Program 12.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_15.txt
#
class MultisetAsLinkedList < Multiset

    def &(set)
	assert { set.is_a?(MultisetAsLinkedList) }
	assert { @universeSize == set.universeSize }
        result = MultisetAsLinkedList.new(@universeSize)
        p = @list.head
        q = set.list.head
        while not p.nil? and not q.nil?
            diff = p.datum - q.datum
	    result.list.append(p.datum) if diff == 0
	    p = p.succ if diff <= 0
	    q = q.succ if diff >= 0
	end
        return result
    end

end
