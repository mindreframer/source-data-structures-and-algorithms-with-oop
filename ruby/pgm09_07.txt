#
# This file contains the Ruby code from Program 9.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_07.txt
#
class Tree < Container

    def breadthFirstTraversal
        queue = QueueAsLinkedList.new
	queue.enqueue(self) if not empty?
        while not queue.empty?
            head = queue.dequeue
            yield head.key
            for i in 0 ... head.degree
                child = head.getSubtree(i)
		queue.enqueue(child) if not child.empty?
	    end
	end
    end

    def breadthFirstTraversalAccept(visitor)
	breadthFirstTraversal do |obj|
	    break if visitor.done?
	    visitor.visit(obj)
	end
    end
end
