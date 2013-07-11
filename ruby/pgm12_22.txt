#
# This file contains the Ruby code from Program 12.22 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_22.txt
#
class PartitionAsForestV2 < PartitionAsForest

    def join(s, t)
	assert { member?(s) and s.parent.nil? and
	    member?(t) and t.parent.nil? and not s.equal?(t) }
        if s.count > t.count
            t.parent = s
            s.count += t.count
        else
            s.parent = t
            t.count += s.count
	end
        @count -= 1
    end

end
