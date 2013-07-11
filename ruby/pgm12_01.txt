#
# This file contains the Ruby code from Program 12.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_01.txt
#
class Set < SearchableContainer

    def initialize(universeSize)
	super()
        @universeSize = universeSize
    end

    attr_reader :universeSize

    abstractmethod :|

    abstractmethod :&

    abstractmethod :-

    abstractmethod :==

    abstractmethod :<=

    def find(i)
        member?(i) ? i : nil
    end

end
