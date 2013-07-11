#
# This file contains the Ruby code from Program 6.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_17.txt
#
module Algorithms

    def Algorithms.breadthFirstTraversal(tree) # :yield: key
        queue = QueueAsLinkedList.new
	queue.enqueue(tree) if not tree.empty?
        while not queue.empty?
            t = queue.dequeue
	    yield t.key
            for i in 0 ... t.degree
                subTree = t.getSubtree(i)
		queue.enqueue(subTree) if not subTree.empty?
	    end
	end
    end

end
