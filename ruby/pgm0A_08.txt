#
# This file contains the Ruby code from Program A.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_08.txt
#
class Parent < Person

    def initialize(name, sex, children)
        super(name, sex)
        @children = children
    end

    def child(i)
        @children[i]
    end

    def to_s
        # ...
    end

end
