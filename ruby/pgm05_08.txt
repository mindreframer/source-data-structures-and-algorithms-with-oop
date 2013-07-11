#
# This file contains the Ruby code from Program 5.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_08.txt
#
class Container < AbstractObject

    def accept(visitor)
	assert { visitor.is_a?(Visitor) }
	each do |obj|
	    break if visitor.done?
	    visitor.visit(obj)
	end
    end

end
