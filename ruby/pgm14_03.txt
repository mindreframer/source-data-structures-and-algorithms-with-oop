#
# This file contains the Ruby code from Program 14.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_03.txt
#
class DepthFirstSolver < Solver

    def initialize
	super
    end

    def search(current)
        if current.complete?
            updateBest(current)
        else
	    current.successors { |succ| search(succ) }
	end
    end

end
