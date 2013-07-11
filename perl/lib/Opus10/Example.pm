#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:02 $
#   $RCSfile: Example.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Example.pm,v 1.1 2005/09/25 21:36:02 brpreiss Exp $
#

use strict;

# @package Opus10::Example
# Provides various examples.
package Opus10::Example;
use Opus10::DenseMatrix;
use Opus10::RandomNumberGenerator;

#{
# @function sum
# Returns the sum of the first n integers.
# @param n A non-negative integer.
# @return The sum.
sub sum
{
    my ($n) = @_;
    my $result = 0;
    my $i = 1;
    while ($i <= $n)
    {
        $result = $result + $i;
        $i = $i + 1;
    }
    return $result;
}
#}>a

#{
# @function horner1
# Evaluates a polynomial in x.
# @param a The coefficients of the polynomial.
# @param n The degree of the polynomial.
# @param x The value at which to evaluate the polynomial.
# @return The value of the polynomial.
#[
sub horner1
#]
#!sub horner
{
    my ($a, $n, $x) = @_;
    my $result = ${$a}[$n];
    my $i = $n - 1;
    while ($i >= 0)
    {
        $result = $result * $x + ${$a}[$i];
        $i = $i - 1;
    }
    return $result;
}
#}>b

#{
# @function factorial
# Returns the factorial of n.
# @param n A non-negative integer.
# @return The factorial of n.
sub factorial
{
    my ($n) = @_;
    if ($n == 0)
    {
        return 1;
    }
    else
    {
        return $n * factorial($n - 1);
    }
}
#}>c

#{
# @method findMaximum
# Returns the largest value in an array of values.
# @param a An array of values.
# @param n The length of the array.
# @return The largest value.
sub findMaximum
{
    my ($a, $n) = @_;
    my $result = ${$a}[0];
    my $i = 1;
    while ($i < $n)
    {
        if (${$a}[$i] > $result)
	{
            $result = ${$a}[$i];
	}
        $i = $i + 1;
    }
    return $result;
}
#}>d

#{
# @function gamma
# Approximates Euler's constant.
# @return Gamma.
sub gamma
{
    my $result = 0;
    my $i = 1;
    while ($i <= 500000)
    {
        $result = $result + 1/$i - log(($i + 1)/$i);
        $i = $i + 1;
    }
    return $result;
}
#}>e

#{
# @function geometricSeriesSum1
# Returns the sum of the first n terms
# of a geometric series in x.
# @param x A value.
# @param n The number of terms to be added.
# @return The sum.
#[
sub geometricSeriesSum1
#]
#!sub geometricSeriesSum
{
    my ($x, $n) = @_;
    my $sum = 0;
    my $i = 0;
    while ($i <= $n)
    {
        my $prod = 1;
        my $j = 0;
        while ($j < $i)
	{
            $prod = $prod * $x;
            $j = $j + 1;
	}
        $sum = $sum + $prod;
        $i = $i + 1;
    }
    return $sum;
}
#}>f

#{
# @function geometricSeriesSum2
# Returns the sum of the first n terms
# of a geometric series in x.
# @param x A value.
# @param n The number of terms to be added.
# @return The sum.
#[
sub geometricSeriesSum2
#]
#!sub geometricSeriesSum
{
    my ($x, $n) = @_;
    my $sum = 0;
    my $i = 0;
    while ($i <= $n)
    {
        $sum = $sum * $x + 1;
        $i = $i + 1;
    }
    return $sum;
}
#}>g

#{
# @function power
# Returns x raised to the power n.
# @param x A value.
# @param n A non-negative integer.
# @return x raised to the power n.
sub power
{
    my ($x, $n) = @_;
    use integer;
    if ($n == 0)
    {
        return 1;
    }
    elsif ($n % 2 == 0) # n is even
    {
        return power($x * $x, $n / 2);
    }
    else
    {
        return $x * power($x * $x, $n / 2);
    }
}
#}>h

