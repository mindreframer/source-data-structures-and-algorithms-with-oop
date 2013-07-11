#
# This file contains the Ruby code from Program 8.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm08_09.txt
#
class ChainedHashTable < HashTable

    def insert(obj)
        @array[h(obj)].append(obj)
        @count += 1
    end

    def withdraw(obj)
        @array[h(obj)].extract(obj)
        @count -= 1
    end

end
