#
# This file contains the Ruby code from Program 10.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_09.txt
#
class AVLTree < BinarySearchTree

    def doLRRotation
	raise StateError if empty?
        @left.doRRRotation
        doLLRotation
    end

end