#{
# @function geometricSeriesSum3
# Returns the sum of the first n terms
# of a geometric series in x.
# @param x A value.
# @param n The number of terms to be added.
# @return The sum.
#[
sub geometricSeriesSum3
#]
#!sub geometricSeriesSum
{
    my ($x, $n) = @_;
    return (power($x, $n + 1) - 1) / ($x - 1);
}
#}>i

#{
# @function horner2
# Evaluates a polynomial in x.
# @param a The coefficients of the polynomial.
# @param n The degree of the polynomial.
# @param x The value at which to evaluate the polynomial.
# @return The value of the polynomial.
#[
sub horner2
#]
#!sub horner
{
    my ($a, $n, $x) = @_;
    my $result = ${$a}[$n];
    my $i = $n - 1;
    while ($i >= 0)
    {
        $result = $result * $x + ${$a}[$i];
        $i = $i - 1;
    }
    return $result;
}
#}>j

#{
# @function prefixSums
# Computes (in place) all the prefix sums
# of an array of n values.
# @param a An array of values.
# @param n The length of the array.
sub prefixSums
{
    my ($a, $n) = @_;
    my $j = $n - 1;
    while ($j >= 0)
    {
        my $sum = 0;
        my $i = 0;
        while ($i <= $j)
	{
            $sum = $sum + ${$a}[$i];
            $i = $i + 1;
	}
        ${$a}[$j] = $sum;
        $j = $j - 1;
    }
}
#}>k

# @function fibonacci1
# Returns the nth Fibonacci number.
# Uses a non-recursive (iterative) algorithm.
# @param n A non-negative integer.
# @return The nth Fibonacci number.
#[
sub fibonacci1
#]
#!sub fibonacci
{
    my ($n) = @_;
    my $previous = -1;
    my $result = 1;
    my $i = 0;
    while ($i <= $n)
    {
        my $sum = $result + $previous;
        $previous = $result;
        $result = $sum;
        $i = $i + 1;
    }
    return $result;
}

# @function fibonacci2
# Returns the nth Fibonacci number.
# Uses a recursive algorithm.
# @param n A non-negative integer.
# @return The nth Fibonacci number.
#[
sub fibonacci2
#]
#!sub fibonacci
{
    my ($n) = @_;
    if ($n == 0 || $n == 1)
    {
        return $n;
    }
    else
    {
#<
        return fibonacci2($n - 1) + fibonacci2($n - 2);
#>
#!        return fibonacci($n - 1) + fibonacci($n - 2);
    }
}

#{
# @function bucketSort
# Sorts (in place) an array of integers
# which are known to fall in the interval [0, m-1]
# using the given array of "buckets".
# @param a The array to sort.
# @param n The length of the array to sort.
# @param buckets An array of buckets.
# @param m The length of the array of buckets.
sub bucketSort
{
    my ($a, $n, $buckets, $m) = @_;
    for (my $j = 0; $j < $m; ++$j)
    {
        ${$buckets}[$j] = 0;
    }
    for (my $i = 0; $i < $n; ++$i)
    {
        ${$buckets}[${$a}[$i]] = ${$buckets}[${$a}[$i]] + 1;
    }
    my $i = 0;
    for (my $j = 0; $j < $m; ++$j)
    {
        for (my $k = 0; $k < ${$buckets}[$j]; ++$k)
	{
            ${$a}[$i] = $j;
            $i = $i + 1;
	}
    }
}
#}>n

#{
# @function binarySearch
# Returns the position of a given target value
# in a specified contiguous
# region in a sorted array of values.
# Uses a recursive, divide-and-conquer algorithm.
# @param array An array of values.
# @param target The value to find.
# @param i The left end of the region to search.
# @param n The right end of the region to search.
sub binarySearch
{
    my ($array, $target, $i, $n) = @_;
    use integer;
    if ($n == 0)
    {
        die 'ArgumentError';
    }
    elsif ($n == 1)
    {
        if (${$array}[$i] == $target)
	{
            return $i;
	}
	else
	{
	    die 'ArgumentError';
	}
    }
    else
    {
        my $j = $i + $n / 2;
        if (${$array}[$j] <= $target)
	{
            return binarySearch($array, $target, $j, $n - $n/2);
	}
        else
	{
            return binarySearch($array, $target, $i, $n / 2);
	}
    }
}
#}>o

