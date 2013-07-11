#
# This file contains the Ruby code from Program A.7 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm0A_07.txt
#
class Person

    FEMALE = 0
    MALE = 1

    def initialize(name, sex)
        @name = name
        @sex = sex
    end

    def to_s
        @name.to_s
    end

end
