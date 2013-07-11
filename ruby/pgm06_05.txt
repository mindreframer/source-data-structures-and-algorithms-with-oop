#
# This file contains the Ruby code from Program 6.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_05.txt
#
class StackAsArray < Stack

    attr_reader :array

    class Iterator < Opus8::Iterator

	def initialize(stack)
	    @stack = stack
	    @position = 0
	end

	def more?
	    @position < @stack.count
	end

	def succ
	    if more?
		assert { more? }
		result = @stack.array[@position]
		@position += 1
	    else
		result = nil
	    end
	    return result
	end
    end

    def iter
	Iterator.new(self)
    end

end
