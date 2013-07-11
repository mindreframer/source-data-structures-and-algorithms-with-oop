#
# This file contains the Ruby code from Program 14.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_04.txt
#
class BreadthFirstSolver < Solver

    def initialize
	super
    end

    def search(initial)
        queue = QueueAsLinkedList.new
        queue.enqueue(initial)
        while not queue.empty?
            current = queue.dequeue
            if current.complete?
                updateBest(current)
            else
		current.successors { |succ| queue.enqueue(succ) }
	    end
	end
    end

end
