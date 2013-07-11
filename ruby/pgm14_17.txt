#
# This file contains the Ruby code from Program 14.17 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_17.txt
#
def pi(trials)
    hits = 0
    for i in 0 ... trials
        x = RandomNumberGenerator.instance.next
        y = RandomNumberGenerator.instance.next
        if x * x + y * y < 1.0
            hits += 1
	end
    end
    return 4.0 * hits / trials
end
