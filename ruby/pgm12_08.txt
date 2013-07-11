#
# This file contains the Ruby code from Program 12.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_08.txt
#
class SetAsBitVector < Set

    def |(set)
	assert { set.is_a?(SetAsBitVector) }
	assert { @universeSize == set.universeSize }
        result = SetAsBitVector.new(@universeSize)
        for i in 0 ... @vector.length
            result.vector[i] = @vector[i] | set.vector[i]
	end
        return result
    end

    def &(set)
	assert { set.is_a?(SetAsBitVector) }
	assert { @universeSize == set.universeSize }
        result = SetAsBitVector.new(@universeSize)
        for i in 0 ... @vector.length
            result.vector[i] = @vector[i] & set.vector[i]
	end
        return result
    end

    def -(set)
	assert { set.is_a?(SetAsBitVector) }
	assert { @universeSize == set.universeSize }
        result = SetAsBitVector.new(@universeSize)
        for i in 0 ... @vector.length
            result.vector[i] = @vector[i] & ~set.vector[i]
	end
        return result
    end

end
