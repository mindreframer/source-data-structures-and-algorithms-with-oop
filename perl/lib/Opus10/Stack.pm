#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:45 $
#   $RCSfile: Stack.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Stack.pm,v 1.2 2005/09/25 23:52:45 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Stack
# Abstract base class from which all stack classes are derived.
package Opus10::Stack;
use Opus10::Declarators;
use Opus10::Container;
our @ISA = qw(Opus10::Container);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this stack.
# @param self This stack.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
}

destructor qw(DESTROY);

# @method push
# Pushes the given item onto this stack.
# @param self This stack.
# @param item The item to push.
abstract_method qw(push);

# @method pop
# Pops and returns the top item of this stack.
# @param self This stack.
# @return The top item.
abstract_method qw(pop);

# @method getTop
# Returns the top item of this stack.
# @param self This stack.
# @return The top item.
abstract_method qw(getTop);
#}>a

use Opus10::Box;

# @function test
# Stack test function.
# @param stack The stack to test.
sub test
{
    my ($stack) = @_;
    printf "Stack test program.\n";
    for (my $i = 0; $i <= 5; ++$i)
    {
	$stack->push(box($i)) if !$stack->isFull();
    }
    printf "%s\n", $stack;
    printf "Using each\n";
    $stack->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj;
	}
    );
    printf "Using Iterator\n";
    my $iter = $stack->iter();
    while (defined(my $item = $iter->()))
    {
	printf "%s\n", $item;
    }
    printf "Top is %s\n", $stack->getTop();
    printf "Popping\n";
    while (!$stack->isEmpty())
    {
	printf "%s\n", $stack->pop();
    }
    $stack->push(box(2));
    $stack->push(box(4));
    $stack->push(box(6));
    printf "%s\n", $stack;
    printf "Purging\n";
    $stack->purge();
    printf "%s\n", $stack;
}

1;
__DATA__

=head1 MODULE C<Opus10::Stack>

=head2 CLASS C<Opus10::Stack>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

Abstract base class from which all stack classes are derived.

=head3 METHOD C<getTop>

Returns the top item of this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

The top item.

=head3 METHOD C<initialize>

Initializes this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head3 METHOD C<pop>

Pops and returns the top item of this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=back

=head4 Return

The top item.

=head3 METHOD C<push>

Pushes the given item onto this stack.

=head4 Parameters

=over

=item C<self>

This stack.

=item C<item>

The item to push.

=back

=head3 FUNCTION C<test>

Stack test function.

=head4 Parameters

=over

=item C<stack>

The stack to test.

=back

=cut

