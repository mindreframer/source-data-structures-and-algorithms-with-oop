#
# This file contains the Ruby code from Program 12.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_03.txt
#
class SetAsArray < Set

    def insert(item)
        @array[item] = true
    end

    def member?(item)
        @array[item]
    end

    def withdraw(item)
        @array[item] = false
    end

end
