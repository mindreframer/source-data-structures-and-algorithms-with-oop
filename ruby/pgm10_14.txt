#
# This file contains the Ruby code from Program 10.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_14.txt
#
class MWayTree < SearchTree

    def depthFirstTraversal(&block)
        if not empty?
	    for i in 1 .. @count
		yield (@key[i], PREVISIT)
	    end
	    @subtree[0].depthFirstTraversal(&block)
            for i in 1 .. @count
		yield (@key[i], INVISIT)
		@subtree[i].depthFirstTraversal(&block)
	    end
	    for i in 1 .. @count
		yield (@key[i], POSTVISIT)
	    end
	end
    end

end