#{
# @function fibonacci3
# Returns the nth Fibonacci number.
# Uses an efficient recursive algorithm.
# @param n A non-negative integer.
# @return The nth Fibonacci number.
#[
sub fibonacci3
#]
#!sub fibonacci
{
    my ($n) = @_;
    use integer;
    if ($n == 0 || $n == 1)
    {
        return $n;
    }
    else
    {
#[
        my $a = fibonacci3(($n + 1) / 2);
        my $b = fibonacci3(($n + 1) / 2 - 1);
#]
#!        my $a = fibonacci(($n + 1) / 2);
#!        my $b = fibonacci(($n + 1) / 2 - 1);
        if ($n % 2 == 0)
	{
            return $a * ($a + 2 * $b);
	}
        else
	{
            return $a * $a + $b * $b;
	}
    }
}
#}>p

# @function merge
# Merges (in place) two sorted subsequences of an array
# into a single sorted subsequence.
# @param array An array of values.
# @param pos The start of the left subsequence.
# @param m The number of elements in the left subsequence.
# @param n The number of elements in the right subsequence.
sub merge
{
    my ($array, $pos, $m, $n) = @_;
    my $temp = [];
    my $i = $pos;
    my $left = $pos + $m;
    my $j = $left;
    my $right = $left + $n;
    my $k = 0;
    while ($i < $left && $j < $right)
    {
        if (${$array}[$i] < ${$array}[$j])
	{
            ${$temp}[$k] = ${$array}[$i];
            $k = $k + 1;
            $i = $i + 1;
	}
        else
	{
            ${$temp}[$k] = ${$array}[$j];
            $k = $k + 1;
            $j = $j + 1;
	}
    }
    while ($i < $left)
    {
        ${$temp}[$k] = ${$array}[$i];
        $k = $k + 1;
        $i = $i + 1;
    }
    while ($j < $right)
    {
        ${$temp}[$k] = ${$array}[$j];
        $k = $k + 1;
        $j = $j + 1;
    }
    for (my $k = 0; $k < $m + $n; ++$k)
    {
        ${$array}[$pos + $k] = ${$temp}[$k]
    }
}

#{
# @function mergeSort
# Sorts (in place) a contiguous region in array of values.
# @param array The array of values to be sorted.
# @param i The position of the left-most element to be sorted.
# @param n The length of the region to be sorted.
sub mergeSort
{
    my ($array, $i, $n) = @_;
    use integer;
    if ($n > 1)
    {
        mergeSort($array, $i, $n / 2);
        mergeSort($array, $i + $n / 2, $n - $n / 2);
        merge($array, $i, $n / 2, $n - $n / 2);
    }
}
#}>q

#{
# @function fibonacci4
# Returns the nth Fibonacci number of order k.
# @param n A non-negative integer.
# @param k A non-negative integer.
#[
sub fibonacci4
#]
#!sub fibonacci
{
    my ($n, $k) = @_;
    if ($n < $k - 1)
    {
        return 0;
    }
    elsif ($n == $k - 1)
    {
        return 1;
    }
    else
    {
	my $f = [];
	for (my $i = 0; $i <= $n; ++$i)
	{
	    ${$f}[$i] = 0;
	}
        for (my $i = 0; $i < $k - 1; ++$i)
	{
            ${$f}[$i] = 0;
	}
        ${$f}[$k - 1] = 1;
        for (my $i = $k; $i <= $n; ++$i)
	{
            my $sum = 0;
            for (my $j = 0; $j <= $k; ++$j)
	    {
                $sum = $sum + ${$f}[$i - $j];
	    }
            ${$f}[$i] = $sum;
	}
        return ${$f}[$n];
    }
}
#}>r

