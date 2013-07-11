#
# This file contains the Ruby code from Program 12.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_05.txt
#
class SetAsArray < Set

    def ==(set)
	assert { set.is_a?(SetAsArray) }
	assert { @universeSize == set.universeSize }
        for i in 0 ... @universeSize
	    return false if @array[i] != set.array[i]
	end
        return true
    end

    def <=(set)
	assert { set.is_a?(SetAsArray) }
	assert { @universeSize == set.universeSize }
        for i in 0 ... @universeSize
	    return false if self_array[i] and not set.array[i]
	end
        return true
    end

end
