#
# This file contains the Ruby code from Program 16.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_10.txt
#
class Graph < Container

    def breadthFirstTraversal(start)
        enqueued = Array.new(@numberOfVertices)
        for v in 0 ... @numberOfVertices
            enqueued[v] = false
	end
        queue = QueueAsLinkedList.new
        queue.enqueue(self[start])
        enqueued[start] = true
        while not queue.empty?
            v = queue.dequeue
	    yield v
	    v.successors do |to|
                if not enqueued[to.number]
                    queue.enqueue(to)
                    enqueued[to.number] = true
		end
	    end
	end
    end

end
