#
# This file contains the Ruby code from Program 9.14 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_14.txt
#
class NaryTree < Tree

    def getSubtree(i)
	raise StateError if empty?
        return @subtree[i]
    end

    def attachSubtree(i, t)
	raise StateError if empty? or not @subtree[i].empty?
        @subtree[i] = t
    end

    def detachSubtree(i)
	raise StateError if empty?
        result = @subtree[i]
        @subtree[i] = NaryTree.new(degree)
        return result
    end

end
