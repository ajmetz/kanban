package Ticket;
use Mojo::Base -base, -signatures;

my $unique_ids = 0;

has 'content';
has 'id' => sub { $unique_ids++ };

1;

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}