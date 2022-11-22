package Kanban::Controller::Boards;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Kanban::Objects::Board;

sub create
(
    $self,
    $layouts_content    =   {
        content         =>  "Board ".Kanban::Objects::Board->new->id,
    }
) 
{

    $self->render(
        text            =>  $self->generate_layout($layouts_content)
    );

}

1;
