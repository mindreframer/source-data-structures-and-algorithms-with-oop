#
# This file contains the Ruby code from Program 11.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_12.txt
#
class BinomialQueue < MergeablePriorityQueue

    class BinomialTree < GeneralTree

        def initialize(key)
	    super
	end

	attr_accessor :key

	attr_accessor :list

	attr_accessor :degree

    end

end
