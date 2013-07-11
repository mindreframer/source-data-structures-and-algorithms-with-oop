#
# This file contains the Ruby code from Program 6.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_10.txt
#
class StackAsLinkedList < Stack

    attr_reader :list

    class Iterator < Opus8::Iterator

	def initialize(stack)
	    @position = stack.list.head
	end

	def more?
	    not @position.nil?
	end

	def succ
	    if more?
		result = @position.datum
		@position = @position.succ
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
