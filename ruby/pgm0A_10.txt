#
# This file contains the Ruby code from Program A.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_10.txt
#
class Point

    def initialize(x, y)
        @x = x
        @y = y
    end

    attr_reader :x

    attr_reader :y

end
