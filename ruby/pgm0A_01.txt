#
# This file contains the Ruby code from Program A.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_01.txt
#
def one
    x = 1
    puts x
    two(x)
    puts x
end

def two(y)
    puts y
    y = 2
    puts y
end
