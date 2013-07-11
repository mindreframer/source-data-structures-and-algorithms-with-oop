#
# This file contains the Ruby code from Program 5.12 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm05_12.txt
#
class Association

    def compareTo(assoc)
	assert { is_a?(assoc.type) }
        key <=> assoc.key
    end

    def to_s
        "%s{%s, %s}" % [type.name, @key.to_s, @value.to_s]
    end

end
