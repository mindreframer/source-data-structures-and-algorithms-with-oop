#
# This file contains the Ruby code from Program 12.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_10.txt
#
class MultisetAsArray < Multiset

    def initialize(n)
        super
        @array = Array.new(@universeSize)
        for item in 0 ... @universeSize
            @array[item] = 0
	end
    end

    attr_accessor :array
    public :array
    protected :array=

end
