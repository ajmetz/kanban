package Kanban::Objects::Option;
use Mojo::Base -base, -signatures;

has 'url';
has 'label';
has 'mobile_label' => undef;
has 'navigation_or_page';

1;

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}