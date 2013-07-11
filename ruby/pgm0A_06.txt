#
# This file contains the Ruby code from Program A.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_06.txt
#
class Complex

    def Complex.main(*argv)
        c = Complex.new(0, 0)
	puts c
	c.real = 1
	c.imag = 2
	puts c
	c.theta = Math::PI/2 
	c.r = 50
	puts c
	c = Complex.new(1, 2)
	d = Complex.new(3, 4)
        puts c, d, c+d, c-d, c*d, c/d
        return 0
    end

end
