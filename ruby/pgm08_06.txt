#
# This file contains the Ruby code from Program 8.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_06.txt
#
class HashTable < SearchableContainer

    def initialize
	super
    end

    abstractmethod :length

    def loadFactor
        return count / length
    end

end
