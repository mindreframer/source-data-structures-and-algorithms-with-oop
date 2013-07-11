#
# This file contains the Ruby code from Program 12.13 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm12_13.txt
#
class MultisetAsLinkedList < Multiset

    def initialize(n)
        super
        @list = LinkedList.new
    end

    attr_accessor :list
    public :list
    protected :list=

end
