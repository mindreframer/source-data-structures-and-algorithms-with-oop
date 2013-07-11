#
# This file contains the Ruby code from Program 4.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_14.txt
#
class LinkedList

    def first
	raise ContainerEmpty if @head.nil?
        @head.datum
    end

    def last
	raise ContainerEmpty if @tail.nil?
        @tail.datum
    end

end
