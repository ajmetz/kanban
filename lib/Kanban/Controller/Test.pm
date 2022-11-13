package Kanban::Controller::Test;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Ticket;

sub test_object ($self) {

    #Initial Values:
    my  $new_line       =   '<BR>';
    my  $separator      =   ': ';

    my  $ticket         =   Ticket->new(
                                content => 'Tra-la-la',
                            );

    my  $ticket_two     =   Ticket->new(
                                content => 'Bob',
                            );

    my  $ticket_three   =   Ticket->new(
                                content => 'Susie',
                            );

    my  $content        =   $ticket->id.$separator.$ticket->content.
                            $new_line.
                            $ticket_two->id.$separator.$ticket_two->content.
                            $new_line.
                            $ticket_three->id.$separator.$ticket_three->content;

    $self->render(
        text            =>  $self->generate_layout($content)
    );

}

1;
#######