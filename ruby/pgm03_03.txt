#
# This file contains the Ruby code from Program 3.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm03_03.txt
#
def fibonacci(n)
    previous = -1
    result = 1
    i = 0
    while i <= n
        sum = result + previous
        previous = result
        result = sum
        i += 1
    end
    return result
end
