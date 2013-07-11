#
# This file contains the Ruby code from Program 7.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_19.txt
#
class Polynomial < Container

    class Term < AbstractObject

        def initialize(coefficient, exponent)
            @coefficient = coefficient
            @exponent = exponent
	end

	attr_reader :coefficient

	attr_reader :exponent

        def compareTo(term)
	    assert { is_a?(term.type) }
            if @exponent == term.exponent
		return @coefficient <=> term.coefficient
            else
		return @exponent <=> term.exponent
	    end
	end

        def differentiate!
            if @exponent > 0
                @coefficient *= @exponent
                @exponent -= 1
            else
                @coefficient = 0
	    end
	end

    end

end
