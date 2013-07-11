#
# This file contains the Ruby code from Program 6.21 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm06_21.txt
#
class DequeAsLinkedList < QueueAsLinkedList

    alias_method :queueHead, :head

    include DequeMethods

    def initialize
	super
    end

    alias_method :head, :queueHead

    def enqueueHead(obj)
        @list.prepend(obj)
        @count += 1
    end

    alias_method :dequeueHead, :dequeue

end
