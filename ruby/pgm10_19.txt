#
# This file contains the Ruby code from Program 10.19 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_19.txt
#
class BTree < MWayTree

    def initialize(m)
	super
        @parent = nil
    end

    def attachSubtree(i, t)
        @subtree[i] = t
        t.parent = self
    end

    attr_accessor :parent

end
