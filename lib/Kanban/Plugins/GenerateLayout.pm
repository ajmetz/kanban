package Kanban::Plugins::GenerateLayout;
use     Mojo::Base 'Mojolicious::Plugin';
use     Path::Tiny;
use     Mojo::Util qw(dumper);
use     feature qw(postderef fc);

our $VERSION    =   'v1.0.0';
    
=pod Name, Version, Synopsis

=encoding utf8

=head1 NAME

Generate Layout - A mojolicious helper, to help generate the layout for a web app. 
Requires the put_here helper too.

=head1 VERSION

v1.0.0

=head1 SYNOPSIS

 #In your code:
    my  $content =   $self->generate_layout(@any_params_go_here);

=cut

=pod Description - Register

=head1 DESCRIPTION

Registers C<< generate_layout >> as a Mojolicious Helper.

=cut

sub register {
    my ($self, $app, $config) =   @_;

    my  $helpers={
        generate_layout =>  \&generate_layout,
    };
    
    for my $current (keys $helpers->%*) {
        $app->helper($current    =>  $helpers->{$current});
    };
    return;
}



sub generate_layout {

    #Initial Values:
    my  ($self, $layout_content)        =   @_;
    my  $folder_path                    =   $self->stash->{'folder_path'};
    my  $content                        =   $layout_content->{'content'}? $layout_content->{'content'}:
                                            q{};

    my  $errors                         =   q{};
    $errors                             .=  "Left overs are: ".$self->stash->{'left_overs'} if $self->stash->{'left_overs'};


    #Get Templates:
    my	$template = $self->group_set_slurp({

        #Anon Hash Ref:

        #Folder path that this group of templates can be slurped up from:
        basepath		=>	$folder_path->{layouts},

                                #                             #Anon Array Ref:                          #
        #Hash Key				    #Friendly Name of File			        #Filename
        main        	        =>	[	'Main HTML'                 =>	    'main.htm'		            ],
    });


    my  $layout             =   $self->put_here(
                                   $template->{'main'},
                                    'CONTENT'   =>  $content,
                                    'ERRORS'    =>  $errors,
                                );

    return  $layout;
}



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