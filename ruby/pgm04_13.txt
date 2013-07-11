#
# This file contains the Ruby code from Program 4.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_13.txt
#
class LinkedList

    attr_accessor :head

    attr_accessor :tail
    
    def empty?
        @head.nil?
    end

end
