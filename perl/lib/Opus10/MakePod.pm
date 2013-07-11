#!/usr/bin/perl

use strict;

# @package Opus10::MakePod::Attribute
# Represents the documentation for an attribute.
# @attr _name The name of the attribute.
# @attr _type The type of the attribute ('attr' or 'param')
package Opus10::MakePod::Attribute;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

# @method initialize
# Initializes this attribute with the given name, type and text.
# @param self This attribute.
# @param name The name.
# @param type Either 'attr' or 'param'.
# @param text The documentation text.
sub initialize
{
    my ($self, $name, $type, $text) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_name _type _text);
    $self->{_name} = $name;
    $self->{_type} = $type;
    $self->{_text} = $text;
}

# @method DESTROY
# Destructor.
# @param self This attribute.
destructor qw(DESTROY);

# @method emit
# Emits the documentation for this attribute on the given output file.
# @param self This attribute.
# @param FILE The output file.
sub emit
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    printf FILE "=item C<%s>\n", $self->{_name};
    printf FILE "\n";
    printf FILE "%s", $self->{_text};
    printf FILE "\n";
}

# @package Opus10::MakePod::Function
# Represents the documentation for a function.
# @attr _name The name of the function.
# @attr _type The type of the function ('function', 'classmethod' or 'method').
# @attr _text The documentation text.
# @attr _parameters The parameters of the function.
# @attr _return The return of the function.
package Opus10::MakePod::Function;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

# @method initialize
# Initializes this function with the given name, type and text.
# @param self This function.
# @param name The name.
# @param type Either 'function', 'classmethod' or 'method'.
# @param text The documentation text.
sub initialize
{
    my ($self, $name, $type, $text) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_name _type _text _parameters _return);
    $self->{_name} = $name;
    $self->{_type} = $type;
    $self->{_text} = $text;
    @{$self->{_parameters}} = ();
    $self->{_return} = undef;
}

# @method DESTROY
# Destructor.
# @param self This function.
destructor qw(DESTROY);

# @method getName
# Returns the name of this function.
# @param self This function.
# @return The name of this function.
attr_reader qw(_name);

# @method addParameter
# Adds the given parameter to this function.
# @param self This function.
# @param parameter The parameter.
sub addParameter
{
    my ($self, $parameter) = @_;
    push(@{$self->{_parameters}}, $parameter);
}

# @method addReturn
# Adds the given return documentation to this function.
# @param self This function.
# @param text The documentation text.
sub addReturn
{
    my ($self, $text) = @_;
    $self->{_return} = $text
}

# @method emitTop
# Emits the top documentation for this function on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitTop
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    if ($self->{_type} eq 'function')
    {
	printf FILE "=head3 FUNCTION C<%s>\n", $self->{_name};
	printf FILE "\n";
    }
    elsif ($self->{_type} eq 'classmethod')
    {
	printf FILE "=head3 CLASS METHOD C<%s>\n", $self->{_name};
	printf FILE "\n";
    }
    elsif ($self->{_type} eq 'method')
    {
	printf FILE "=head3 METHOD C<%s>\n", $self->{_name};
	printf FILE "\n";
    }
    printf FILE "%s", $self->{_text};
    printf FILE "\n";
}

# @method emitBottom
# Emits the bottom documentation for this function on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitBottom
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
}

# @method emitParameters
# Emits the parameter documentation for this function on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitParameters
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    if (@{$self->{_parameters}} > 0)
    {
	printf FILE "=head4 Parameters\n";
	printf FILE "\n";
	printf FILE "=over\n";
	printf FILE "\n";
	for (my $i = 0; $i < @{$self->{_parameters}}; ++$i)
	{
	    ${$self->{_parameters}}[$i]->emit(*FILE);
	}
	printf FILE "=back\n";
	printf FILE "\n";
    }
}

# @method emitReturn
# Emits the return documentation for htis function on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitReturn
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    if (defined($self->{_return}))
    {
	printf FILE "=head4 Return\n";
	printf FILE "\n";
	printf FILE "%s", $self->{_return};
	printf FILE "\n";
    }
}

# @method emit
# Emits the documentation for this function on the given output file.
# @param self This package.
# @param FILE The output file.
sub emit
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    $self->emitTop(*FILE);
    $self->emitParameters(*FILE);
    $self->emitReturn(*FILE);
    $self->emitBottom(*FILE);
}

