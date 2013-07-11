#
# This file contains the Ruby code from Program 5.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_03.txt
#
class Container < AbstractObject

    include ::Enumerable

    def initialize
	super
        @count = 0
    end

    attr_reader :count

    def purge
	@count = 0
    end

    def empty?
        count == 0
    end

    def full?
        false
    end

end
