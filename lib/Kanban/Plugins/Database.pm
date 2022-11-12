package Kanban::Plugins::Database;
use     Mojo::Base 'Mojolicious::Plugin';
use     Mojo::SQLite;
our $VERSION    =   'v1.0.0';


=pod Name, Version, Synopsis

=encoding utf8

=head1 NAME

Database - Simple Database helper.

=head1 VERSION

v1.0.0

=head1 SYNOPSIS

 #In your template:
    blah blah blah
    PUT-PLACE-HOLDER-1-HERE
    blah blah blah
    PUT-PLACE-HOLDER-2-HERE
    blah blah blah
    PUT-SOMETHING-HERE
    blah blah blah
    PUT-SOMETHING-ELSE-HERE


 #In your code:
    my  $populated_template =   put_here(

                                    #Template to populate...
                                    $template_with_placeholders,

                                    #What to populate it with...
                                    'PLACE-HOLDER-1'    =>  $value1,
                                    'PLACE-HOLDER-2'    =>  $value2,
                                    SOMETHING           =>  $value3,
                                    'SOMETHING-ELSE'    =>  $value4,

                                );

=cut

=pod Description - Register

=head1 DESCRIPTION

Registers C<< put_here >> as a Mojolicious Helper.

=cut

sub register {
    my ($self, $app, $config) =   @_;

    $app->helper(
        database    =>  sub { database($config) },
    );
    return;
}

sub database {

=pod Description - Object constructor & database connection.

Create a Mojo::SQLite object,
based on our database connection information.
    
=cut
    my  $config =   shift;
    state $sql  =   Mojo::SQLite->new($config->{'connection'});
#    return          'Return database';
};

1;

=pod See Also, Author and License sections.

=head1 SEE ALSO

L<MojoTest>

=head1 AUTHOR

Andrew Mehta

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut