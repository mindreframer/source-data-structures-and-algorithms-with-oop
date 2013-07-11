#
# This file contains the Ruby code from Program 16.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_14.txt
#
module DigraphMethods

    def cyclic?
	count = 0
        topologicalOrderTraversal { |obj| count += 1 }
        count != numberOfVertices
    end

end
