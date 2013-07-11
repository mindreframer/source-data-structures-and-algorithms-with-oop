#
# This file contains the Ruby code from Program 4.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_01.txt
#
class Array

    alias_method :init, :initialize

    def initialize(size = 0, baseIndex = 0)
	init(size, nil)
	@baseIndex = baseIndex
    end

end
