#
# This file contains the Ruby code from Program 11.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_11.txt
#
class LeftistHeap < BinaryTree

    def dequeueMin
	raise ContainerEmpty if empty?
        result = @key
        oldLeft = @left
        oldRight = @right
        purge
        swapContentsWith(oldLeft)
        merge!(oldRight)
        return result
    end

end
