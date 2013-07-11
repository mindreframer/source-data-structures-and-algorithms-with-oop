#
# This file contains the Ruby code from Program 14.11 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm14_11.txt
#
def typeset(l, capD, s)
    n = len(l)
    capL = DenseMatrix.new(n, n)
    for i in 0 ... n
        capL[i, i] = l[i]
        for j in i + 1 ...  n
            capL[i, j] = capL[i, j - 1] + l[j]
	end
    end
    capP = DenseMatrix.new(n, n)
    for i in 0 ... n
        for j in i ... n
            if capL[i, j] < capD
                capP[i, j] = (capD - capL[i,j] - (j - i) * s).abs
            else
                capP[i, j] = Fixnum::MAX
	    end
	end
    end
    c = DenseMatrix.new(n, n)
    for j in 0 ... n
        c[j, j] = capP[j, j]
        i = j - 1
        while i >= 0
            min = capP[i, j]
            for k in i ... j
                tmp = capP[i, k] + c[k + 1, j]
                if tmp < min
                    min = tmp
		end
	    end
            c[i, j] = min
            i -= 1
	end
    end
end
