#
# This file contains the Ruby code from Program 12.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_20.txt
#
class PartitionAsForest < Partition

    def join(s, t)
	assert { member?(s) and s.parent.nil? and
	    member?(t) and t.parent.nil? and not s.equal?(t) }
        t.parent = s
        @count -= 1
    end

end
