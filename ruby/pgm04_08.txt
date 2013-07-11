#
# This file contains the Ruby code from Program 4.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_08.txt
#
class DenseMatrix < Matrix

    def initialize(rows, cols)
        super
        @array = MultiDimensionalArray.new(rows, cols)
    end

    def [](i, j)
        @array[i,j]
    end

    def []=(i, j, value)
        @array[i,j] = value
    end

end
