package Kanban::Controller::Options;
use     Mojo::Base 
            'Mojolicious::Controller',
            -signatures;
use     Kanban::Objects::Option;

sub create_option ($self) {

    my  $new_line   =   '<BR>';
    my  $option     =   Kanban::Objects::Option->new->label('Create Board')->url('/create_board');
                        

    my  $layouts_content = {
        content         =>  'Label '    .$option->label.
                            $new_line.
                            'Url '      .$option->url,
    };

    $self->render(
        text            =>  $self->generate_layout($layouts_content)
    );

}

1;
