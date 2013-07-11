#
# This file contains the Ruby code from Program 8.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_07.txt
#
class HashTable < SearchableContainer

    def f(obj)
        obj.hash
    end

    def g(x)
        x.abs % length
    end

    def h(obj)
	g(f(obj))
    end

end
