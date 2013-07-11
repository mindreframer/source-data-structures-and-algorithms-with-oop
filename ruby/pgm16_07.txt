#
# This file contains the Ruby code from Program 16.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_07.txt
#
class GraphAsMatrix < Graph

    def initialize(size)
        super(size)
        @matrix = DenseMatrix.new(size, size)
    end

end
