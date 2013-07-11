#
# This file contains the Ruby code from Program 5.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_10.txt
#
class Association < AbstractObject

    def initialize(*args)
	case args.length
	when 1
	    @key = args[0]
	    @value = nil
	when 2
	    @key = args[0]
	    @value = args[1]
	else
	    raise ArgumentError
	end
    end

end
