#
# This file contains the Ruby code from Program 11.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_01.txt
#
module PriorityQueueMethods

    abstractmethod :enqueue

    abstractmethod :min

    abstractmethod :dequeueMin

end

class PriorityQueue < Container

    def initialize
	super
    end

    include PriorityQueueMethods

end
