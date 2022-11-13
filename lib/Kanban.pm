package Kanban;
use Mojo::Base 'Mojolicious', -signatures;
use Mojo::File qw(curfile);
use Mojo::Home;

# This method will run once at server start
sub startup ($self) {

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    # Configure the application
    $self->secrets($config->{secrets});

    # Switch to installable home directory
    $self->home(Mojo::Home->new(curfile->sibling('Kanban')));

    # Database:
    my  $db_connection  =   $self->home->child('database','test.db');
    my  $db_migration   =   $self->home->child('database','migration.sql');

    $self->plugin('Kanban::Plugins::Database',{ connection => $db_connection });
    $self->database->auto_migrate(1)->migrations->name('Test Migrations')->from_file($db_migration);

    # Router
    $self->plugin('Kanban::Plugins::Routes');

    # Other plugins:
    $self->plugin('Kanban::Plugins::PutHere');
    $self->plugin('Kanban::Plugins::GenerateLayout');

}

1;
