#
# This file contains the Ruby code from Program A.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_14.txt
#
class A < Exception
end

def f
    raise A
end

def g
    begin
        f
    rescue A
        # ...
    end
end
