package Kanban::Controller::StashValues;
use     Mojo::Base 'Mojolicious::Controller';

sub stash_values {

    my  $self   =   shift;

    $self->stash(
        test_value  =>  'test_value',
    );    
}

1;
