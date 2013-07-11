#
# This file contains the Ruby code from Program 7.21 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_21.txt
#
class PolynomialAsOrderedList < Polynomial

    def initialize
        @list = OrderedListAsLinkedList.new
    end

    def addTerm(term)
        @list.insert(term)
    end

    def each(&block)
	@list.each(&block)
    end

    def find(term)
        @list.find(term)
    end

    def withdraw(term)
        @list.withdraw(term)
    end

end
