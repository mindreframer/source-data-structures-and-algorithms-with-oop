#
# This file contains the Ruby code from Program 8.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_02.txt
#
class Float

    def hash
	(m, e) = Math.frexp(self)
	mprime = ((m.abs - 0.5) * (1 << 52)).to_i
	return mprime >> 21
    end

end
