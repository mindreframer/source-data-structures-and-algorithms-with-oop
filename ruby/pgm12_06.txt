#
# This file contains the Ruby code from Program 12.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_06.txt
#
class SetAsBitVector < Set

    BITS = 8 * 1.size

    def initialize(n)
        super
        @vector = Array.new((n + BITS - 1) / BITS)
        for i in 0 ... @vector.length
            @vector[i] = 0
	end
    end

    attr_accessor :vector
    protected :vector

end
