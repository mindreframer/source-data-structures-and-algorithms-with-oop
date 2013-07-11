#
# This file contains the Ruby code from Program 12.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_07.txt
#
class SetAsBitVector < Set

    def insert(item)
        @vector[item / BITS] |= (1 << item % BITS)
    end

    def withdraw(item)
        @vector[item / BITS] &= ~(1 << item % BITS)
    end

    def member?(item)
        (@vector[item / BITS] & (1 << item % BITS)) != 0
    end

end
