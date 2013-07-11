#
# This file contains the Ruby code from Program 16.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_12.txt
#
class Graph < Container

    def connected?
	count = 0
	depthFirstTraversal(0) do |v, mode|
	    count += 1 if mode == PREVISIT
	end
        count == numberOfVertices
    end

end
