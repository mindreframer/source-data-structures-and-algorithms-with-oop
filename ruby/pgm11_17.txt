#
# This file contains the Ruby code from Program 11.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_17.txt
#
class BinomialQueue < MergeablePriorityQueue

    def merge!(queue)
        oldList = @treeList
        @treeList = LinkedList.new
        @count = 0
        p = oldList.head
        q = queue.treeList.head
        carry = nil
        i = 0
        while not p.nil? or not q.nil?  or not carry.nil?
            a = nil
            if not p.nil?
                tree = p.datum
                if tree.degree == i
                    a = tree
                    p = p.succ
		end
	    end
            b = nil
            if not q.nil?
                tree = q.datum
                if tree.degree == i
                    b = tree
                    q = q.succ
		end
	    end
            sum, carry = fullAdder(a, b, carry)
            if not sum.nil?
                addTree(sum)
	    end
            i += 1
	end
    end

end
