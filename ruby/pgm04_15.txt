#
# This file contains the Ruby code from Program 4.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_15.txt
#
class LinkedList

    def prepend(item)
        tmp = Element.new(self, item, @head)
	@tail = tmp if @head.nil?
        @head = tmp
    end

end
