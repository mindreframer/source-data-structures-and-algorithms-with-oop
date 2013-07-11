#
# This file contains the Ruby code from Program A.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_09.txt
#
class GraphicalObject < AbstractObject

    def initialize(center)
	super()
        @center = center
    end

    abstractmethod :draw

    def erase
        setPenColor(BACKGROUND_COLOR)
        draw
        setPenColor(FOREGROUND_COLOR)
    end

    def moveTo(p)
        erase
        @center = p
        draw
    end

end
