#
# This file contains the Ruby code from Program A.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_04.txt
#
class Complex

    def r
        Math.sqrt(@real * @real + @imag * @imag)
    end

    def r=(value)
        tmp = theta
        @real = value * Math.cos(tmp)
        @imag = value * Math.sin(tmp)
    end

    def theta
        Math.atan2(@imag, @real)
    end

    def theta=(value)
        tmp = r
        @real = tmp * Math.cos(value)
        @imag = tmp * Math.sin(value)
    end

end
