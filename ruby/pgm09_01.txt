#
# This file contains the Ruby code from Program 9.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm09_01.txt
#
class Tree < Container

    def initialize
	super
    end

    abstractmethod :key

    abstractmethod :getSubtree

    abstractmethod :empty?

    abstractmethod :leaf?

    abstractmethod :degree

    abstractmethod :height

end
