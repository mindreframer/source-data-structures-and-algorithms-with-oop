#
# This file contains the Ruby code from Program 7.29 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_29.txt
#
class SortedListAsLinkedList < OrderedListAsLinkedList

    include SortedListMethods

    def initialize
	super
    end

end
