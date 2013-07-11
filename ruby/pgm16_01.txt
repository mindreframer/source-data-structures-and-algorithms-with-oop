#
# This file contains the Ruby code from Program 16.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_01.txt
#
class Vertex < AbstractObject

    def initialize
	super
    end

    abstractmethod :number

    abstractmethod :weight

    abstractmethod :incidentEdges

    abstractmethod :emanatingEdges

    abstractmethod :predecessors

    abstractmethod :successors

end
