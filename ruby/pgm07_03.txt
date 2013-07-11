#
# This file contains the Ruby code from Program 7.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_03.txt
#
class OrderedListAsArray < OrderedList

    def initialize(size = 0)
	super()
        @array = Array.new(size)
    end

    attr_reader :array

    attr_accessor :count

end
