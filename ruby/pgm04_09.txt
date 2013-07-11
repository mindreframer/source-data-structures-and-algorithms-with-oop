#
# This file contains the Ruby code from Program 4.9 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm04_09.txt
#
class DenseMatrix < Matrix

    def *(mat)
        assert { numberOfColumns == mat.numberOfRows }
        result = DenseMatrix.new(
	    numberOfRows, mat.numberOfColumns)
        for i in 0 ... numberOfRows
            for j in 0 ... mat.numberOfColumns
                sum = 0
                for k in 0 ... numberOfColumns
                    sum += self[i,k] * mat[k,j]
		end
                result[i,j] = sum
	    end
	end
        return result
    end

end
