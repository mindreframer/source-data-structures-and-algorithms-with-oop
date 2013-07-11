#
# This file contains the Ruby code from Program 15.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_01.txt
#
class Sorter < AbstractObject

    def initialize
        super
        @array = nil
        @n = 0
    end

    abstractmethod :doSort

    def sort(array)
        assert { array.is_a?(Array) }
        @array = array
        @n = array.length
	doSort if @n > 0
        @array = nil
    end

    def swap(i, j)
        @array[i], @array[j] = @array[j], @array[i]
    end

end
