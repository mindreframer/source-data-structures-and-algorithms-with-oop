#
# This file contains the Ruby code from Program 7.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_15.txt
#
class OrderedListAsLinkedList < OrderedList

    class Cursor

        def initialize(list, element)
	    @list = list
            @element = element
	end

        def datum
            @element.datum
	end

    end

end
