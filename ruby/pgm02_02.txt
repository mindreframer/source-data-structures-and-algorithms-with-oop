#
# This file contains the Ruby code from Program 2.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm02_02.txt
#
def horner(a, n, x)
    result = a[n]
    i = n - 1
    while i >= 0
        result = result * x + a[i]
        i -= 1
    end
    return result
end
