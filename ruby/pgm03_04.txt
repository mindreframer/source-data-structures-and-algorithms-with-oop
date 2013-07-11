#
# This file contains the Ruby code from Program 3.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm03_04.txt
#
def fibonacci(n)
    if n == 0 or n == 1
        return n
    else
        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end
