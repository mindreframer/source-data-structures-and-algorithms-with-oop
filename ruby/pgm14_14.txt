#
# This file contains the Ruby code from Program 14.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_14.txt
#
class SimpleRV < RandomVariable

    def next
        RandomNumberGenerator.instance.next
    end

end
