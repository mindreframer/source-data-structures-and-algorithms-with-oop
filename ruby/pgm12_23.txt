#
# This file contains the Ruby code from Program 12.23 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_23.txt
#
class PartitionAsForestV3 < PartitionAsForestV2

    def join(s, t)
	assert { member?(s) and s.parent.nil? and
	    member?(t) and t.parent.nil? and not s.equal?(t) }
        if s.rank > t.rank
            t.parent = s
        else
            s.parent = t
            if s.rank == t.rank
                t.rank += 1
	    end
	end
        @count -= 1
    end

end
