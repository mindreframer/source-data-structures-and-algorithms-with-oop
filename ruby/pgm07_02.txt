#
# This file contains the Ruby code from Program 7.2 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm07_02.txt
#
class Cursor < AbstractObject

    abstractmethod :datum

    abstractmethod :insertAfter

    abstractmethod :insertBefore

    abstractmethod :withdraw

end
