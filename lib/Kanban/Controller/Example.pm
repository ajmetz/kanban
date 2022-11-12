package Kanban::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Ticket;
use Data::UUID;
# This action will render a template
sub welcome ($self) {

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub test_object ($self) {
    my  $new_line   =   '<BR>';
    my $unique_ids = Data::UUID->new;
    my  $ticket  =  Ticket->new(
                        content => 'Tra-la-la',
                    );

    my  $ticket_two  =  Ticket->new(
                        content => 'Bob',
                    );


    my  $ticket_three  =  Ticket->new(
                        content => 'Susie',
                    );

    $self->render(
        text  =>  $ticket->id.
                  ": ".
                  $ticket->content.
                  $new_line.
                  $ticket_two->id.
                  ": ".
                  $ticket_two->content.
                  $new_line.
                  $ticket_three->id.
                  ": ".
                  $ticket_three->content.
                  $new_line.
                'Test uniques for Eliza: '.
                $unique_ids->to_string($unique_ids->create()).
                $new_line.
                $unique_ids->to_string($unique_ids->create()).
                $new_line.
                $unique_ids->to_string($unique_ids->create())
    );



}



1;