#{
# @function binom
# Returns the binomial coefficient, n choose m.
# Uses a dynamic-programming algorithm.
# @param n A positive (non-zero) integer.
# @param m A positive (non-zero) integer.
sub binom
{
    my ($n, $m) = @_;
    my $b = [];
    for (my $i = 0; $i <= $n; ++$i)
    {
	${$b}[$i] = 0;
    }
    ${$b}[0] = 1;
    for (my $i = 1; $i <= $n; ++$i)
    {
        ${$b}[$i] = 1;
        my $j = $i - 1;
        while ($j > 0)
	{
            ${$b}[$j] = ${$b}[$j] + ${$b}[$j - 1];
            $j = $j - 1;
	}
    }
    return ${$b}[$m];
}
#}>s

#{
# @function typeset
# Finds the optimum way to typeset a justified paragraph.
# @param l The lengths of the words in the paragraph.
# @param D The length of a line.
# @param s The length of the normal interword space.
sub typeset
{
    my ($l, $D, $s);
    my $n = @{$l};
    my $L = Opus10::DenseMatrix->new($n, $n);
    for (my $i = 0; $i < $n; ++$i) {
        $L->setItem($i, $i, ${$l}[$i]);
        for (my $j = $i + 1; $j < $n; ++$j) {
            $L->setItem($i, $j,
		$L->getItem($i, $j - 1) + ${$l}[$j]);
	}
    }
    my $P = Opus10::DenseMatrix->new($n, $n);
    for (my $i = 0; $i < $n; ++$i) {
        for (my $j = $i; $j < $n; ++$j) {
	    if ($L->getItem($i, $j) < $D) {
                $P->setItem($i, $j,
		    abs($D - $L->getItem($i, $j)
			- ($j - $i) * $s));
	    }
            else {
                $P->setItem($i, $j, 0x7fffffff);
	    }
	}
    }
    my $c = Opus10::DenseMatrix->new($n, $n);
    for (my $j = 0; $j < $n; ++$j) {
        $c->setItem($j, $j, $P->getItem($j, $j));
        my $i = $j - 1;
        while ($i >= 0) {
            my $min = $P->getItem($i, $j);
            for (my $k = $i; $k < $j; ++$k) {
                my $tmp = $P->getItem($i, $k) +
		    $c->getItem($k + 1, $j);
                if ($tmp < $min) {
                    $min = $tmp;
		}
	    }
            $c->setItem($i, $j) = $min;
            $i = $i - 1;
	}
    }
    return $c;
}
#}>t

#{
# @function pi
# Approximates the value of pi.
# Uses a Monte-carlo algorithm.
# @param trials The number of trials to be done.
# @return Pi.
sub pi
{
    my ($trials) = @_;
    my $hits = 0;
    for (my $i = 0; $i < $trials; ++$i)
    {
        my $x = Opus10::RandomNumberGenerator->next();
        my $y = Opus10::RandomNumberGenerator->next();
        if ($x * $x + $y * $y < 1.0)
	{
            $hits += 1;
	}
    }
    return 4 * $hits / $trials;
}
#}>u

#{
# @function one
# Sample function to illustrate parameter passing.
sub one
{
    my $x = 1;
    printf "%d\n", $x;
    two($x);
    printf "%s\n", $x;
    three($x);
    printf "%s\n", $x;
}

# @function two
# Sample function to illustrate parameter passing.
# @param y A value.
sub two
{
    my ($y) = @_;
    printf "%s\n", $y;
    $y = 2;
    printf "%s\n", $y;
}

# @function three
# Sample function to illustrate parameter passing.
# @param y A value.
sub three
{
    printf "%s\n", $_[0];
    $_[0] = 2;
    printf "%s\n", $_[0];
}
#}>v

#{
# @function f
# Sample function to illustrate exceptions.
sub f
{
    die 'A';
}

