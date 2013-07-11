#
# This file contains the Ruby code from Program 15.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm15_08.txt
#
class MedianOfThreeQuickSorter < QuickSorter

    def initialize
	super
    end

    def selectPivot(left, right)
        middle = (left + right) / 2
	swap(left, middle) if @array[left] > @array[middle]
	swap(left, right) if @array[left] > @array[right]
	swap(middle, right) if @array[middle] > @array[right]
        return middle
    end

end
