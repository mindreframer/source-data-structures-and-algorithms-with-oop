#
# This file contains the Ruby code from Program 16.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_13.txt
#
module DigraphMethods

    def stronglyConnected?
        for v in 0 ... numberOfVertices
	    count = 0
            depthFirstTraversal(0) do |obj, mode|
		count += 1 if mode == Graph::PREVISIT
	    end
	    return false if count != numberOfVertices
	end
        return true
    end

end
