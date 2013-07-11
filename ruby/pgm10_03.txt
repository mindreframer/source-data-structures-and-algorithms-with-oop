#
# This file contains the Ruby code from Program 10.3 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_03.txt
#
class BinarySearchTree < BinaryTree

    def find(obj)
	return nil if empty?
        diff = obj <=> @key
        if diff == 0
            return @key
        elsif diff < 0
            return @left.find(obj)
        elsif diff > 0
            return @right.find(obj)
	end
    end

    def min
        if empty?
            return nil
        elsif @left.empty?
            return @key
        else
            return @left.min
	end
    end

end
