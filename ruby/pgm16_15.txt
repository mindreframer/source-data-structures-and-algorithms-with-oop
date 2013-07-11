#
# This file contains the Ruby code from Program 16.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_15.txt
#
module Algorithms

    class Entry

        def initialize
            @known = false
            @distance = Fixnum::MAX
            @predecessor = Fixnum::MAX
	end

	attr_accessor :known

	attr_accessor :distance

	attr_accessor :predecessor
    end

end
