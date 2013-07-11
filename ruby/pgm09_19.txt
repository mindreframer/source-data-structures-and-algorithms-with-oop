#
# This file contains the Ruby code from Program 9.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_19.txt
#
class ExpressionTree < BinaryTree

    def initialize(word)
	super
    end
    
    def ExpressionTree.parsePostfix(input)
        stack = StackAsLinkedList.new
        for line in input.readlines
            for word in line.split
                if word == "+" or word == "-" \
                        or word == "*" or word == "/"
                    result = ExpressionTree.new(word)
                    result.attachRight(stack.pop)
                    result.attachLeft(stack.pop)
                    stack.push(result)
                else
                    stack.push(ExpressionTree.new(word))
		end
	    end
	end
        return stack.pop
    end

end
