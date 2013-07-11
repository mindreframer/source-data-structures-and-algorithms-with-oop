#
# This file contains the Ruby code from Program A.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_13.txt
#
class Square < Rectangle

    def initialize(center, width)
        super(center, width, width)
    end

end
