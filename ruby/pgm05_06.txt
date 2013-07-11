#
# This file contains the Ruby code from Program 5.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_06.txt
#
class Container < AbstractObject

    def to_s
	s = ""
	each do |obj|
	    s << ", " if not s.empty?
	    s << obj.to_s
	end
	type.name + "{" + s + "}"
    end

end
