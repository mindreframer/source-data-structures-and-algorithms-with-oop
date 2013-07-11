#
# This file contains the Ruby code from Program 10.5 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_05.txt
#
class BinarySearchTree < BinaryTree

    def withdraw(obj)
	raise ArgumentError if empty?
        diff = obj <=> @key
        if diff == 0
            if not @left.empty?
                max = @left.max
                @key = max
                @left.withdraw(max)
            elsif not @right.empty?
                min = @right.min
                @key = min
                @right.withdraw(min)
            else
                detachKey
	    end
        elsif diff < 0
            @left.withdraw(obj)
        elsif diff > 0
            @right.withdraw(obj)
	end
        balance
    end

end
