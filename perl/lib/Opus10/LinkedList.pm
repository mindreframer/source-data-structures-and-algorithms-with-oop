#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 23:52:42 $
#   $RCSfile: LinkedList.pm,v $
#   $Revision: 1.2 $
#
#   $Id: LinkedList.pm,v 1.2 2005/09/25 23:52:42 brpreiss Exp $
#

use strict;

#{
# @class Opus10::LinkedList::Element
# Represents an element of a linked list.
# @attr _impl The list to which this element belongs.
# @attr _datum The item in this list element.
# @attr _succ The next element of the list.
package Opus10::LinkedList::Element;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @classmethod initialize
# Initializes this list element with the given values.
# @param class The list element class.
# @param list The list to which this element belongs.
# @param datum The item in this list element.
sub initialize
{
    my ($self, $impl, $datum, $succ) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_impl _datum _succ);
    $self->{_impl} = $impl;
    $self->{_datum} = $datum;
    $self->{_succ} = $succ;
}

destructor qw(DESTROY);

attr_accessor qw(_impl);
attr_accessor qw(_datum);
attr_accessor qw(_succ);
#}>a

#{
# @method insertAfter
# Inserts the given item in the list after this list element.
# @param self This list element.
# @param item The item to insert.
sub insertAfter
{
    my ($self, $item) = @_;
    my $impl = $self->{_impl};
    my $succ = $self->{_succ};
    $self->{_succ} = Opus10::LinkedList::Element->new(
	$impl, $item, $succ);
    if ($self->{_impl}->getTail() == $self)
    {
	my $succ = $self->{_succ};
	$self->{_impl}->setTail($succ);
    }
}

# @method insertBefore
# Inserts the given item in the list before this list element.
# @param self This list element.
# @param item The item to insert.
sub insertBefore
{
    my ($self, $item) = @_;
    my $impl = $self->{_impl};
    my $tmp = Opus10::LinkedList::Element->new(
	$impl, $item, $self);
    if ($self->{_impl}->getHead() == $self)
    {
	$self->{_impl}->setHead($tmp);
    }
    else
    {
	my $prevPtr = $self->{_impl}->getHead();
	while (defined($prevPtr) && $prevPtr->getSucc() != $self)
	{
	    $prevPtr = $prevPtr->getSucc();
	}
	$prevPtr->setSucc($tmp);
    }
}
#}>j

# @method extract
# Extracts this linked list element from the list.
# @param self This list element.
sub extract
{
    my ($self) = @_;
    my $prevPtr = undef;
    if ($self->{_impl}->getHead() == $self)
    {
	$self->{_impl}->setHead($self->{_succ});
    }
    else
    {
	$prevPtr = $self->{_impl}->getHead();
	while (defined($prevPtr) && $prevPtr->getSucc() != $self)
	{
	    $prevPtr = $prevPtr->getSucc();
	}
	croak 'InternalError' if !defined($prevPtr);
	$prevPtr->setSucc($self->{_succ});
    }
    if ($self->{_impl}->getTail() == $self)
    {
	$self->{_impl}->setTail($prevPtr);
    }
}

#{
# @class Opus10::LinkedList::Impl
# A linked list.
# @attr _head The head of the linked list.
# @attr _tail The tail of the linked list.
package Opus10::LinkedList::Impl;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this linked list.
# @param self This linked list.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_head _tail);
    $self->{_head} = undef;
    $self->{_tail} = undef;
}

destructor qw(DESTROY);
#}>b

#{
# @method purge
# Purges this linked list.
# @param self This linked list.
sub purge
{
    my ($self) = @_;
    $self->{_head} = undef;
    $self->{_tail} = undef;
}

# @method unlink
# Unlinks this linked list.
# @param self This linked list.
sub unlink
{
    my ($self) = @_;
    my $ptr = $self->{_head};
    while (defined ($ptr))
    {
	my $tmp = $ptr;
	$ptr = $ptr->getSucc();
	$tmp->setImpl(undef);
	$tmp->setSucc(undef);
    }
    $self->{_head} = undef;
    $self->{_tail} = undef;
}
#}>c

#{
attr_accessor qw(_head);
attr_accessor qw(_tail);

# @method isEmpty
# IsEmpty predicate.
# @param self This linked list.
# @return True if this linked list is empty; false otherwise.
sub isEmpty
{
    my ($self) = @_;
    return !defined($self->{_head});
}
#}>d

