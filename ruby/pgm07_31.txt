#
# This file contains the Ruby code from Program 7.31 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_31.txt
#
class Polynomial < Container

    class Term < AbstractObject

        def clone
            Term.new(@coefficient, @exponent)
	end

        def +(term)
	    assert { @exponent == term.exponent }
            return Term.new( \
		@coefficient + term.coefficient, @exponent)
	end

    end

end
