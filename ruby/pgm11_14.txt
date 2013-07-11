#
# This file contains the Ruby code from Program 11.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_14.txt
#
class BinomialQueue < MergeablePriorityQueue

    def initialize(*args)
        super()
        @treeList = LinkedList.new
	case args.length
	when 0
	when 1
	    assert { args[0].is_a?(BinomialTree) }
	    @treeList.append(args[0])
	else
	    raise ArgumentError
	end
    end

    attr_reader :treeList

end
