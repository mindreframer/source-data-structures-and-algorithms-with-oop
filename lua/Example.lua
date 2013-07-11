#!/usr/local/bin/lua
--[[

    Copyright (c) 2004 by Bruno R. Preiss, P.Eng.

    $Author: brpreiss $
    $Date: 2004/12/05 20:04:16 $
    $RCSfile: Example.lua,v $
    $Revision: 1.6 $

    $Id: Example.lua,v 1.6 2004/12/05 20:04:16 brpreiss Exp $

--]]

require "DenseMatrix"
require "RandomNumberGenerator"

-- Dummy module.
Example = Module.new("Example")

--{
-- Returns the sum of the first n integers.
-- @param n A non-negative integer.
function sum(n)
    local result = 0
    local i = 1
    while i <= n do
        result = result + i
        i = i + 1
    end
    return result
end
--}>a

--{
-- Evaluates a polynomial in x.
-- @param a The coefficients of the polynomial.
-- @param n The degree of the polynomial.
-- @param x The value at which to evaluate the polynomial.
--<
function horner1(a, n, x)
-->
--!function horner(a, n, x)
    local result = a[n]
    local i = n - 1
    while i >= 0 do
        result = result * x + a[i]
        i = i - 1
    end
    return result
end
--}>b

--{
-- Returns the factorial of n.
-- @parma n A non-negative integer.
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end
--}>c

--{
-- Returns the largest value in an array of values.
-- @param a An array of values.
-- @param n The length of the array.
function findMaximum(a, n)
    local result = a[0]
    local i = 1
    while i < n do
        if a[i] > result then
            result = a[i]
	end
        i = i + 1
    end
    return result
end
--}>d

--{
-- Approximates Euler's constant.
function gamma()
    local result = 0
    local i = 1
    while i <= 500000 do
        result = result + 1/i - math.log((i + 1)/i)
        i = i + 1
    end
    return result
end
--}>e

--{
-- Returns the sum of the first n terms
-- of a geometric series in x.
-- @param x A value.
-- @param n The number of terms to be added.
--<
function geometricSeriesSum1(x, n)
-->
--!function geometricSeriesSum(x, n)
    local sum = 0
    local i = 0
    while i <= n do
        local prod = 1
        local j = 0
        while j < i do
            prod = prod * x
            j = j + 1
	end
        sum = sum + prod
        i = i + 1
    end
    return sum
end
--}>f

--{
-- Returns the sum of the first n terms
-- of a geometric series in x.
-- @param x A value.
-- @param n The number of terms to be added.
--<
function geometricSeriesSum2(x, n)
-->
--!function geometricSeriesSum(x, n)
    local sum = 0
    local i = 0
    while i <= n do
        sum = sum * x + 1
        i = i + 1
    end
    return sum
end
--}>g

--{
-- Returns x raised to the power n.
-- @param x A value.
-- @param n A non-negative integer.
function power(x, n)
    if n == 0 then
        return 1
    elseif math.mod(n, 2) == 0 then -- n is even
        return power(x * x, math.floor(n / 2))
    else -- n is odd
        return x * power(x * x, math.floor(n / 2))
    end
end
--}>h

--{
-- Returns the sum of the first n terms
-- of a geometric series in x.
-- @param x A value.
-- @param n The number of terms to be added.
--<
function geometricSeriesSum3(x, n)
-->
--!function geometricSeriesSum(x, n)
    return (power(x, n + 1) - 1) / (x - 1)
end
--}>i

-- Evaluates a polynomial in x.
-- @param a The coefficients of the polynomial.
-- @param n The degree of the polynomial.
-- @param x The value at which to evaluate the polynomial.
--<
function horner2(a, n, x)
-->
--!function horner(a, n, x)
    local result = a[n]
    local i = n - 1
    while i >= 0 do
        result = result * x + a[i]
        i = i - 1
    end
    return result
end
--}>j

--{
-- Computes (in place) all the prefix sums
-- of an array of n values.
-- @param a An array of values.
-- @param n The length of the array.
function prefixSums(a, n)
    local j = n - 1
    while j >= 0 do
        local sum = 0
        local i = 0
        while i <= j do
            sum = sum + a[i]
            i = i + 1
	end
        a[j] = sum
        j = j - 1
    end
end
--}>k

-- Returns the nth Fibonacci number.
-- Uses a non-recursive (iterative) algorithm.
-- @param n A non-negative integer.
--<
function fibonacci1(n)
-->
--!function fibonacci(n)
    local previous = -1
    local result = 1
    local i = 0
    while i <= n do
        local sum = result + previous
        previous = result
        result = sum
        i = i + 1
    end
    return result
end

