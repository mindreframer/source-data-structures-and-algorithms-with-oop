#
# This file contains the Ruby code from Program 14.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_10.txt
#
def binom(n, m)
    b = [0] * (n + 1)
    b[0] = 1
    for i in 1 ..  n
        b[i] = 1
        j = i - 1
        while j > 0
            b[j] += b[j - 1]
            j -= 1
	end
    end
    return b[m]
end
