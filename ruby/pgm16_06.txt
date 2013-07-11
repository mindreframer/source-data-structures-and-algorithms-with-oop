#
# This file contains the Ruby code from Program 16.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_06.txt
#
module DigraphMethods

    abstractmethod :stronglyConnected?
    abstractmethod :topologicalOrderTraversal

end

class Digraph < Graph

    def initialize(size)
	super
        @directed = true
    end

    include DigraphMethods

end