#{
# @method getFirst
# Returns the first item in this linked list.
# @param self This linked list.
# @return The first item in this linked list.
sub getFirst
{
    my ($self) = @_;
    croak 'ContainerEmpty' if !defined($self->{_head});
    return $self->{_head}->getDatum();
}

# @method getLast
# Returns the last item in this linked list.
# @param self This linked list.
# @return The last item in this linked list.
sub getLast
{
    my ($self) = @_;
    croak 'ContainerEmpty' if !defined($self->{_tail});
    return $self->{_tail}->getDatum();
}
#}>e

#{
# @method prepend
# Prepends the given item to this linked list.
# @param self This linked list.
# @param item The item to prepend.
sub prepend
{
    my ($self, $item) = @_;
    my $tmp = Opus10::LinkedList::Element->new(
	$self, $item, $self->getHead());
    $self->{_tail} = $tmp if !defined($self->{_head});
    $self->{_head} = $tmp;
}
#}>f

#{
# @method append
# Appends the given item to this linked list.
# @param self This linked list.
# @param item The item to append.
sub append
{
    my ($self, $item) = @_;
    my $tmp = Opus10::LinkedList::Element->new(
	$self, $item, undef);
    if (!defined($self->{_head}))
    {
	$self->{_head} = $tmp;
    }
    else
    {
	$self->{_tail}->setSucc($tmp);
    }
    $self->{_tail} = $tmp;
}
#}>g

#{
# @method clone
# Returns a clone of this linked list.
# @param self This linked list.
# @return A clone of this linked list.
sub clone
{
    my ($self) = @_;
    my $result = Opus10::LinkedList->new();
    my $ptr = $self->{_head};
    while (defined($ptr))
    {
	$result->append($ptr->getDatum());
	$ptr = $ptr->getSucc();
    }
    return $result;
}
#}>h

#{
# @method extract
# Extracts the given item from this linked list.
# @param self This linked list.
# @param item The item to extract.
sub extract
{
    my ($self, $item) = @_;
    my $ptr = $self->{_head};
    my $prevPtr = undef;
    while (defined($ptr))
    {
#	last if ($ptr->getDatum() == $item);
	last if ($ptr->getDatum()->is($item));
	$prevPtr = $ptr;
	$ptr = $ptr->getSucc();
    }
    croak 'ArgumentError' if !defined($ptr);
    if ($ptr == $self->{_head})
    {
	$self->{_head} = $ptr->getSucc();
    }
    else
    {
	$prevPtr->setSucc($ptr->getSucc());
    }
    if ($ptr == $self->{_tail})
    {
	$self->{_tail} = $prevPtr;
    }
}
#}>i

#{
# @method each
# Calls the given visitor function for each item in this linked list.
# @param self This linked list.
# @param visitor A visitor function.
sub each
{
    my ($self, $visitor) = @_;
    my $ptr = $self->{_head};
    while (defined($ptr))
    {
	$visitor->($ptr->getDatum());
	$ptr = $ptr->getSucc();
    }
}
#}>k

# @method toString
# Returns a textual representation of this linked list.
# @param self This linked list.
# @return A string.
sub toString
{
    my ($self) = @_;
    my $s = '';
    my $ptr = $self->{_head};
    while (defined($ptr))
    {
	if (defined($ptr->getDatum()))
	{
	    $s .= $ptr->getDatum();
	}
	else
	{
	    $s .= 'undef';
	}
	$s .= ', ' if defined($ptr->getSucc());
	$ptr = $ptr->getSucc();
    }
    return $s;
}

# Overload various operators.
use overload
    '""' => qw(toString),
    fallback => 1;

#{
# @class Opus10::LinkedList
# A linked list.
# @attr _head The head of the linked list.
# @attr _tail The tail of the linked list.
package Opus10::LinkedList;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

#}>head

#{

our $VERSION = 1.00;

#{
# @method initialize
# Initializes this linked list.
# @param self This linked list.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_impl);
    $self->{_impl} = Opus10::LinkedList::Impl->new();
}

# @method DESTROY
# Destructor.
# @param self This linked list.
sub DESTROY
{
    my ($self) = @_;
    return if $self->isDestroyed();
    $self->{_impl}->unlink();
    $self->SUPER::DESTROY();
}
#}>l

#{
delegate qw(purge _impl);
delegate qw(getHead _impl);
delegate qw(getTail _impl);
delegate qw(isEmpty _impl);
delegate qw(getFirst _impl);
delegate qw(getLast _impl);
delegate qw(prepend _impl);
delegate qw(append _impl);
delegate qw(extract _impl);
delegate qw(each _impl);
#}>m

