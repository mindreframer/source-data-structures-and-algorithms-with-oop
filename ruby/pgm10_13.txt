#
# This file contains the Ruby code from Program 10.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_13.txt
#
class MWayTree < SearchTree

    def initialize(m)
	assert { m > 2 }
	super()
        @key = Array.new(m - 1, 1)
        @subtree = Array.new(m)
    end

    def m
	@subtree.length
    end

end
