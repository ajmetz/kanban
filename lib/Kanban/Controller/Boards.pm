package Kanban::Controller::Boards;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Board;

sub create ($self) {

    #Initial Values:
    my  $instance_of_board = Board->new;

    my  $content    =   "Board ".$instance_of_board->id;

    my  $layouts_content={
        content       =>  $content,
    };

    $self->render(
        text            =>  $self->generate_layout($layouts_content)
    );

}

1;
