#
# This file contains the Ruby code from Program 10.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_07.txt
#
class AVLTree < BinarySearchTree

    attr_reader :height

    def adjustHeight
        if empty?
            @height = -1
        else
            @height = [@left.height, @right.height].max + 1
	end
    end

    def balanceFactor
        if empty?
            return 0
        else
            return @left.height - @right.height
	end
    end

end
