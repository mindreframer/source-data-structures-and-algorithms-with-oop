#
# This file contains the Ruby code from Program 7.22 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_22.txt
#
class Polynomial < Container

    def differentiate!
	each { |term| term.differentiate! }
        zeroTerm = find(Term.new(0, 0))
        if not zeroTerm.nil?
            withdraw(zeroTerm)
	end
    end

end
