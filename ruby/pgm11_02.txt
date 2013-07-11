#
# This file contains the Ruby code from Program 11.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_02.txt
#
module MergeablePriorityQueueMethods

    abstractmethod :merge!
end

class MergeablePriorityQueue < PriorityQueue

    def initialize
	super
    end

    include MergeablePriorityQueueMethods

end
