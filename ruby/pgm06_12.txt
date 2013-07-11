#
# This file contains the Ruby code from Program 6.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_12.txt
#
class Queue < Container

    def initialize
        super
    end

    abstractmethod :enqueue

    abstractmethod :dequeue

    abstractmethod :head

end