# @package Opus10::MakePod::Package
# Represents the documentation for a package.
# @attr _name The name of the package.
# @attr _type The type of the package ('package' or 'class').
# @attr _text The documentation text.
# @attr _attributes The attributes of the package.
# @attr _exports The symbols exported from the package.
# @attr _functions The functions in this package.
# @attr _isa The base classes of this package.
package Opus10::MakePod::Package;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

# @method initialize
# Initializes this package with the given name, type and text.
# @param self This package.
# @param name The name.
# @param type Either 'package' or 'class'.
# @param text The documentation text.
sub initialize
{
    my ($self, $name, $type, $text) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_name _type _text _attributes _exports _functions _isa);
    $self->{_name} = $name;
    $self->{_type} = $type;
    $self->{_text} = $text;
    %{$self->{_attributes}} = ();
    @{$self->{_exports}} = ();
    %{$self->{_functions}} = ();
    @{$self->{_isa}} = ();
}

# @method DESTROY
# Destructor.
# @param self This package.
destructor qw(DESTROY);

# @method getName
# Returns the name of this package.
# @param self This package.
# @return The name of this package.
attr_reader qw(_name);

# @method addAttribute
# Adds the given attribute to this package.
# @param self This package.
# @param name The name of the attribute.
# @param attribute The attribute.
sub addAttribute
{
    my ($self, $name, $attribute) = @_;
    ${$self->{_attributes}}{$name} = $attribute;
}

# @method addExport
# Adds the given export to this package.
# @param self This package.
# @param name The name of the export.
sub addExport
{
    my ($self, $name) = @_;
    push(@{$self->{_exports}}, $name);
}

# @method addFunction
# Adds the given function to this package.
# @param self This package.
# @param name The name of the function.
# @param function The function.
sub addFunction
{
    my ($self, $name, $function) = @_;
    ${$self->{_functions}}{$name} = $function;
}

# @method setBases
# Sets the bases classes of this package.
# @param self This package.
# @param bases The base clases.
sub setBases
{
    my ($self, $bases) = @_;
    foreach my $base (split(/\s+/, $bases))
    {
	push(@{$self->{_isa}}, $base);
    }
}

# @method emitTop
# Emits the top documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emitTop
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    if ($self->{_type} eq 'class')
    {
	printf FILE "=head2 CLASS C<%s>\n", $self->{_name};
	printf FILE "\n";
	if (@{$self->{_isa}} > 0)
	{
	    printf FILE "=head3 Base Classes\n", $self->{_name};
	    printf FILE "\n";
	    printf FILE "=over\n";
	    printf FILE "\n";
	    for (my $i = 0; $i < @{$self->{_isa}}; ++$i)
	    {
		printf FILE "=item C<%s>\n", ${$self->{_isa}}[$i];
		printf FILE "\n";
	    }
	    printf FILE "=back\n";
	    printf FILE "\n";
	}
    }
    else
    {
	printf FILE "=head2 PACKAGE C<%s>\n", $self->{_name};
	printf FILE "\n";
    }
    printf FILE "%s", $self->{_text};
    printf FILE "\n";
}

# @method emitBottom
# Emits the bottom documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emitBottom
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
}

# @method emitAttributes
# Emits the attribute documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emitAttributes
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    my @keys = sort(keys(%{$self->{_attributes}}));
    if (@keys > 0)
    {
	printf FILE "=head3 ATTRIBUTES\n";
	printf FILE "\n";
	printf FILE "=over\n";
	printf FILE "\n";
	foreach my $name (@keys)
	{
	    my $attribute = ${$self->{_attributes}}{$name};
	    $attribute->emit(*FILE);
	}
	printf FILE "=back\n";
	printf FILE "\n";
    }
}

# @method emitExports
# Emits the export documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emitExports
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    if (@{$self->{_exports}} > 0)
    {
	printf FILE "=head3 EXPORTS\n";
	printf FILE "\n";
	printf FILE "=over\n";
	printf FILE "\n";
	foreach my $name (@{$self->{_exports}})
	{
	    printf FILE "=item C<%s>\n", $name;
	    printf FILE "\n";
	}
	printf FILE "=back\n";
	printf FILE "\n";
    }
}

# @method emitFunctions
# Emits the function documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emitFunctions
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    my @keys = sort(keys(%{$self->{_functions}}));
    if (@keys > 0)
    {
	foreach my $name (@keys)
	{
	    ${$self->{_functions}}{$name}->emit(*FILE);
	}
    }
}

