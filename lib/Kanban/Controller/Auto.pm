package Kanban::Controller::Auto;
use     Mojo::Base 'Mojolicious::Controller', -signatures;
use     Mojo::Home;
use     Path::Tiny;

# This action will render a template
sub auto ($self) {

	my	$folder_name={
			controller					=>	"Controller",
			'package'					=>	'Kanban',
			lib							=>	"lib",
			layouts						=>	"Layouts",
	};

    my  $webapp                         =   Mojo::Home->new->detect('Kanban');
    
	my	$folder_path					=	{};
		$folder_path->{'base'}			=	$self->set_dir(
												"Base Directory",
												path($webapp),
											);
		$folder_path->{'lib'}			=	$self->set_dir(
												"Library",
												path($folder_path->{'base'},$folder_name->{'lib'}),
											);
		$folder_path->{'package'}		=	$self->set_dir(
												"Games Mags Package",
												path($folder_path->{'lib'},$folder_name->{'package'}),
											);
		$folder_path->{'controller'}	=	$self->set_dir(
												"Controller",
												path($folder_path->{'package'},$folder_name->{'controller'}),
											);
		$folder_path->{'our'}			=	$self->set_dir(
												"Our current directory",
												path($folder_path->{'controller'}),
											);
		$folder_path->{'layouts'}		=	$self->set_dir(
												"Layouts",
												path($folder_path->{'package'},$folder_name->{'layouts'}),
											);

    #Default Values in Stash:
    $self->stash(
        folder_path => $folder_path,
    );
    
}

1;
