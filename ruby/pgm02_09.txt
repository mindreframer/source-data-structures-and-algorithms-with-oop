#
# This file contains the Ruby code from Program 2.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm02_09.txt
#
def geometricSeriesSum(x, n)
    return (power(x, n + 1) - 1) / (x - 1)
end
