package Kanban::Plugin::Routes;
use Mojo::Base 'Mojolicious::Plugin';

use     Mojo::File qw(curfile);

sub register {
    my  ($self, $app, $conf)            =   @_;
    my  $after_auto                     =   $app->routes->under('/')->to('Auto#auto');
    my  $after_auto_and_stash_values    =   $after_auto->under('/*left_overs')->to(controller => 'StashValues', action => 'stash_values', left_overs => undef);

    #test object:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] => '/test_object'
    )
    ->to(
        controller      => 'Example', 
        action          => 'test_object',
        left_overs      => undef #default
    );

    # Default Home Page - due to the use of left_overs as a catch all - it has to come last:
    $after_auto_and_stash_values->any(
        ['GET', 'POST'] =>  '/*left_overs'
    )
    ->to(
        controller      =>  'Example',
        action          =>  'welcome',
        left_overs      =>  undef #default
    );

    return;
}

1;