# @function g
# Sample function to illustrate exceptions.
sub g
{
    eval
    {
	f();
    };
    if ($@)
    {
	printf "Caught %s", $@;
    }
}
#}>w

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    printf "sum(10) = %d\n",
	    sum(10);
    printf "horner1([2,4,6], 2, 57) = %d\n",
	    horner1([2,4,6], 2, 57);
    printf "horner2([2,4,6], 2, 57) = %d\n",
	    horner2([2,4,6], 2, 57);
    printf "factorial(10) = %d\n",
	    factorial(10);
    printf "findMaximum([3,1,4,1,5,9,2], 7) = %d\n",
	    findMaximum([3,1,4,1,5,9,2], 7);
    printf "gamma = %g\n",
	    gamma;
    printf "geometricSeriesSum1(10, 6) = %d\n",
	    geometricSeriesSum1(10, 6);
    printf "geometricSeriesSum2(10, 6) = %d\n",
	    geometricSeriesSum2(10, 6);
    printf "geometricSeriesSum3(10, 6) = %d\n",
	    geometricSeriesSum3(10, 6);
    my $arg = [2,4,6,8];
    prefixSums($arg, 4);
    printf "prefixSums([2,4,6,8], 4) = %s\n",
	    join(',', @$arg);
    printf "fibonacci1(5) = %d\n",
	    fibonacci1(10);
    printf "fibonacci2(5) = %d\n",
	    fibonacci2(10);
    printf "fibonacci3(5) = %d\n",
	    fibonacci3(10);
    printf "fibonacci4(5, 2) = %d\n",
	    fibonacci4(10, 2);
    $arg = [3,1,4,1,5,9,2];
    my $buckets = [0,0,0,0,0,0,0,0,0,0];
    bucketSort($arg, 7, $buckets, 10);
    printf "bucketSort({3,1,4,1,5,9,2}, 10) = %s\n",
	    join(',', @$arg);
    $arg = [3,1,4,1,5,9,2];
    mergeSort($arg, 0, 7);
    printf "mergeSort({3,1,4,1,5,9,2}, 10) = %s\n",
	    join(',', @$arg);
    printf "binarySearch({1,1,2,3,4,5,9}, 5, 0, 7) = %s\n",
        binarySearch([1,1,2,3,4,5,9], 5, 0, 7);
    printf "binom(5, 2) = %d\n",
	    binom(5, 2);
    printf "pi(10000) = %g\n",
	    pi(10000);
    one();
    g();
}

1;
__DATA__

=head1 MODULE C<Opus10::Example>

=head2 PACKAGE C<Opus10::Example>

Provides various examples.

=head3 FUNCTION C<binarySearch>

Returns the position of a given target value
in a specified contiguous
region in a sorted array of values.
Uses a recursive, divide-and-conquer algorithm.

=head4 Parameters

=over

=item C<array>

An array of values.

=item C<target>

The value to find.

=item C<i>

The left end of the region to search.

=item C<n>

The right end of the region to search.

=back

=head3 FUNCTION C<binom>

Returns the binomial coefficient, n choose m.
Uses a dynamic-programming algorithm.

=head4 Parameters

=over

=item C<n>

A positive (non-zero) integer.

=item C<m>

A positive (non-zero) integer.

=back

=head3 FUNCTION C<bucketSort>

Sorts (in place) an array of integers
which are known to fall in the interval [0, m-1]
using the given array of "buckets".

=head4 Parameters

=over

=item C<a>

The array to sort.

=item C<n>

The length of the array to sort.

=item C<buckets>

An array of buckets.

=item C<m>

The length of the array of buckets.

=back

=head3 FUNCTION C<f>

Sample function to illustrate exceptions.

=head3 FUNCTION C<factorial>

Returns the factorial of n.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=back

=head4 Return

The factorial of n.

=head3 FUNCTION C<fibonacci1>

Returns the nth Fibonacci number.
Uses a non-recursive (iterative) algorithm.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=back

=head4 Return

The nth Fibonacci number.

=head3 FUNCTION C<fibonacci2>

Returns the nth Fibonacci number.
Uses a recursive algorithm.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=back

=head4 Return

The nth Fibonacci number.

=head3 FUNCTION C<fibonacci3>

Returns the nth Fibonacci number.
Uses an efficient recursive algorithm.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=back

=head4 Return

The nth Fibonacci number.

