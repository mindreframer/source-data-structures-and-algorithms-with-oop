#
# This file contains the Ruby code from Program 15.18 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_18.txt
#
class RadixSorter < Sorter

    R = 8

    CAP_R = 1 << R

    P = (32 + R - 1) / R

    def initialize
	super
        @count = Array.new(CAP_R)
        @tempArray = nil
    end

end
