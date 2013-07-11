#
# This file contains the Ruby code from Program 9.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_17.txt
#
class BinaryTree < Tree

    def depthFirstTraversal(&block)
        if not empty?
	    yield (key, PREVISIT)
            left.depthFirstTraversal(&block)
	    yield (key, INVISIT)
            right.depthFirstTraversal(&block)
	    yield (key, POSTVISIT)
	end
    end

end
