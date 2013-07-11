#
# This file contains the Ruby code from Program 12.21 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_21.txt
#
class PartitionAsForestV2 < PartitionAsForest

    def find(item)
        root = @array[item]
        while not root.parent.nil?
            root = root.parent
	end
        ptr = @array[item]
        while not ptr.parent.nil?
            ptr, ptr.parent = ptr.parent, root
	end
        return root
    end

end
