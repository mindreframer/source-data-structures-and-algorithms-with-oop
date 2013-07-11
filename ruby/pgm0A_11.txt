#
# This file contains the Ruby code from Program A.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_11.txt
#
class Circle < GraphicalObject

    def initialize(center, radius)
        super(center)
        @radius = radius
    end

    def draw
        # ...
    end

end
