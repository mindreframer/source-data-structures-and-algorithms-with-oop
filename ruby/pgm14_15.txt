#
# This file contains the Ruby code from Program 14.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_15.txt
#
class UniformRV < RandomVariable

    def initialize(u, v)
        @u = u
        @v = v
    end

    def next
        @u + (@v - @u) * RandomNumberGenerator.instance.next
    end

end
