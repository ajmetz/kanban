package Board;
use Mojo::Base -base, -signatures;
use Column;
use v5.36;

# Initial Values:
my $unique_ids = 0;

has 'id' => sub { $unique_ids++ };

has 'columns'   =>  sub {_make_columns('todo','doing','done') };

1;

sub _make_columns {
    my  @column_names   =   @_;
    my  $columns        =   []; 
    foreach my $column_name (@column_names) {
        push $columns->@*, Column->new( name => $column_name );
    };
    return $columns;
}

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}