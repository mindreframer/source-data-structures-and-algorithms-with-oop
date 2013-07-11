#
# This file contains the Ruby code from Program 14.1 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_01.txt
#
class Solution < AbstractObject

    abstractmethod :feasible?

    abstractmethod :complete?

    abstractmethod :objective

    abstractmethod :bound

    abstractmethod :successors

end
