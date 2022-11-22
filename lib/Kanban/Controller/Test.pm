package Kanban::Controller::Test;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Kanban::Objects::Ticket;

sub test_object ($self) {

    #Initial Values:
    my  $new_line       =   '<BR>';
    my  $separator      =   ': ';

    my  $ticket         =   Kanban::Objects::Ticket->new(
                                content => 'Tra-la-la',
                            );

    my  $ticket_two     =   Kanban::Objects::Ticket->new(
                                content => 'Bob',
                            );

    my  $ticket_three   =   Kanban::Objects::Ticket->new(
                                content => 'Susie',
                            );

    my  $text           =   $ticket->id.$separator.$ticket->content.
                            $new_line.
                            $ticket_two->id.$separator.$ticket_two->content.
                            $new_line.
                            $ticket_three->id.$separator.$ticket_three->content;

    my  $content={
        content       =>  $text,
    };

    warn "Text is: ".$text;
    $self->render(
        text            =>  $self->generate_layout($content)
    );

}

1;
#######