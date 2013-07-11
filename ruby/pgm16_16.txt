#
# This file contains the Ruby code from Program 16.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_16.txt
#
module Algorithms 

    def Algorithms.dijkstrasAlgorithm(g, s)
        n = g.numberOfVertices
        table = Array.new(n)
        for v in 0 ... n
            table[v] = Entry.new
	end
        table[s].distance = 0
        queue = BinaryHeap.new(g.numberOfEdges)
        queue.enqueue(Association.new(0, g[s]))
        while not queue.empty?
            assoc = queue.dequeueMin
            v0 = assoc.value
            if not table[v0.number].known
                table[v0.number].known = true
		v0.emanatingEdges do |e|
                    v1 = e.mateOf(v0)
                    d = table[v0.number].distance + e.weight
                    if table[v1.number].distance > d

                        table[v1.number].distance = d
                        table[v1.number].predecessor = v0.number
                        queue.enqueue(Association.new(d, v1))
		    end
		end
	    end
	end
        result = DigraphAsLists.new(n)
        for v in 0 ... n
            result.addVertex(v, table[v].distance)
	end
        for v in 0 ... n
	    result.addEdge(v, table[v].predecessor) if v != s
	end
        return result
    end

end
