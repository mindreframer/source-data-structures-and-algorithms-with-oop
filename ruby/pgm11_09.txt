#
# This file contains the Ruby code from Program 11.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_09.txt
#
class LeftistHeap < BinaryTree

    def enqueue(obj)
        merge!(LeftistHeap.new(obj))
    end

end
