#
# This file contains the Ruby code from Program 11.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_08.txt
#
class LeftistHeap < BinaryTree

    def merge!(queue)
        if empty?
            swapContentsWith(queue)
        elsif not queue.empty?
	    swapContentsWith(queue) if @key > queue.key
            @right.merge!(queue)
	    swapSubtrees if \
		@left.nullPathLength < @right.nullPathLength
            @nullPathLength = 1 + \
		[@left.nullPathLength, @right.nullPathLength].min
	end
    end
end
