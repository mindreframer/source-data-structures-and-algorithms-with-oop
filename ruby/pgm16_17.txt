#
# This file contains the Ruby code from Program 16.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_17.txt
#
module Algorithms

    def Algorithms.floydsAlgorithm(g)
        n = g.numberOfVertices
        distance = DenseMatrix.new(n, n)
        for v in 0 ... n
            for w in 0 ... n
                distance[v, w] = Fixnum::MAX
	    end
	end
	g.edges do |e|
            distance[e.v0.number, e.v1.number] = e.weight
	end
        for i in 0 ... n
            for v in 0 ... n
                for w in 0 ... n
                    if distance[v, i] != Fixnum::MAX and \
                        distance[i, w] != Fixnum::MAX
                        d = distance[v, i] + distance[i, w]
			distance[v, w] = d if distance[v, w] > d
		    end
		end
	    end
	end
        result = DigraphAsMatrix.new(n)
        for v in 0 ... n
            result.addVertex(v)
	end
        for v in 0 ... n
            for w in 0 ... n
                if distance[v, w] != Fixnum::MAX
                    result.addEdge(v, w, distance[v, w])
		end
	    end
	end
        return result
    end

end
