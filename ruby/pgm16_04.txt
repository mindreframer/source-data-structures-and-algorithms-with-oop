#
# This file contains the Ruby code from Program 16.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_04.txt
#
class Graph < Container

    def initialize(size)
        @numberOfVertices = 0
        @numberOfEdges = 0
        @vertex = Array.new(size)
        @directed = false
    end

    attr_reader :numberOfVertices

    attr_reader :numberOfEdges

    def size
	@vertex.size
    end

    def [](v)
	@vertex[v]
    end

end
