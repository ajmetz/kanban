package Kanban::Controller::Home;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub home ($self) {

    #Initial Values:
    $self->render(
        text            =>  $self->generate_layout
    );

}

1;
