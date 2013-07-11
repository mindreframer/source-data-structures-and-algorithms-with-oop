#
# This file contains the Ruby code from Program 14.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_07.txt
#
def fibonacci(n)
    if n == 0 or n == 1
        return n
    else
        if n % 2 == 0
            return a * (a + 2 * b)
        else
            return a * a + b * b
	end
    end
end
