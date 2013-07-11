#
# This file contains the Ruby code from Program 9.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_10.txt
#
class GeneralTree < Tree

    def initialize(key)
        super()
        @key = key
        @degree = 0
        @list = LinkedList.new
    end

    def purge
        @list.purge
        @degree = 0
    end

end
