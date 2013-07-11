#
# This file contains the Ruby code from Program 9.15 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_15.txt
#
class BinaryTree < Tree

    def initialize(*args)
        super()
	case args.length
	when 0
            @key = nil
            @left = nil
            @right = nil
	when 1
            @key = args[0]
            @left = BinaryTree.new
            @right = BinaryTree.new
	when 3
            @key = args[0]
            @left = args[1]
            @right = args[2]
        else
            raise ArgumentError
	end
    end

    def purge
        @key = nil
        @left = nil
        @right = nil
    end

end
