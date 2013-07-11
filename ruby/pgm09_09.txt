#
# This file contains the Ruby code from Program 9.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_09.txt
#
class Tree < Container

    class Iterator < Opus8::Iterator

	def initialize(tree)
	    @stack = StackAsLinkedList.new
	    @stack.push(tree) if not tree.empty?
	end

	def more?
	    not @stack.empty?
	end

	def succ
	    if more?
		top = @stack.pop
		i = top.degree - 1
		while i >= 0
		    subtree = top.getSubtree(i)
		    @stack.push(subtree) if not subtree.empty?
		    i -= 1
		end
		result = top.key
	    else
		result = nil
	    end
	    return result
	end

    end

    def iter
	Iterator.new(self)
    end

end
