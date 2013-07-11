#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:03 $
#   $RCSfile: Object.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Object.pm,v 1.1 2005/09/25 21:36:03 brpreiss Exp $
#

use strict;

#{
# @class Opus10::Object
# Base class from which all objects are derived.
package Opus10::Object;
use Tie::SecureHash;

#}>head

our $VERSION = 1.00;

#{
# @classmethod new
# Returns a new instance of the given class.
# @param class A class.
# @param args... Arguments passed to initialize method.
# @return An instance of the given class.
sub new
{
    my ($class, @args) = @_;
    my $self = Tie::SecureHash->new($class);
    $self->declare qw(__initialized __destroyed);
    $self->initialize(@args);
    return $self;
}

# @method initialize
# Initializes this object.
# @param self This object.
sub initialize
{
    my ($self) = @_;
    return if $self->isInitialized();
}

# @method DESTROY
# Destructor.
# @param self This object.
sub DESTROY
{
    my ($self) = @_;
    return if $self->isDestroyed();
    $self->Tie::SecureHash::DESTROY();
}

# @method isInitialized
# Sets a flag to indicate that the initialize method of the caller's class
# has been called on this object and returns true if the flag was already set.
# @param self This object.
sub isInitialized
{
    my ($self) = @_;
    my $class = caller;
    return $self->{__initialized}{$class}++;
}

# @method isDestroyed
# Sets a flag to indicate that the DESTROY method of the caller's class
# has been called on this object and returns true if the flag was already set.
# @param self This object.
sub isDestroyed
{
    my ($self) = @_;
    my $class = caller;
    return $self->{__destroyed}{$class}++;
}
#}>a

#{
# @method declare
# Declares the given attribute(s) in the caller's class.
# @param args A list of attribute names.
sub declare
{
    my ($self, @args) = @_;
    my ($caller, $file) = (caller)[0..1];
    for my $attr (@args)
    {
	tied(%$self)->_declare($attr, $caller, $file);
    }
}

# @method Tie::SecureHash::_declare
# Declares the given attribute in the given class.
# @param self This secure hash.
# @param attr The attribute name.
# @param class The class.
# @param file The file where the declaration is made.
sub Tie::SecureHash::_declare
{
    my ($self, $attr, $class, $file) = @_;
    my $entry = $self->_access(
	"${class}::${attr}", $class, $file);
}
#}>b

# @classmethod collectMethods
# Collects the names of the methods of the given class.
# @param class The name of the class.
# @param methods Hash of methods.
sub collectMethods
{
    my ($class, $methods) = @_;
    no strict 'refs';

    my $sym = \%{"${class}::"};

    foreach my $key (keys(%{$sym}))
    {
	my $glob = ${$sym}{$key};
	if (defined(&{$glob}))
	{
	    if (!defined(${$methods}{$key}))
	    {
		${$methods}{$key} = "${class}::${key}";
	    }
	}
    }
    if (defined(@{"${class}::ISA"}))
    {
	for (my $i = 0; $i < @{"${class}::ISA"}; ++$i)
	{
	    my $base = ${"${class}::ISA"}[$i];
	    &collectMethods($base, $methods);
	}
    }
}

# @classmethod dump
# Prints out the names of the statics and methods of the given class.
# @param class The name of a class.
sub dump
{
    my ($class) = @_;
    my $methods = {};

    &collectMethods($class, $methods);

    printf "%s\n", $class;
    printf "{\n";
    foreach my $key (sort(keys(%{$methods})))
    {
	printf "    %-16s -> %s\n", $key, ${$methods}{$key};
    }
    printf "}\n";
}

1;
__DATA__

=head1 MODULE C<Opus10::Object>

=head2 CLASS C<Opus10::Object>

Base class from which all objects are derived.

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head3 METHOD C<Tie::SecureHash::_declare>

Declares the given attribute in the given class.

=head4 Parameters

=over

=item C<self>

This secure hash.

=item C<attr>

The attribute name.

=item C<class>

The class.

=item C<file>

The file where the declaration is made.

=back

=head3 CLASS METHOD C<collectMethods>

Collects the names of the methods of the given class.

=head4 Parameters

=over

=item C<class>

The name of the class.

=item C<methods>

Hash of methods.

=back

=head3 METHOD C<declare>

Declares the given attribute(s) in the caller's class.

=head4 Parameters

=over

=item C<args>

A list of attribute names.

=back

=head3 CLASS METHOD C<dump>

Prints out the names of the statics and methods of the given class.

=head4 Parameters

=over

=item C<class>

The name of a class.

=back

=head3 METHOD C<initialize>

Initializes this object.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head3 METHOD C<isDestroyed>

Sets a flag to indicate that the DESTROY method of the caller's class
has been called on this object and returns true if the flag was already set.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head3 METHOD C<isInitialized>

Sets a flag to indicate that the initialize method of the caller's class
has been called on this object and returns true if the flag was already set.

=head4 Parameters

=over

=item C<self>

This object.

=back

=head3 CLASS METHOD C<new>

Returns a new instance of the given class.

=head4 Parameters

=over

=item C<class>

A class.

=item C<args...>

Arguments passed to initialize method.

=back

=head4 Return

An instance of the given class.

=cut

