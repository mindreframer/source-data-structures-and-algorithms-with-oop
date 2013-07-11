#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:40 $
#   $RCSfile: Container.pm,v $
#   $Revision: 1.2 $
#
#   $Id: Container.pm,v 1.2 2005/09/25 23:52:40 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Container
# Abstract base class from which all container classes are derived.
# @attr _count The number of items in this container.
package Opus10::Container;
use Carp;
use Opus10::Declarators;
use Opus10::Comparable;
our @ISA = qw(Opus10::Comparable);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this container.
# @param self This container.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_count);
    $self->{_count} = 0;
}

destructor qw(DESTROY);

attr_reader qw(_count);

# @method purge
# Purges this container.
# @param self This container.
sub purge
{
    my ($self) = @_;
    $self->{_count} = 0;
}

# @method isEmpty
# IsEmpty predicate.
# @param self This container.
# @return True of this container is empty; false otherwise.
sub isEmpty
{
    my ($self) = @_;
    return $self->getCount() == 0;
}

# @method isFull
# IsFull predicate.
# @param self This container.
# @return False always.
sub isFull
{
    my ($self) = @_;
    return 0;
}
#}>a

#{
# @method iter
# Returns an iterator that enumerates the elements of this container.
# @param self This container.
# @return An iterator.
sub iter
{
    my ($self) = @_;
    my @elements = ();
    $self->each(
	sub
	{
	    my ($obj) = @_;
	    push(@elements, $obj);
	}
    );
    return
	sub
	{
	    my $result = undef;
	    $result = shift(@elements) if (@elements > 0);
	    return $result;
	};
}
#}>b

#{
# @method each
# Invokes the given visitor function for each item in this container.
# Implemented using an iterator.
# @param self This container.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    my $iter = $self->iter();
    while (defined(my $item = $iter->()))
    {
	$visitor->($item);
    }
}
#}>c

#{
# @method toString
# Returns a textual representation of this container.
# @param self This container.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    $self->each(
	sub
	{
	    my ($obj) = @_;
	    $s .= ', ' if length($s) > 0;
	    $s .= defined($obj) ? $obj : 'undef';
	}
    );
    return ref($self) . '{' . $s . '}';
}
#}>d

#{
# @method hash
# Returns a hash value for this container.
# @param self This container.
# @return An integer.
sub hash
{
    my ($self) = @_;
    my $result = 0;
    $self->each(
	sub
	{
	    my ($obj) = @_;
	    $result += $obj->hash();
	}
    );
    #$result += hash(ref($self))
    return $result;
}
#}>e

# @class Opus10::Container::TestContainer
# A test container.
package Opus10::Container::TestContainer;

our @ISA = qw(Opus10::Container);
our $VERSION = 1.00;

# @method each
# A dummy method to prevent infinite recursion.
sub each
{
}

# @class Opus10::Container
# Abstract base class from which all container classes are derived.
package Opus10::Container;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    print "Container test program.\n";
    my $container = Opus10::Container::TestContainer->new();
    printf "%s\n", $container;
    printf "hash=0x%0x\n", $container->hash();
    return 0;
}

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::Container>

=head2 CLASS C<Opus10::Container>

=head3 Base Classes

=over

=item C<Opus10::Comparable>

=back

Abstract base class from which all container classes are derived.

=head3 ATTRIBUTES

=over

=item C<_count>

The number of items in this container.

=back

=head3 METHOD C<each>

Invokes the given visitor function for each item in this container.
Implemented using an iterator.

=head4 Parameters

=over

=item C<self>

This container.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<hash>

Returns a hash value for this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head4 Return

An integer.

=head3 METHOD C<initialize>

Initializes this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head4 Return

True of this container is empty; false otherwise.

=head3 METHOD C<isFull>

IsFull predicate.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head4 Return

False always.

=head3 METHOD C<iter>

Returns an iterator that enumerates the elements of this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head4 Return

An iterator.

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<purge>

Purges this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head3 METHOD C<toString>

Returns a textual representation of this container.

=head4 Parameters

=over

=item C<self>

This container.

=back

=head4 Return

A string.

=head2 CLASS C<Opus10::Container::TestContainer>

=head3 Base Classes

=over

=item C<Opus10::Container>

=back

A test container.

=head3 METHOD C<each>

A dummy method to prevent infinite recursion.

=cut

