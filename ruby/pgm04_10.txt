#
# This file contains the Ruby code from Program 4.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_10.txt
#
class LinkedList

    class Element

        def initialize(list, datum, succ)
            @list = list
            @datum = datum
            @succ = succ
	end

	attr_accessor :datum

	attr_accessor :succ

    end

end
