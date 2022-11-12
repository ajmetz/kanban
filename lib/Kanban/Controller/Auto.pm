package Kanban::Controller::Auto;
use     Mojo::Base 'Mojolicious::Controller', -signatures;
use     Mojo::Home;
use     Path::Tiny;

# This action will render a template
sub auto ($self) {

	my	%folder_name=(
	);

    my  $webapp                         =   Mojo::Home->new->detect('Kanban');
    
	my	$folder_path					=	{};

    #Default Values in Stash:
    $self->stash(
        folder_path => $folder_path,
    );
    
}

1;
