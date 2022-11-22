package Kanban::Objects::Option;
use     Mojo::Base
            -base,
            -signatures;
use     Mojo::File qw(
            path
        );

has 'url' => sub ($self, $url) {path($url)};
has 'label';
has 'mobile_label' => sub ($self) {$self->label};
has 'navigation_or_page';

1;

#sub id ($self) {
#  my $name = $self->name;
#  say "$name: Quack!"
#}