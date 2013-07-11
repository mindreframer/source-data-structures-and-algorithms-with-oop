#
# This file contains the Ruby code from Program 8.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_03.txt
#
class String

    SHIFT = 6

    MASK = ~0 << (Fixnum::BITS - SHIFT)

    def hash
        result = 0
	each_byte do |c|
            result = ((result & MASK) ^
		(result << SHIFT) ^ c) & Fixnum::MAX
	end
        return result
    end

end
