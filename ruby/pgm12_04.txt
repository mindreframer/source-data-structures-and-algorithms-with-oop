#
# This file contains the Ruby code from Program 12.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_04.txt
#
class SetAsArray < Set

    def |(set)
	assert { set.is_a?(SetAsArray) }
	assert { @universeSize == set.universeSize }
        result = SetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            result.array[i] = (@array[i] or set.array[i])
	end
        return result
    end

    def &(set)
	assert { set.is_a?(SetAsArray) }
	assert { @universeSize == set.universeSize }
        result = SetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            result.array[i] = (@array[i] and set.array[i])
	end
        return result
    end

    def -(set)
	assert { set.is_a?(SetAsArray) }
	assert { @universeSize == set.universeSize }
        result = SetAsArray.new(@universeSize)
        for i in 0 ... @universeSize
            result.array[i] = (@array[i] and not set.array[i])
	end
        return result
    end

end
