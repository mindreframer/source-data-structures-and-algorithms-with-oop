#
# This file contains the Ruby code from Program 8.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_11.txt
#
class ChainedScatterTable < HashTable

    NULL = -1

    class Entry

        def initialize(obj, succ)
            @obj = obj
            @succ = succ
	end

	attr_accessor :obj

	attr_accessor :succ

    end

end
