#
# This file contains the Ruby code from Program A.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_12.txt
#
class Rectangle < GraphicalObject

    def initialize(center, height, width)
        super(center)
        @height = height
        @width = width
    end

    def draw
        # ...
    end

end
