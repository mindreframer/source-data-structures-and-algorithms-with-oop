#
# This file contains the Ruby code from Program 15.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_05.txt
#
class QuickSorter < Sorter

    def initialize
	super
    end

    abstractmethod :selectPivot
end
