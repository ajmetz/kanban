package Kanban::Objects::Column;
use Mojo::Base -base, -signatures;

has 'tickets';
has 'id';

1;

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}