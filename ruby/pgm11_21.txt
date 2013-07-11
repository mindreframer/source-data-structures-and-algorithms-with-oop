#
# This file contains the Ruby code from Program 11.21 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_21.txt
#
class Simulation

    class Event < Association

	ARRIVAL = 1
	DEPARTURE = 2

        def initialize(category, time)
	    super(time, category)
	end
        
	alias_method :time, :key

	alias_method :category, :value

    end

end
