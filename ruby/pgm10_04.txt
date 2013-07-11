#
# This file contains the Ruby code from Program 10.4 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_04.txt
#
class BinarySearchTree < BinaryTree

    def insert(obj)
        if empty?
            attachKey(obj)
        else
            diff = obj <=> @key
            if diff == 0
                raise ArgumentError
            elsif diff < 0
                @left.insert(obj)
            elsif diff > 0
                @right.insert(obj)
	    end
	end
        balance
    end

    def attachKey(obj)
	raise StateError if not empty?
        @key = obj
        @left = BinarySearchTree.new
        @right = BinarySearchTree.new
    end

    def balance
    end

end
