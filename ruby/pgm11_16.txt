#
# This file contains the Ruby code from Program 11.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_16.txt
#
class BinomialQueue < MergeablePriorityQueue

    def minTree
        minTree = nil
        ptr = @treeList.head
        while not ptr.nil?
            tree = ptr.datum
            if minTree.nil? or tree.key < minTree.key
                minTree = tree
	    end
            ptr = ptr.succ
	end
        return minTree
    end

    def min
	raise ContainerEmpty if @count == 0
        return minTree.key
    end

end