# @method emit
# Emits the documentation for this package on the given output file.
# @param self This package.
# @param FILE The output file.
sub emit
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    $self->emitTop(*FILE);
    $self->emitAttributes(*FILE);
    $self->emitExports(*FILE);
    $self->emitFunctions(*FILE);
    $self->emitBottom(*FILE);
}

# @package Opus10::MakePod::Module
# Represents the documentation for a module.
# @attr _name The name of the module.
# @attr _file The file of the module.
# @attr _packages The packages of the module.
# @attr _currentPackage The current package.
# @attr _currentFunction The current function.
package Opus10::MakePod::Module;
use Carp;
use Opus10::Declarators;
use Opus10::Object;
our @ISA = qw(Opus10::Object);

# @method initialize
# Initializes this module with the given name.
# @param self This module.
# @param name The name.
sub initialize
{
    my ($self, $name) = @_;
    return if $self->isInitialized();
    $self->SUPER::initialize();
    $self->declare qw(_name _file _packages _currentPackage _currentFunction);
    $self->{_name} = $name;
    %{$self->{_packages}} = ();
    $self->{_currentPackage} = undef;
    $self->{_currentFunction} = undef;
}

# @method DESTROY
# Destructor.
# @param self This module.
destructor qw(DESTROY);

# @method load
# Loads this module.
# Searches for the file that contains the definition of this module
# and then calls the parse method to parse the file.
# @param self This module.
# @return Zero on failure; non-zero on success.
sub load
{
    my ($self) = @_;
    my $file = $self->{_name};
    $file =~ s/::/\//ig;
    $file .= '.pm';
    foreach my $dir (split(/:/, $ENV{'PERL5LIB'}))
    {
	my $path = $dir . '/' . $file;
	if (-e $path)
	{
	    $self->{_file} = $path;
	    return $self->parse();
	}
    }
    return 0;
}

