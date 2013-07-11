#
# This file contains the Ruby code from Program 12.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_19.txt
#
class PartitionAsForest < Partition

    def find(item)
        ptr = @array[item]
        while not ptr.parent.nil?
            ptr = ptr.parent
	end
        return ptr
    end

end
