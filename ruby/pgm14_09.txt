#
# This file contains the Ruby code from Program 14.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_09.txt
#
def fibonacci(n, k)
    if n < k - 1
        return 0
    elsif n == k - 1
        return 1
    else
        f = [0] * (n + 1)
        for i in 0 ... k - 1
            f[i] = 0
	end
        f[k - 1] = 1
        for i in k .. n
            sum = 0
            for j in 0 .. k
                sum += f[i - j]
	    end
            f[i] = sum
	end
        return f[n]
    end
end
