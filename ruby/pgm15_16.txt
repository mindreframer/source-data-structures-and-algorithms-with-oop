#
# This file contains the Ruby code from Program 15.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_16.txt
#
class BucketSorter < Sorter

    def initialize(m)
        super()
        @m = m
        @count = Array.new(@m)
    end

end
