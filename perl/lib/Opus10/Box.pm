#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:00 $
#   $RCSfile: Box.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Box.pm,v 1.1 2005/09/25 21:36:00 brpreiss Exp $
#

use strict;

#{
# @package Opus10::Box
# Provides box and unbox functions.
# @export box.
# @export unbox.
package Opus10::Box;
use Carp;
use Exporter;
use Opus10::String;
use Opus10::Integer;
use Opus10::Float;
use Opus10::Array;
our @ISA = qw(Exporter);

#}>head

our $VERSION = 1.00;

use B 'svref_2object', 'SVf_POK', 'SVf_IOK', 'SVf_NOK', 'SVf_ROK';

# @function isString
# IsString predicate.
# @param value A scalar value.
# @return True if the given scalar value is a string.
sub isString
{
    my ($value) = @_;
    my $flags = svref_2object(\$value)->FLAGS;
    return $flags & SVf_POK;
}

# @function isInteger
# IsInteger predicate.
# @param value A scalar value.
# @return True if the given scalar value is an integer.
sub isInteger
{
    my ($value) = @_;
    my $flags = svref_2object(\$value)->FLAGS;
    return $flags & SVf_IOK;
}

# @method isFloat
# IsFloat predicate.
# @param value A scalar value.
# @return True if the given scalar value is a float.
sub isFloat
{
    my ($value) = @_;
    my $flags = svref_2object(\$value)->FLAGS;
    return $flags & SVf_NOK;
}

# @method isReference
# IsReference predicate.
# @param value A scalar value.
# @return True if the given scalar value is a reference.
sub isReference
{
    my ($value) = @_;
    my $flags = svref_2object(\$value)->FLAGS;
    return $flags & SVf_ROK;
}

#{
our @EXPORT = qw(box unbox);

# @function box
# Boxes the given value.
# @param value A value.
# @return A box that contains the given value.
sub box
{
    my ($value) = @_;
    if (ref($value) eq '') {
	if (isString($value)) {
	    use Opus10::String;
	    return Opus10::String->new($value);
	}
	elsif (isInteger($value)) {
	    use Opus10::Integer;
	    return Opus10::Integer->new($value);
	}
	elsif (isFloat($value)) {
	    use Opus10::Float;
	    return Opus10::Float->new($value);
	}
	else {
	    croak 'DomainError';
	}
    }
    elsif (ref($value) eq 'ARRAY') {
	my $length = @{$value};
	my $result = Opus10::Array->new($length);
	for (my $i = 0; $i < $length; ++$i) {
	    $result->setItem($i, ${$value}[$i]);
	}
	return $result;
    }
    else {
	croak 'DomainError';
    }
}
#}>c

#{
# @function unbox
# Unboxes the given box.
# @param box A box.
# @return The value in the given box.
sub unbox
{
    my ($box) = @_;
    return $box->getValue();
}
#}>d

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "Box test program.\n";
    foreach my $v ('test', 1, 1.1, [1,2,3])
    {
	my $b = box($v);
	printf "%s = %s\n", ref($b), $b;
    }
    return $status;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Box>

=head2 PACKAGE C<Opus10::Box>

Provides box and unbox functions.

=head3 EXPORTS

=over

=item C<box.>

=item C<unbox.>

=back

=head3 FUNCTION C<box>

Boxes the given value.

=head4 Parameters

=over

=item C<value>

A value.

=back

=head4 Return

A box that contains the given value.

=head3 METHOD C<isFloat>

IsFloat predicate.

=head4 Parameters

=over

=item C<value>

A scalar value.

=back

=head4 Return

True if the given scalar value is a float.

=head3 FUNCTION C<isInteger>

IsInteger predicate.

=head4 Parameters

=over

=item C<value>

A scalar value.

=back

=head4 Return

True if the given scalar value is an integer.

=head3 METHOD C<isReference>

IsReference predicate.

=head4 Parameters

=over

=item C<value>

A scalar value.

=back

=head4 Return

True if the given scalar value is a reference.

=head3 FUNCTION C<isString>

IsString predicate.

=head4 Parameters

=over

=item C<value>

A scalar value.

=back

=head4 Return

True if the given scalar value is a string.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 FUNCTION C<unbox>

Unboxes the given box.

=head4 Parameters

=over

=item C<box>

A box.

=back

=head4 Return

The value in the given box.

=cut

