#
# This file contains the Ruby code from Program 3.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm03_02.txt
#
def prefixSums(a, n)
    j = n - 1
    while j >= 0
        sum = 0
        i = 0
        while i <= j
            sum += a[i]
            i += 1
	end
        a[j] = sum
        j -= 1
    end
end