-- Returns the nth Fibonacci number.
-- Uses a recursive algorithm.
-- @param n A non-negative integer.
--<
function fibonacci2(n)
-->
--!function fibonacci(n)
    if n == 0 or n == 1 then
        return n
    else
--<
        return fibonacci2(n - 1) + fibonacci2(n - 2)
-->
--!        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end

--{
-- Sorts (in place) an array of integers
-- which are known to fall in the interval [0, m-1]
-- using the given array of "buckets".
-- @param a The array to sort.
-- @param n The length of the array to sort.
-- @param buckets An array of buckets.
-- @param m The length of the array of buckets.
function bucketSort(a, n, buckets, m)
    for j = 0, m - 1 do
        buckets[j] = 0
    end
    for i = 0, n - 1 do
        buckets[a[i]] = buckets[a[i]] + 1
    end
    local i = 0
    for j = 0, m - 1 do
        for k = 0, buckets[j] - 1 do
            a[i] = j
            i = i + 1
	end
    end
end
--}>n

--{
-- Returns the position of a given target value
-- in a specified contiguous
-- region in a sorted array of values.
-- Uses a recursive, divide-and-conquer algorithm.
-- @param array An array of values.
-- @param target The value to find.
-- @param i The left end of the region to search.
-- @param n The right end of the region to search.
function binarySearch(array, target, i, n)
    if n == 0 then
        error "ArgumentError"
    elseif n == 1 then
        if array[i] == target then
            return i
	else
	    raise "ArgumentError"
	end
    else
        local j = i + math.floor(n / 2)
        if array[j] <= target then
            return binarySearch(
		    array, target, j, n - math.floor(n/2))
        else
            return binarySearch(
		    array, target, i, math.floor(n/2))
	end
    end
end
--}>o

--{
-- Returns the nth Fibonacci number.
-- Uses an efficient recursive algorithm.
-- @param n A non-negative integer.
--<
function fibonacci3(n)
-->
--!function fibonacci(n)
    if n == 0 or n == 1 then
        return n
    else
--<
        local a = fibonacci3(math.floor((n + 1) / 2))
        local b = fibonacci3(math.floor((n + 1) / 2) - 1)
-->
--!        local a = fibonacci(math.floor((n + 1) / 2))
--!        local b = fibonacci(math.floor((n + 1) / 2) - 1)
        if math.mod(n, 2) == 0 then
            return a * (a + 2 * b)
        else
            return a * a + b * b
	end
    end
end
--}>p

-- Merges (in place) two sorted subsequences of an array
-- into a single sorted subsequence.
-- @param array An array of values.
-- @param pos The start of the left subsequence.
-- @param m The number of elements in the left subsequence.
-- @param n The number of elements in the right subsequence.
function merge(array, pos, m, n)
    local temp = Array.new(m + n)
    local i = pos
    local left = pos + m
    local j = left
    local right = left + n
    local k = 0
    while i < left and j < right do
        if array[i] < array[j] then
            temp[k] = array[i]
            k = k + 1
            i = i + 1
        else
            temp[k] = array[j]
            k = k + 1
            j = j + 1
	end
    end
    while i < left do
        temp[k] = array[i]
        k = k + 1
        i = i + 1
    end
    while j < right do
        temp[k] = array[j]
        k = k + 1
        j = j + 1
    end
    for k = 0, m + n - 1 do
        array[pos + k] = temp[k]
    end
end

--{
-- Sorts (in place) a contiguous region in array of values.
-- @param array The array of values to be sorted.
-- @param i The position of the left-most element to be sorted.
-- @param n The length of the region to be sorted.
function mergeSort(array, i, n)
    if n > 1 then
        mergeSort(array, i, math.floor(n / 2))
        mergeSort(
	    array, i + math.floor(n / 2), n - math.floor(n / 2))
        merge(array, i, math.floor(n / 2), n - math.floor(n / 2))
    end
end
--}>q

--{
-- Returns the nth Fibonacci number of order k.
-- @param n A non-negative integer.
-- @param k A non-negative integer.
--<
function fibonacci4(n, k)
-->
--!function fibonacci(n)
    if n < k - 1 then
        return 0
    elseif n == k - 1 then
        return 1
    else
	local f = Array.new(n + 1)
	for i = 0, n do
	    f[i] = 0
	end
        for i = 0, k - 2 do
            f[i] = 0
	end
        f[k - 1] = 1
        for i = k, n do
            local sum = 0
            for j = 0, k do
                sum = sum + f[i - j]
	    end
            f[i] = sum
	end
        return f[n]
    end
end
--}>r

