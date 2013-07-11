#
# This file contains the Ruby code from Program 7.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_11.txt
#
class OrderedListAsLinkedList < OrderedList

    def initialize
	super
        @linkedList = LinkedList.new
    end

    attr_reader :linkedList

    attr_accessor :count

end
