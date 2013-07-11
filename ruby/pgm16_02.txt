#
# This file contains the Ruby code from Program 16.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm16_02.txt
#
class Edge < AbstractObject

    def initialize
	super
    end

    abstractmethod :v0

    abstractmethod :v1

    abstractmethod :weight

    abstractmethod :isdirected?

    abstractmethod :mateOf

end