=head3 FUNCTION C<fibonacci4>

Returns the nth Fibonacci number of order k.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=item C<k>

A non-negative integer.

=back

=head3 METHOD C<findMaximum>

Returns the largest value in an array of values.

=head4 Parameters

=over

=item C<a>

An array of values.

=item C<n>

The length of the array.

=back

=head4 Return

The largest value.

=head3 FUNCTION C<g>

Sample function to illustrate exceptions.

=head3 FUNCTION C<gamma>

Approximates Euler's constant.

=head4 Return

Gamma.

=head3 FUNCTION C<geometricSeriesSum1>

Returns the sum of the first n terms
of a geometric series in x.

=head4 Parameters

=over

=item C<x>

A value.

=item C<n>

The number of terms to be added.

=back

=head4 Return

The sum.

=head3 FUNCTION C<geometricSeriesSum2>

Returns the sum of the first n terms
of a geometric series in x.

=head4 Parameters

=over

=item C<x>

A value.

=item C<n>

The number of terms to be added.

=back

=head4 Return

The sum.

=head3 FUNCTION C<geometricSeriesSum3>

Returns the sum of the first n terms
of a geometric series in x.

=head4 Parameters

=over

=item C<x>

A value.

=item C<n>

The number of terms to be added.

=back

=head4 Return

The sum.

=head3 FUNCTION C<horner1>

Evaluates a polynomial in x.

=head4 Parameters

=over

=item C<a>

The coefficients of the polynomial.

=item C<n>

The degree of the polynomial.

=item C<x>

The value at which to evaluate the polynomial.

=back

=head4 Return

The value of the polynomial.

=head3 FUNCTION C<horner2>

Evaluates a polynomial in x.

=head4 Parameters

=over

=item C<a>

The coefficients of the polynomial.

=item C<n>

The degree of the polynomial.

=item C<x>

The value at which to evaluate the polynomial.

=back

=head4 Return

The value of the polynomial.

=head3 FUNCTION C<merge>

Merges (in place) two sorted subsequences of an array
into a single sorted subsequence.

=head4 Parameters

=over

=item C<array>

An array of values.

=item C<pos>

The start of the left subsequence.

=item C<m>

The number of elements in the left subsequence.

=item C<n>

The number of elements in the right subsequence.

=back

=head3 FUNCTION C<mergeSort>

Sorts (in place) a contiguous region in array of values.

=head4 Parameters

=over

=item C<array>

The array of values to be sorted.

=item C<i>

The position of the left-most element to be sorted.

=item C<n>

The length of the region to be sorted.

=back

=head3 FUNCTION C<one>

Sample function to illustrate parameter passing.

=head3 FUNCTION C<pi>

Approximates the value of pi.
Uses a Monte-carlo algorithm.

=head4 Parameters

=over

=item C<trials>

The number of trials to be done.

=back

=head4 Return

Pi.

=head3 FUNCTION C<power>

Returns x raised to the power n.

=head4 Parameters

=over

=item C<x>

A value.

=item C<n>

A non-negative integer.

=back

=head4 Return

x raised to the power n.

=head3 FUNCTION C<prefixSums>

Computes (in place) all the prefix sums
of an array of n values.

=head4 Parameters

=over

=item C<a>

An array of values.

=item C<n>

The length of the array.

=back

=head3 FUNCTION C<sum>

Returns the sum of the first n integers.

=head4 Parameters

=over

=item C<n>

A non-negative integer.

=back

=head4 Return

The sum.

=head3 FUNCTION C<three>

Sample function to illustrate parameter passing.

=head4 Parameters

=over

=item C<y>

A value.

=back

=head3 FUNCTION C<two>

Sample function to illustrate parameter passing.

=head4 Parameters

=over

=item C<y>

A value.

=back

=head3 FUNCTION C<typeset>

Finds the optimum way to typeset a justified paragraph.

=head4 Parameters

=over

=item C<l>

The lengths of the words in the paragraph.

=item C<D>

The length of a line.

=item C<s>

The length of the normal interword space.

=back

=cut

