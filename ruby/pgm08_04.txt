#
# This file contains the Ruby code from Program 8.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_04.txt
#
class Container < AbstractObject

    def hash
	result = 0
	each do |obj|
	    result += obj.hash
	end
	result += type.name.hash
	return result
    end

end
