#
# This file contains the Ruby code from Program 10.6 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_06.txt
#
class AVLTree < BinarySearchTree

    def initialize
	super
        @height = -1
    end

    attr_accessor :key

    attr_accessor :left

    attr_accessor :right

end
