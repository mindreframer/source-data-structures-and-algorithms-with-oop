#
# This file contains the Ruby code from Program 8.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_01.txt
#
class Fixnum

    BITS = 31
    MAX =  1073741823
    MIN = -1073741824

end

class Integer

    def hash
	return self & Fixnum::MAX
    end

end
