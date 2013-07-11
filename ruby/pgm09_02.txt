#
# This file contains the Ruby code from Program 9.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_02.txt
#
class Tree < Container

    PREVISIT = -1
    INVISIT = 0
    POSTVISIT = +1

    def depthFirstTraversal(&block)
        if not empty?
	    yield (key, PREVISIT)
            for i in 0 ... degree
		getSubtree(i).depthFirstTraversal(&block)
	    end
	    yield (key, POSTVISIT)
	end
    end

    def depthFirstTraversalAccept(visitor)
	assert { visitor.is_a?(PrePostVisitor) }
	depthFirstTraversal do |obj, mode|
	    break if visitor.done?
	    case mode
	    when PREVISIT
		visitor.preVisit(obj)
	    when INVISIT
		visitor.inVisit(obj)
	    when POSTVISIT
		visitor.postVisit(obj)
	    end
	end
    end

end
