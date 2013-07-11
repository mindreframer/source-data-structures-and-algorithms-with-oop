#
# This file contains the Ruby code from Program 2.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm02_08.txt
#
def power(x, n)
    if n == 0
        return 1
    elsif n % 2 == 0 # n is even
        return power(x * x, n / 2)
    else # n is odd
        return x * power(x * x, n / 2)
    end
end
