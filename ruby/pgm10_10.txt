#
# This file contains the Ruby code from Program 10.10 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_10.txt
#
class AVLTree < BinarySearchTree

    def balance
        adjustHeight
        if balanceFactor > 1
            if @left.balanceFactor > 0
                doLLRotation
            else
                doLRRotation
	    end
        elsif balanceFactor < -1
            if @right.balanceFactor < 0
                doRRRotation
            else
                doRLRotation
	    end
	end
    end

end
