#
# This file contains the Ruby code from Program 16.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_03.txt
#
class Graph < Container

    class Vertex < Vertex

        def initialize(graph, number, weight = nil)
            super()
            @graph = graph
            @number = number
            @weight = weight
	end

    end

    class Edge < Edge

        def initialize(graph, v0, v1, weight = nil)
            super()
            @graph = graph
            @v0 = v0
            @v1 = v1
            @weight = weight
	end

    end

end