--{
-- Returns the binomial coefficient, n choose m.
-- Uses a dynamic-programming algorithm.
-- @param n A positive (non-zero) integer.
-- @param m A positive (non-zero) integer.
function binom(n, m)
    local b = Array.new(n + 1)
    for i = 0, n do
	b[i] = 0
    end
    b[0] = 1
    for i = 1, n do
        b[i] = 1
        j = i - 1
        while j > 0 do
            b[j] = b[j] + b[j - 1]
            j = j - 1
	end
    end
    return b[m]
end
--}>s

--{
-- Finds the optimum way to typeset a justified paragraph.
-- @param l The lengths of the words in the paragraph.
-- @param D The length of a line.
-- @param s The length of the normal interword space.
function typeset(l, D, s)
    local n = l:get_length()
    local L = DenseMatrix.new{n, n}
    for i = 0, n - 1 do
        L[{i, i}] = l[i]
        for j = i + 1, n - 1 do
            L[{i, j}] = L[{i, j - 1}] + l[j]
	end
    end
    local P = DenseMatrix.new{n, n}
    for i = 0, n - 1 do
        for j = i, n - 1 do
	    if L[{i, j}] < D then
                P[{i, j}] = math.abs(D - L[{i, j}] - (j - i) * s)
            else
                P[{i, j}] = 9999999999 -- Fixnum::MAX
	    end
	end
    end
    local c = DenseMatrix.new{n, n}
    for j = 0, n - 1 do
        c[{j, j}] = P[{j, j}]
        local i = j - 1
        while i >= 0 do
            local min = P[{i, j}]
            for k = i, j - 1 do
                local tmp = P[{i, k}] + c[{k + 1, j}]
                if tmp < min then
                    min = tmp
		end
	    end
            c[{i, j}] = min
            i = i - 1
	end
    end
    return c
end
--}>t

--{
-- Approximates the value of pi.
-- Uses a Monte-carlo algorithm.
-- @param trials The number of trials to be done.
function pi(trials)
    local hits = 0
    for i = 1, trials do
        x = RandomNumberGenerator.instance:next()
        y = RandomNumberGenerator.instance:next()
        if x * x + y * y < 1 then
            hits = hits + 1
	end
    end
    return 4 * hits / trials
end
--}>u

--{
-- Sample function to illustrate parameter passing.
function one()
    local x = 1
    print(x)
    two(x)
    print(x)
end

-- Sample function to illustrate parameter passing.
function two(y)
    print(y)
    y = 2
    print(y)
end
--}>v

--{
-- Sample function to illustrated exceptions.
function f()
    error "A"
end

-- Sample function to illustrated exceptions.
function g()
    local status, err = pcall(f)
    if status then
	print("Caught ", err)
    end
end
--}>w

if _REQUIREDNAME == nil then
    print("sum(10) = ", sum(10))
    print("horner1([2,4,6], 2, 57) = ",
	    horner1(box{2,4,6}, 2, 57))
    print("horner2([2,4,6], 2, 57) = ",
	    horner2(box{2,4,6}, 2, 57))
    print("factorial(10) = ", factorial(10))
    print("findMaximum({3,1,4,1,5,9,2}, 7) = ",
	    findMaximum(box{3,1,4,1,5,9,2}, 7))
    print("gamma = ", gamma())
    print("geometricSeriesSum1(10, 6) = ",
	    geometricSeriesSum1(10, 6))
    print("geometricSeriesSum2(10, 6) = ",
	    geometricSeriesSum2(10, 6))
    print("geometricSeriesSum3(10, 6) = ",
	    geometricSeriesSum3(10, 6))
    arg = box{2,4,6,8}
    prefixSums(arg, 4)
    print("prefixSums({=2,4,6,8}, 4) = ", arg)
    print("fibonacci1(5) = ", fibonacci1(10))
    print("fibonacci2(5) = ", fibonacci2(10))
    print("fibonacci3(5) = ", fibonacci3(10))
    print("fibonacci4(5, 2) = ", fibonacci4(10, 2))
    arg = box{3,1,4,1,5,9,2}
    buckets = box{0,0,0,0,0,0,0,0,0,0}
    bucketSort(arg, 7, buckets, 10)
    print("bucketSort({3,1,4,1,5,9,2}, 10) = ", arg)
    arg = box{3,1,4,1,5,9,2}
    mergeSort(arg, 0, 7)
    print("mergeSort({3,1,4,1,5,9,2}, 10) = ", arg)
    print("binarySearch({1,1,2,3,4,5,9}, 5, 0, 7) = ",
        binarySearch(box{1,1,2,3,4,5,9}, 5, 0, 7))
    print("binom(5, 2) = ", binom(5, 2))
    print("pi(10000) = ", pi(10000))
    one()
end
