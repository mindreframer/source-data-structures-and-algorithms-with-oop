#
# This file contains the Ruby code from Program 10.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_01.txt
#
module SearchTreeMethods

    abstractmethod :min

    abstractmethod :max

end

class SearchTree < Tree

    def initialize
	super
    end

    include SearchableContainerMethods
    include SearchTreeMethods

end
