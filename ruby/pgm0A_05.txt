#
# This file contains the Ruby code from Program A.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_05.txt
#
class Complex

    def +(c)
        Complex.new(real + c.real, imag + c.imag)
    end

    def -(c)
        Complex.new (real - c.real, imag - c.imag)
    end

    def *(c)
	Complex.new(real * c.real - imag * c.imag,
	    real * c.imag + imag * c.real)
    end

    def /(c)
	denom = (c.real * c.real - c.imag * c.imag).to_f
	Complex.new((real * c.real - imag * c.imag) / denom,
	    (imag * c.real - real * c.imag) / denom)
    end

end
