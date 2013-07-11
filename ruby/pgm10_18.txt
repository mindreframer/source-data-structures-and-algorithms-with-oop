#
# This file contains the Ruby code from Program 10.18 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm10_18.txt
#
class MWayTree < SearchTree

    def withdraw(obj)
	raise ArgumentError if empty?
        index = findIndex(obj)
        if index != 0 and @key[index] == obj
            if not @subtree[index - 1].empty?
                max = @subtree[index - 1].max
                @key[index] = max
                @subtree[index - 1].withdraw(max)
            elsif not @subtree[index].empty?
                min = @subtree[index].min
                @key[index] = min
                @subtree[index].withdraw(min)
            else
                @count = @count - 1
                i = index
                while i <= @count
                    @key[i] = @key[i + 1]
                    @subtree[i] = @subtree[i + 1]
                    i = i + 1
		end
                @key[i] = nil
                @subtree[i] = nil
                if @count == 0
                    @subtree[0] = nil
		end
	    end
        else
            @subtree[index].withdraw(obj)
	end
    end

end
