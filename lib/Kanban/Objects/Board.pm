package Kanban::Objects::Board;
use Mojo::Base -base, -signatures;
use v5.36;
use Kanban::Objects::Column;

# Initial Values:
my $unique_ids = 0;

has 'id'        =>  sub { $unique_ids++ };

has 'columns'   =>  sub ($self) {$self->_make_columns('todo','doing','done') };

1;

sub _make_columns ($self, @column_names) {

    my  $columns            =   [];

    foreach my $column_name (@column_names) {
        push $columns->@*   ,   Kanban::Objects::Column->new(
                                    name => $column_name,
                                );
    };

    return $columns;
}

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}