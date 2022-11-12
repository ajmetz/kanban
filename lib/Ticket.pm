package Ticket;
use Mojo::Base -base, -signatures;
use Data::UUID;

my $unique_ids = Data::UUID->new;

has 'content';
has 'id' => $unique_ids->to_string($unique_ids->create());

1;

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}