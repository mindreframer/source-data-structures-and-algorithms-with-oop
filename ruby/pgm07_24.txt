#
# This file contains the Ruby code from Program 7.24 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_24.txt
#
class SortedListAsArray < OrderedListAsArray

    include SortedListMethods

    def initialize(size = 0)
	super
    end

end
