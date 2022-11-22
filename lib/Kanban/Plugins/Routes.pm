package Kanban::Plugins::Routes;
use Mojo::Base 'Mojolicious::Plugin';

use     Mojo::File qw(curfile);

sub register {
    my  ($self, $app, $conf)            =   @_;
    my  $after_auto                     =   $app->routes->under('/')->to('Auto#auto');
    my  $after_auto_and_stash_values    =   $after_auto->under('/')->to(controller => 'StashValues', action => 'stash_values');

    #test object:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] => '/test_object'
    )
    ->to(
        controller      => 'Test', 
        action          => 'test_object',
        left_overs      => undef #default
    );

    #Boards Create:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] => '/create_board'
    )
    ->to(
        controller      => 'Boards', 
        action          => 'create',
        left_overs      => undef #default
    );

    #Boards Create:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] => '/create_option'
    )
    ->to(
        controller      => 'Options', 
        action          => 'create_option',
        left_overs      => undef #default
    );


    # Default Home Page - due to the use of left_overs as a catch all - it has to come last:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] =>  '/*left_overs'
    )
    ->to(
        controller      =>  'Home',
        action          =>  'home',
        left_overs      =>  undef #default
    );

    return;
}

1;