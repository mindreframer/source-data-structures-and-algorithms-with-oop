#
# This file contains the Ruby code from Program 12.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_12.txt
#
class MultisetAsArray < Multiset

    def |(set)
	assert { set.is_a?(MultisetAsArray) }
	assert { @universeSize == set.universeSize }
        result = MultisetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            result.array[i] = @array[i] + set.array[i]
	end
        return result
    end

    def &(set)
	assert { set.is_a?(MultisetAsArray) }
	assert { @universeSize == set.universeSize }
        result = MultisetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            result.array[i] = [@array[i], set.array[i]].min
	end
        return result
    end

    def -(set)
	assert { set.is_a?(MultisetAsArray) }
	assert { @universeSize == set.universeSize }
        result = MultisetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            if set.array[i] <= @array[i]
                result.array[i] = @array[i] - set.array[i]
	    end
	end
        return result
    end

end
