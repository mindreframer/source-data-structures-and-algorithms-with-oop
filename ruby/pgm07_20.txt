#
# This file contains the Ruby code from Program 7.20 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_20.txt
#
class Polynomial < Container

    def initialize
	super
    end

    abstractmethod :addTerm

    abstractmethod :differentiate!

    abstractmethod :+

end
