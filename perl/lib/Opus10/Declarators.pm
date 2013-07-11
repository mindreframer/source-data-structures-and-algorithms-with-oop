#!/usr/bin/perl
#
#   Copyright (c) 2005 by Bruno R. Preiss, P.Eng.
#
#   $Author: brpreiss $
#   $Date: 2005/09/25 21:36:00 $
#   $RCSfile: Declarators.pm,v $
#   $Revision: 1.1 $
#
#   $Id: Declarators.pm,v 1.1 2005/09/25 21:36:00 brpreiss Exp $
#

use strict;

#{
# @package Opus10::Declarators
# Provides functions for declaring object methods.
# @export attr_reader
# @export attr_writer
# @export attr_accessor
# @export abstract_method
# @export alias_method
# @export delegate
# @export destructor
package Opus10::Declarators;
use Exporter;
our @ISA = qw(Exporter);

#}>head

our $VERSION = 1.00;

#{
# @function declareGetter
# Declares an attribute getter with the given attribute in the given class.
# The name of the getter is obtained by removing leading underscores
# from the attribute name, capitalizing the first letter,
# and then prepending the string "get".
# E.g., if the attribute name is "_size", the getter name is "getSize".
# @param attr The attribute name.
# @param class The class name.
sub declareGetter
{
    my ($attr, $class) = @_;
    my $name = $attr;
    $name =~ s/^_*(.)/get\U$1/;
    eval(<<"EOF"
    package ${class};
    sub ${name}
    {
	my (\$self) = \@_;
	return \$self->{$attr};
    }
EOF
    );
}

# @function declareSetter
# Declares an attribute setter with the given attribute in the given class.
# The name of the setter is obtained by removing leading underscores
# from the attribute name, capitalizing the first letter,
# and then prepending the string "set".
# E.g., if the attribute name is "_size", the setter name is "setSize".
# @param attr The attribute name.
# @param class The class name.
sub declareSetter
{
    my ($attr, $class) = @_;
    my $name = $attr;
    $name =~ s/^_*(.)/set\U$1/;
    eval(<<"EOF"
    package ${class};
    sub ${name}
    {
	my (\$self, \$value) = \@_;
	\$self->{$attr} = \$value;
    }
EOF
    );
}
#}>a

#{
our @EXPORT = qw(attr_reader attr_writer attr_accessor
    abstract_method alias_method delegate destructor);

# @function attr_reader
# Declares an attribute reader in the caller's class
# for given attribute name.
# @param attr The attribute name.
sub attr_reader
{
    my ($attr) = @_;
    my $class = caller;
    declareGetter($attr, $class);
}

# @function attr_writer
# Declares an attribute writer in the caller's class
# for given attribute name.
# @param attr The attribute name.
sub attr_writer
{
    my ($attr) = @_;
    my $class = caller;
    declareSetter($attr, $class);
}

# @function attr_accessor
# Declares an attribute accessor in the caller's class
# for given attribute name.
# @param attr The attribute name.
sub attr_accessor
{
    my ($attr) = @_;
    my $class = caller;
    declareGetter($attr, $class);
    declareSetter($attr, $class);
}
#}>b

#{
# @function abstract_method
# Declares an abstract method in the caller's class
# with the given name.
# @param name The method name.
sub abstract_method
{
    my ($name) = @_;
    my $class = caller;
    eval(<<"EOF"
    package ${class};
    use Carp;
    sub ${name}
    {
	my (\$self) = \@_;
	my \$class = ref(\$self);
	croak "Method $name not implemented in class \$class.";
    }
EOF
    );
}
#}>c

#{
# @function alias_method
# Declares an alias for the given method in the caller's class.
# @param name The alias.
# @param method The method.
sub alias_method
{
    no strict 'refs';
    my ($alias, $method) = @_;
    my $class = caller;
    *{"${class}::${alias}"} = *$method{CODE};
}
#}>d

# @function delegate
# Declares a method with the given name in the callers class
# that delegates to the given attribute.
# @param method The method name.
# @param attr The attribute name.
# @param method2 Another method name. Optional.
sub delegate
{
    my ($method, $attr, $method2) = @_;
    $method2 = $method2 || $method;
    my $class = caller;
    eval(<<"EOF"
    package ${class};
    sub ${method}
    {
	my (\$self, \@args) = \@_;
	return \$self->{$attr}->$method2(\@args);
    }
EOF
    );
}

# @function destructor
# Declares a destructor with the given name in the caller's class.
# @param name The destructor name.
sub destructor
{
    my ($name) = @_;
    my $class = caller;
    eval(<<"EOF"
    package ${class};
    use Carp;
    sub $name
    {
	my (\$self) = \@_;
	return if \$self->isDestroyed();
	for (my \$i = \$#ISA; \$i >= 0; --\$i)
	{
	    my \$name = \$ISA[\$i] . '::' . $name;
	    if (my \$method = \$self->can(\$name))
	    {
		\$self->\$method();
	    }
	}
    }
EOF
    );
}

1;
__DATA__

=head1 MODULE C<Opus10::Declarators>

=head2 PACKAGE C<Opus10::Declarators>

Provides functions for declaring object methods.

=head3 EXPORTS

=over

=item C<attr_reader>

=item C<attr_writer>

=item C<attr_accessor>

=item C<abstract_method>

=item C<alias_method>

=item C<delegate>

=item C<destructor>

=back

=head3 FUNCTION C<abstract_method>

Declares an abstract method in the caller's class
with the given name.

=head4 Parameters

=over

=item C<name>

The method name.

=back

=head3 FUNCTION C<alias_method>

Declares an alias for the given method in the caller's class.

=head4 Parameters

=over

=item C<name>

The alias.

=item C<method>

The method.

=back

=head3 FUNCTION C<attr_accessor>

Declares an attribute accessor in the caller's class
for given attribute name.

=head4 Parameters

=over

=item C<attr>

The attribute name.

=back

=head3 FUNCTION C<attr_reader>

Declares an attribute reader in the caller's class
for given attribute name.

=head4 Parameters

=over

=item C<attr>

The attribute name.

=back

=head3 FUNCTION C<attr_writer>

Declares an attribute writer in the caller's class
for given attribute name.

=head4 Parameters

=over

=item C<attr>

The attribute name.

=back

=head3 FUNCTION C<declareGetter>

Declares an attribute getter with the given attribute in the given class.
The name of the getter is obtained by removing leading underscores
from the attribute name, capitalizing the first letter,
and then prepending the string "get".
E.g., if the attribute name is "_size", the getter name is "getSize".

=head4 Parameters

=over

=item C<attr>

The attribute name.

=item C<class>

The class name.

=back

=head3 FUNCTION C<declareSetter>

Declares an attribute setter with the given attribute in the given class.
The name of the setter is obtained by removing leading underscores
from the attribute name, capitalizing the first letter,
and then prepending the string "set".
E.g., if the attribute name is "_size", the setter name is "setSize".

=head4 Parameters

=over

=item C<attr>

The attribute name.

=item C<class>

The class name.

=back

=head3 FUNCTION C<delegate>

Declares a method with the given name in the callers class
that delegates to the given attribute.

=head4 Parameters

=over

=item C<method>

The method name.

=item C<attr>

The attribute name.

=item C<method2>

Another method name. Optional.

=back

=head3 FUNCTION C<destructor>

Declares a destructor with the given name in the caller's class.

=head4 Parameters

=over

=item C<name>

The destructor name.

=back

=cut

