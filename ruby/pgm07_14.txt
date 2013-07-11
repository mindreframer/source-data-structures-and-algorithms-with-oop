#
# This file contains the Ruby code from Program 7.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_14.txt
#
class OrderedListAsLinkedList < OrderedList

    def withdraw(obj)
	raise ContainerEmpty if @count == 0
        @linkedList.extract(obj)
        @count -= 1
    end

end
