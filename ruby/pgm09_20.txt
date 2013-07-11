#
# This file contains the Ruby code from Program 9.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_20.txt
#
class ExpressionTree < BinaryTree

    def to_s
	s = ""
        depthFirstTraversal do |obj, mode|
	    case mode
	    when Tree::PREVISIT
		s << "("
	    when Tree::INVISIT
		s << obj.to_s
	    when Tree::POSTVISIT
		s << ")"
	    end
	end
	s
    end

end
