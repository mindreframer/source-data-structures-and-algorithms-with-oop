#
# This file contains the Ruby code from Program 11.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_07.txt
#
class LeftistHeap < BinaryTree

    include PriorityQueueMethods
    include MergeablePriorityQueueMethods

    def initialize(*args)
	case args.length
	when 0
	    super()
            @nullPathLength = 0
	when 1
            super(args[0], LeftistHeap.new, LeftistHeap.new)
            @nullPathLength = 1
	else
	    raise ArgumentError
	end
    end

    attr_accessor :key

    attr_accessor :left

    attr_accessor :right

    attr_accessor :nullPathLength

end
