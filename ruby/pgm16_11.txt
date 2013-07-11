#
# This file contains the Ruby code from Program 16.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_11.txt
#
module DigraphMethods

    def topologicalOrderTraversal
        inDegree = Array.new(numberOfVertices)
        for v in 0 ... numberOfVertices
            inDegree[v] = 0
	end
	edges { |e| inDegree[e.v1.number] += 1 }
        queue = QueueAsLinkedList.new
        for v in 0 ... numberOfVertices
	    queue.enqueue(self[v]) if inDegree[v] == 0
	end
        while not queue.empty?
            v = queue.dequeue
	    yield v
	    v.successors do |to|
                inDegree[to.number] -= 1
		queue.enqueue(to) if inDegree[to.number] == 0
	    end
	end
    end

end
