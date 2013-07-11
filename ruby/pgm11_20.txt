#
# This file contains the Ruby code from Program 11.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_20.txt
#
class BinomialQueue < MergeablePriorityQueue

    def dequeueMin
	raise ContainerEmpty if @count == 0
        mt = minTree
        removeTree(mt)
        queue = BinomialQueue.new
        while mt.degree > 0
            child = mt.getSubtree(0)
            mt.detachSubtree(child)
            queue.addTree(child)
	end
        merge!(queue)
        return mt.key
    end

end
