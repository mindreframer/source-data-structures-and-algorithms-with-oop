#
# This file contains the Ruby code from Program 2.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm02_03.txt
#
def factorial(n)
    if n == 0
        return 1
    else
        return n * factorial(n - 1)
    end
end