#{
# @method clone
# Returns a clone of this linked list.
# @param self This linked list.
# @return A clone of this linked list.
sub clone
{
    my ($self) = @_;
    my $result = Opus10::LinkedList->new();
    my $ptr = $self->{_impl}->getHead();
    while (defined($ptr))
    {
	$result->append($ptr->getDatum());
	$ptr = $ptr->getSucc();
    }
    return $result;
}
#}>n

# @method toString
# Returns a textual representation of this linked list.
# @param self This linked list.
# @return A string.
sub toString
{
    my ($self) = @_;
    return ref($self) . '{' . $self->{_impl} . '}';
}

# Overload various operators.
use overload
    '""' => qw(toString),
    fallback => 1;

# @function main
# Main program.
# @param args Command-line arguments.
# @return Zero on success; non-zero on failure.
sub main
{
    my @args = @_;
    my $status = 0;
    print "LinkedList test program.\n";
    my $l1 = Opus10::LinkedList->new();
    $l1->append(57);
    printf "%s\n", $l1;
    $l1->append('hello');
    printf "%s\n", $l1;
    $l1->append(undef);
    printf "%s\n", $l1;
    printf "isEmpty returns %d\n", $l1->isEmpty();
    printf "Using each\n";
    $l1->each(
	sub
	{
	    my ($obj) = @_;
	    printf "%s\n", $obj ? $obj : 'undef';
	}
    );
    $l1->purge();
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

=head1 MODULE C<Opus10::LinkedList>

=head2 CLASS C<Opus10::LinkedList>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

A linked list.

=head3 ATTRIBUTES

=over

=item C<_head>

The head of the linked list.

=item C<_tail>

The tail of the linked list.

=back

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head3 METHOD C<clone>

Returns a clone of this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

A clone of this linked list.

=head3 METHOD C<initialize>

Initializes this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head3 FUNCTION C<main>

Main program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

Zero on success; non-zero on failure.

=head3 METHOD C<toString>

Returns a textual representation of this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

A string.

=head2 CLASS C<Opus10::LinkedList::Element>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

Represents an element of a linked list.

=head3 ATTRIBUTES

=over

=item C<_datum>

The item in this list element.

=item C<_impl>

The list to which this element belongs.

=item C<_succ>

The next element of the list.

=back

=head3 METHOD C<extract>

Extracts this linked list element from the list.

=head4 Parameters

=over

=item C<self>

This list element.

=back

=head3 CLASS METHOD C<initialize>

Initializes this list element with the given values.

=head4 Parameters

=over

=item C<class>

The list element class.

=item C<list>

The list to which this element belongs.

=item C<datum>

The item in this list element.

=back

=head3 METHOD C<insertAfter>

Inserts the given item in the list after this list element.

=head4 Parameters

=over

=item C<self>

This list element.

=item C<item>

The item to insert.

=back

=head3 METHOD C<insertBefore>

Inserts the given item in the list before this list element.

=head4 Parameters

=over

=item C<self>

This list element.

=item C<item>

The item to insert.

=back

=head2 CLASS C<Opus10::LinkedList::Impl>

=head3 Base Classes

=over

=item C<Opus10::Object>

=back

A linked list.

=head3 ATTRIBUTES

=over

=item C<_head>

The head of the linked list.

=item C<_tail>

The tail of the linked list.

=back

=head3 METHOD C<append>

Appends the given item to this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=item C<item>

The item to append.

=back

=head3 METHOD C<clone>

Returns a clone of this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

A clone of this linked list.

=head3 METHOD C<each>

Calls the given visitor function for each item in this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=item C<visitor>

A visitor function.

=back

=head3 METHOD C<extract>

Extracts the given item from this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=item C<item>

The item to extract.

=back

=head3 METHOD C<getFirst>

Returns the first item in this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

The first item in this linked list.

=head3 METHOD C<getLast>

Returns the last item in this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

The last item in this linked list.

=head3 METHOD C<initialize>

Initializes this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head3 METHOD C<isEmpty>

IsEmpty predicate.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

True if this linked list is empty; false otherwise.

=head3 METHOD C<prepend>

Prepends the given item to this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=item C<item>

The item to prepend.

=back

=head3 METHOD C<purge>

Purges this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head3 METHOD C<toString>

Returns a textual representation of this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=head4 Return

A string.

=head3 METHOD C<unlink>

Unlinks this linked list.

=head4 Parameters

=over

=item C<self>

This linked list.

=back

=cut

