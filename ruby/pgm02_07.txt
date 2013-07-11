#
# This file contains the Ruby code from Program 2.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm02_07.txt
#
def geometricSeriesSum(x, n)
    sum = 0
    i = 0
    while i <= n
        sum = sum * x + 1
        i += 1
    end
    return sum
end
