#
# This file contains the Ruby code from Program 11.18 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_18.txt
#
class BinomialQueue < MergeablePriorityQueue

    def fullAdder(a, b, c)
	if a.nil?
	    if b.nil?
		if c.nil?
		    return [nil, nil]
		else
		    return [c, nil]
		end
	    else
		if c.nil?
		    return [b, nil]
		else
		    return [nil, b.add!(c)]
		end
	    end
	else
	    if b.nil?
		if c.nil?
		    return [a, nil]
		else
		    return [nil, a.add!(c)]
		end
	    else
		if c.nil?
		    return [nil, a.add!(b)]
		else
		    return [c, a.add!(b)]
		end
	    end
	end
    end

end
