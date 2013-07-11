#
# This file contains the Ruby code from Program 6.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_11.txt
#
module Algorithms

    def Algorithms.calculator(input, output)
        stack = StackAsLinkedList.new
        for line in input.readlines
            for word in line.split
                if word == "+"
                    arg2 = stack.pop
                    arg1 = stack.pop
                    stack.push(arg1 + arg2)
                elsif word == "*"
                    arg2 = stack.pop
                    arg1 = stack.pop
                    stack.push (arg1 * arg2)
                elsif word == "="
                    arg = stack.pop
		    output.puts arg
                else
                    stack.push(word.to_i)
		end
	    end
	end
    end

end
