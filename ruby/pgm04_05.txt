#
# This file contains the Ruby code from Program 4.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_05.txt
#
class MultiDimensionalArray

    def initialize(*dimensions)
        @dimensions = Array.new(dimensions.length)
        @factors = Array.new(dimensions.length)
        product = 1
        i = dimensions.length - 1
        while i >= 0
            @dimensions[i] = dimensions[i]
            @factors[i] = product
            product *= @dimensions[i]
            i -= 1
	end
        @data = Array.new(product)
    end

end
