#
# This file contains the Ruby code from Program 10.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_20.txt
#
class BTree < MWayTree

    def insert(obj)
        if empty?
            if @parent.nil?
                attachSubtree(0, BTree.new(m))
                @key[1] = obj
                attachSubtree(1, BTree.new(m))
                @count = 1
            else
                @parent.insertUp(obj, BTree.new(m))
	    end
        else
            index = findIndex(obj)
	    raise ArgumentError if index != 0 and @key == obj
            @subtree[index].insert(obj)
	end
    end

end
