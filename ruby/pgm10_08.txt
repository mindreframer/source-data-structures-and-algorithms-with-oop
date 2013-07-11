#
# This file contains the Ruby code from Program 10.8 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_08.txt
#
class AVLTree < BinarySearchTree

    def doLLRotation
	raise StateError if empty?
        tmp = @right
        @right = @left
        @left = @right.left
        @right.left = @right.right
        @right.right = tmp

        tmp = @key
        @key = @right.key
        @right.key = tmp

        @right.adjustHeight
        adjustHeight
    end

end
