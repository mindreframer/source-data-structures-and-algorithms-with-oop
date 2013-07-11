#
# This file contains the Ruby code from Program 12.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_16.txt
#
class Partition < Set

    def initialize(n)
	super
    end

    abstractmethod :find

    abstractmethod :join

end
