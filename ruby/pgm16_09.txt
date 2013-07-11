#
# This file contains the Ruby code from Program 16.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_09.txt
#
class Graph < Container

    PREVISIT = -1
    POSTVISIT = 1

    def depthFirstTraversal(start, &block)
        visited = Array.new(@numberOfVertices)
        for v in 0 ... @numberOfVertices
            visited[v] = false
	end
        doDepthFirstTraversal(self[start], visited, &block)
    end

    def doDepthFirstTraversal(v, visited, &block)
	yield (v, PREVISIT)
        visited[v.number] = true
	v.successors do |to|
	    doDepthFirstTraversal(to, visited, &block) \
		if not visited[to.number]
	end
	yield (v, POSTVISIT)
    end

end
