#
# This file contains the Ruby code from Program 4.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_04.txt
#
class Array

    def length=(value)
	tmp = Array.new(value, nil)
	for i in 0 ... [length, value].min
	    tmp.setitem(i, getitem(i))
	end
	clear
	setitem(value - 1, nil) if value > 0
	for i in 0 ... tmp.length
	    setitem(i, tmp.getitem(i))
	end
    end

end
