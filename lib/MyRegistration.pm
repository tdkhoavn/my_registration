package MyRegistration;
use Mojo::Base 'Mojolicious', -signatures;

use MyRegistration::Model::DB;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  $self->_set_db_operation_handler();

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Example#welcome');
  $r->get('/register')->to(controller => 'Registration', action => 'register');
  $r->post('/register')->to(controller => 'Registration', action => 'do_register');
}

sub _set_db_operation_handler {
    my $self = shift;

    $self->{ _dbh } = MyRegistration::Model::DB->new();

    return $self;
}

1;
