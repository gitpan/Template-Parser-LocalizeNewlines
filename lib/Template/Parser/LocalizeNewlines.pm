package Template::Parser::LocalizeNewlines;

=pod

=head1 NAME

Template::Parser::LocalizeNewlines - Drop-in replacement Template::Parser that
fixes bad newlines

=head1 DESCRIPTION

Template::Parser would seem to have a problem in that PRE_CHOMP and friends
only work on local newlines. If a Template Toolkit instance on a Unix host
encounters DOS newlines in a Template, it will fail to chomp the newline
correctly.

Template::Parser::LocalizeNewlines is a drop-in replacement that behaves
EXACTLY the same (and is a subclass of) as a normal parser, except that
before it goes to parse the template content, it applies the newline
localisation regex describes in L<http://ali.as/devel/newlines.html>.

=head2 Using this Module

When creating your Template instance, simple pass an instance of this object
along to the constructor.

=cut

use strict;
use base 'Template::Parser';

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.01';
}

# The only method we need to change
sub parse {
	my $self = shift;
	my $text = shift;

	# Localise the newlines
	$text =~ s/(?:\015{1,2}\012|\015|\012)/\n/gs;

	# Pass off to the normal parser
	$self->SUPER::parse( $text, @_ );
}

1;

=pod

=head1 METHODS

This module is identical to L<Template::Parser>.

=head1 SUPPORT

Module not implemented, there's nothing to be broken. But if you have
installation problems, submit them to the CPAN bug tracker.

L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Template%3A%3AParser%3A%3ALocalizeNewlines>

For other issues, contact the designer

=head1 AUTHORS

Adam Kennedy (Maintainer), L<http://ali.as/>, cpan@ali.as

=head1 COPYRIGHT

Copyright (c) 2004 Adam Kennedy. All rights reserved.
This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