# @method parseDirective
# Parses the given documentation directive.
# @param self This module.
# @param directive The documentation directive.
# @return Zero on failure; Non-zero on success.
sub parseDirective
{
    my ($self, $directive) = @_;
    my $result = 1;
    if ($directive =~ /^#\s+\@(package|class)\s+(\S+)\s+((.|\n)*)/)
    {
	my $type = $1;
	my $name = $2;
	my $text = $3;
	if (!defined(${$self->{_packages}}{$name}))
	{
	    ${$self->{_packages}}{$name} = 
		Opus10::MakePod::Package->new($name, $type, $text);
	}
	$self->{_currentPackage} = ${$self->{_packages}}{$name};
	$self->{_currentFunction} = undef;
    }
    elsif ($directive =~ /^#\s+\@attr\s+(\S+)\s+((.|\n)*)/)
    {
	my $name = $1;
	my $text = $2;
	if (!defined($self->{_currentPackage}))
	{
	    printf STDERR "Malformed mark-up(1): %s\n", $directive;
	    $result = 0;
	    return $result;
	}
	my $attribute = Opus10::MakePod::Attribute->new($name, 'attr', $text);
	$self->{_currentPackage}->addAttribute($name, $attribute);
    }
    elsif ($directive =~ /^#\s+\@export\s+(\S+)\s+/)
    {
	my $name = $1;
	if (!defined($self->{_currentPackage}))
	{
	    printf STDERR "Malformed mark-up(2): %s\n", $directive;
	    $result = 0;
	    return $result;
	}
	$self->{_currentPackage}->addExport($name);
    }
    elsif ($directive =~
	/^#\s+\@(function|classmethod|method)\s+(\S+)\s+((.|\n)*)/)
    {
	my $type = $1;
	my $name = $2;
	my $text = $3;
	if (!defined($self->{_currentPackage}))
	{
	    printf STDERR "Malformed mark-up(3): %s\n", $directive;
	    $result = 0;
	    return $result;
	}
	my $function = Opus10::MakePod::Function->new($name, $type, $text);
	$self->{_currentFunction} = $function;
	$self->{_currentPackage}->addFunction($name, $function);
    }
    elsif ($directive =~ /^#\s+\@param\s+(\S+)\s+((.|\n)*)/)
    {
	my $name = $1;
	my $text = $2;
	if (!defined($self->{_currentFunction}))
	{
	    printf STDERR "Malformed mark-up(4): %s\n", $directive;
	    $result = 0;
	    return $result;
	}
	my $attribute = Opus10::MakePod::Attribute->new($name, 'param', $text);
	$self->{_currentFunction}->addParameter($attribute);
    }
    elsif ($directive =~ /^#\s+\@return\s+((.|\n)*)/)
    {
	my $text = $1;
	if (!defined($self->{_currentFunction}))
	{
	    printf STDERR "Malformed mark-up(5): %s\n", $directive;
	    $result = 0;
	    return $result;
	}
	$self->{_currentFunction}->addReturn($text);
    }
    elsif ($directive =~ /^#\s+\@/)
    {
	printf STDERR "Malformed mark-up(6): %s\n", $directive;
	$result = 0;
	return $result;
    }
    return $result;
}

# @method parse
# Parses this module.
# Looks for comments that contain documentation directives.
# Collects and then processes the directives.
# @param self This module.
# @return Zero on failure; non-zero on success;
sub parse
{
    my ($self) = @_;
    my $result = 1;
    my $file = $self->{_file};
    if (!open (PERL, "<$file"))
    {
	printf STDERR "Can't open %s: %s\n", $file, $!;
	$result = 0;
    }
    else
    {
	my $currentDirective = undef;
	while (<PERL>)
	{
	    if (/^#\s+@/)
	    {
		my $text = $_;
		if (defined($currentDirective))
		{
		    if (!$self->parseDirective($currentDirective))
		    {
			$result = 0;
			last;
		    }
		    $currentDirective = $text;
		}
		else
		{
		    $currentDirective = $text;
		}
	    }
	    elsif (/^#\s+/)
	    {
		my $text = $_;
		$text =~ s/^#\s+//;
		if (defined($currentDirective))
		{
		    $currentDirective .= $text;
		}
	    }
	    else
	    {
		if (defined($currentDirective))
		{
		    if (!$self->parseDirective($currentDirective))
		    {
			$result = 0;
			last;
		    }
		    $currentDirective = undef;
		}
		last if /^__DATA__/;
		if (/^our \@ISA = qw\((.*)\);/)
		{
		    my $bases = $1;
		    if (!defined($self->{_currentPackage}))
		    {
			printf STDERR "Unexpected ISA\n";
			$result = 0;
			last;
		    }
		    $self->{_currentPackage}->setBases($bases);
		}
		elsif (/^sub\s+(\S+)/)
		{
		    my $name = $1;
		    if (!defined($self->{_currentFunction}))
		    {
			printf STDERR "Undocumented function %s\n", $name;
			$result = 0;
			last;
		    }
		    elsif ($self->{_currentFunction}->getName() ne $name)
		    {
			printf STDERR "Documentation code mismatch %s %s\n",
			    $name, $self->{_currentFunction}->getName();
			$result = 0;
			last;
		    }
		}
		elsif (/^package\s+(\S+)\s*;/)
		{
		    my $name = $1;
		    if (!defined($self->{_currentPackage}))
		    {
			printf STDERR "Undocumented package %s\n", $name;
			$result = 0;
			last;
		    }
		    elsif ($self->{_currentPackage}->getName() ne $name)
		    {
			printf STDERR "Documentation code mismatch %s %s\n",
			    $name, $self->{_currentPackage}->getName();
			$result = 0;
			last;
		    }
		}
	    }
	}
	close(PERL);
    }
    return $result;
}

# @method emitTop
# Emits the top documentation for this module on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitTop
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    printf FILE "\n";
    printf FILE "=head1 MODULE C<%s>\n", $self->{_name};
    printf FILE "\n";
}

# @method emitBottom
# Emits the bottom documentation for this module on the given output file.
# @param self This module.
# @param FILE The output file.
sub emitBottom
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    printf FILE "=cut\n";
    printf FILE "\n";
}

# @method emit
# Emits the documentation for this module on the given output file.
# @param self This module
# @param FILE The output file.
sub emit
{
    my ($self, $FILE);
    ($self, *FILE) = @_;
    $self->emitTop(*FILE);
    foreach my $name (sort(keys(%{$self->{_packages}})))
    {
	my $package = ${$self->{_packages}}{$name};
	$package->emit(*FILE);
    }
    $self->emitBottom(*FILE);
}

# @method update
# Updates the pod in the file for this module.
# @param self This module.
# @return Zero on failure; Non-zero on success;
sub update
{
    my ($self) = @_;
    my $result = 1;
    my $file = $self->{_file};
    my $backup = $file . '.bak';
    if (!open(SRC, "<$file"))
    {
	printf STDERR "Failed to open %s: %s\n", $file, $!;
	$result = 0;
    }
    elsif (!open (DST, ">$backup"))
    {
	printf STDERR "Failed to open %s: %s\n", $backup, $!;
	$result = 0;
	close(SRC);
    }
    else
    {
	while(<SRC>)
	{
	    last if /^__DATA__/;
	    print DST $_;
	}
	close(SRC);
	close(DST);

	if (!open(SRC, "<$backup"))
	{
	    printf STDERR "Failed to open %s: %s\n", $backup, $!;
	    $result = 0;
	}
	elsif (!open (DST, ">$file"))
	{
	    printf STDERR "Failed to open %s: %s\n", $file, $!;
	    $result = 0;
	    close(SRC);
	}
	else
	{
	    while (<SRC>)
	    {
		print DST $_;
	    }
	    printf DST "__DATA__\n";
	    $self->emit(*DST);
	    close(SRC);
	    close(DST);
	    if (!unlink($backup))
	    {
		printf STDERR "Failed to unlink %s: %s\n", $backup, $!;
		$result = 0;
	    }
	}
    }
    return $result;
}

# @package Opus10::MakePod
# Provides a program to generate pod from embedded documentation.
package Opus10::MakePod;

# @function main
# Make program.
# @param args Command-line arguments.
# @return 0 on success; non-zero on failure.
sub main
{
    my (@args) = @_;
    my $status = 0;

    if (@args == 0)
    {
	printf STDERR "usage: %s <module> [...]\n", $0;
    }
    else
    {
	foreach my $arg (@args)
	{
	    my $module = Opus10::MakePod::Module->new($arg);
	    if ($module->load())
	    {
		if (!$module->update())
		{
		    printf STDERR "Could not update %s.\n", $arg;
		    $status = 1;
		    last;
		}
	    }
	    else
	    {
		printf STDERR "Could not load %s.\n", $arg;
		$status = 1;
		last;
	    }
	}
    }
    return $status;
};

use Cwd 'abs_path';
if (abs_path($0) eq abs_path(__FILE__))
{
    no strict 'refs';
    exit &{__PACKAGE__ . '::main'}(@ARGV);
}

1;
__DATA__

=head1 MODULE C<Opus10::MakePod>

=head2 PACKAGE C<Opus10::MakePod>

Provides a program to generate pod from embedded documentation.

=head3 FUNCTION C<main>

Make program.

=head4 Parameters

=over

=item C<args>

Command-line arguments.

=back

=head4 Return

0 on success; non-zero on failure.

=head2 PACKAGE C<Opus10::MakePod::Attribute>

Represents the documentation for an attribute.

=head3 ATTRIBUTES

=over

=item C<_name>

The name of the attribute.

=item C<_type>

The type of the attribute ('attr' or 'param')

=back

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This attribute.

=back

=head3 METHOD C<emit>

Emits the documentation for this attribute on the given output file.

=head4 Parameters

=over

=item C<self>

This attribute.

=item C<FILE>

The output file.

=back

=head3 METHOD C<initialize>

Initializes this attribute with the given name, type and text.

=head4 Parameters

=over

=item C<self>

This attribute.

=item C<name>

The name.

=item C<type>

Either 'attr' or 'param'.

=item C<text>

The documentation text.

=back

=head2 PACKAGE C<Opus10::MakePod::Function>

Represents the documentation for a function.

=head3 ATTRIBUTES

=over

=item C<_name>

The name of the function.

=item C<_parameters>

The parameters of the function.

=item C<_return>

The return of the function.

=item C<_text>

The documentation text.

=item C<_type>

The type of the function ('function', 'classmethod' or 'method').

=back

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This function.

=back

=head3 METHOD C<addParameter>

Adds the given parameter to this function.

=head4 Parameters

=over

=item C<self>

This function.

=item C<parameter>

The parameter.

=back

=head3 METHOD C<addReturn>

Adds the given return documentation to this function.

=head4 Parameters

=over

=item C<self>

This function.

=item C<text>

The documentation text.

=back

=head3 METHOD C<emit>

Emits the documentation for this function on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitBottom>

Emits the bottom documentation for this function on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitParameters>

Emits the parameter documentation for this function on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitReturn>

Emits the return documentation for htis function on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitTop>

Emits the top documentation for this function on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<getName>

Returns the name of this function.

=head4 Parameters

=over

=item C<self>

This function.

=back

=head4 Return

The name of this function.

=head3 METHOD C<initialize>

Initializes this function with the given name, type and text.

=head4 Parameters

=over

=item C<self>

This function.

=item C<name>

The name.

=item C<type>

Either 'function', 'classmethod' or 'method'.

=item C<text>

The documentation text.

=back

=head2 PACKAGE C<Opus10::MakePod::Module>

Represents the documentation for a module.

=head3 ATTRIBUTES

=over

=item C<_currentFunction>

The current function.

=item C<_currentPackage>

The current package.

=item C<_file>

The file of the module.

=item C<_name>

The name of the module.

=item C<_packages>

The packages of the module.

=back

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This module.

=back

=head3 METHOD C<emit>

Emits the documentation for this module on the given output file.

=head4 Parameters

=over

=item C<self>

This module

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitBottom>

Emits the bottom documentation for this module on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitTop>

Emits the top documentation for this module on the given output file.

=head4 Parameters

=over

=item C<self>

This module.

=item C<FILE>

The output file.

=back

=head3 METHOD C<initialize>

Initializes this module with the given name.

=head4 Parameters

=over

=item C<self>

This module.

=item C<name>

The name.

=back

=head3 METHOD C<load>

Loads this module.
Searches for the file that contains the definition of this module
and then calls the parse method to parse the file.

=head4 Parameters

=over

=item C<self>

This module.

=back

=head4 Return

Zero on failure; non-zero on success.

=head3 METHOD C<parse>

Parses this module.
Looks for comments that contain documentation directives.
Collects and then processes the directives.

=head4 Parameters

=over

=item C<self>

This module.

=back

=head4 Return

Zero on failure; non-zero on success;

=head3 METHOD C<parseDirective>

Parses the given documentation directive.

=head4 Parameters

=over

=item C<self>

This module.

=item C<directive>

The documentation directive.

=back

=head4 Return

Zero on failure; Non-zero on success.

=head3 METHOD C<update>

Updates the pod in the file for this module.

=head4 Parameters

=over

=item C<self>

This module.

=back

=head4 Return

Zero on failure; Non-zero on success;

=head2 PACKAGE C<Opus10::MakePod::Package>

Represents the documentation for a package.

=head3 ATTRIBUTES

=over

=item C<_attributes>

The attributes of the package.

=item C<_exports>

The symbols exported from the package.

=item C<_functions>

The functions in this package.

=item C<_isa>

The base classes of this package.

=item C<_name>

The name of the package.

=item C<_text>

The documentation text.

=item C<_type>

The type of the package ('package' or 'class').

=back

=head3 METHOD C<DESTROY>

Destructor.

=head4 Parameters

=over

=item C<self>

This package.

=back

=head3 METHOD C<addAttribute>

Adds the given attribute to this package.

=head4 Parameters

=over

=item C<self>

This package.

=item C<name>

The name of the attribute.

=item C<attribute>

The attribute.

=back

=head3 METHOD C<addExport>

Adds the given export to this package.

=head4 Parameters

=over

=item C<self>

This package.

=item C<name>

The name of the export.

=back

=head3 METHOD C<addFunction>

Adds the given function to this package.

=head4 Parameters

=over

=item C<self>

This package.

=item C<name>

The name of the function.

=item C<function>

The function.

=back

=head3 METHOD C<emit>

Emits the documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitAttributes>

Emits the attribute documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitBottom>

Emits the bottom documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitExports>

Emits the export documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitFunctions>

Emits the function documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<emitTop>

Emits the top documentation for this package on the given output file.

=head4 Parameters

=over

=item C<self>

This package.

=item C<FILE>

The output file.

=back

=head3 METHOD C<getName>

Returns the name of this package.

=head4 Parameters

=over

=item C<self>

This package.

=back

=head4 Return

The name of this package.

=head3 METHOD C<initialize>

Initializes this package with the given name, type and text.

=head4 Parameters

=over

=item C<self>

This package.

=item C<name>

The name.

=item C<type>

Either 'package' or 'class'.

=item C<text>

The documentation text.

=back

=head3 METHOD C<setBases>

Sets the bases classes of this package.

=head4 Parameters

=over

=item C<self>

This package.

=item C<bases>

The base clases.

=back

=cut

