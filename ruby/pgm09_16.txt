#
# This file contains the Ruby code from Program 9.16 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_16.txt
#
class BinaryTree < Tree

    def left
	raise StateError if empty?
        @left
    end

    def right
	raise StateError if empty?
        @right
    end

end
