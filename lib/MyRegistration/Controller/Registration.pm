package MyRegistration::Controller::Registration;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Crypt::PBKDF2;
use Email::Valid;

sub register {
    my $c = shift;

    $c->stash( error   => $c->flash('error') );
    $c->stash( message => $c->flash('message') );

    $c->render( template => 'register' );
}

sub do_register {
    my $c = shift;
    my $v = $c->validation;

    return $c->render( template => 'not_found', status => 403 ) if $v->csrf_protect->has_error('csrf_token');

    my $email            = $c->param('email');
    my $password         = $c->param('password');
    my $confirm_password = $c->param('confirm_password');
    my $first_name       = $c->param('first_name');
    my $last_name        = $c->param('last_name');
    my $middle_name      = $c->param('middle_name');

    if (   !$email
        || !$password
        || !$confirm_password
        || !$first_name
        || !$last_name
        || !$middle_name )
    {
        $c->flash( error => 'All fields are required' );
        $c->redirect_to('/register');
        return;
    }

    if ( $password ne $confirm_password ) {
        $c->flash( error => 'Passwords do not match' );
        $c->redirect_to('/register');
        return;
    }

    if ( !$c->validate_email($email) ) {
        $c->flash( error => 'Invalid email' );
        $c->redirect_to('/register');
        return;
    }

    if ( !$c->validate_name($first_name) ) {
        $c->flash( error => 'Invalid first name' );
        $c->redirect_to('/register');
        return;
    }

    if ( !$c->validate_name($last_name) ) {
        $c->flash( error => 'Invalid last name' );
        $c->redirect_to('/register');
        return;
    }

    if ( !$c->validate_name($middle_name) ) {
        $c->flash( error => 'Invalid middle name' );
        $c->redirect_to('/register');
        return;
    }

    my $dbh = $c->app->{_dbh};

    my $user = $dbh->resultset('User')->search( { email => $email } );

    if ( !$user->first ) {
        eval {
            $dbh->resultset('User')->create(
                {
                    email       => $email,
                    password    => generate_password($password),
                    first_name  => $first_name,
                    middle_name => $middle_name,
                    last_name   => $last_name,
                    status      => 1,
                }
            );
        };

        if ($@) {
            $c->flash( error => 'Something went wrong' );
            $c->redirect_to('/register');
            return;
        }
        else {
            $c->flash( message => 'Registration successful' );
            $c->redirect_to('/register');
            return;
        }
    }
    else {
        $c->flash( error => 'Email already exists' );
        $c->redirect_to('/register');
        return;
    }
}

sub generate_password {
    my $plain_password = shift;

    my $pbkdf2 = Crypt::PBKDF2->new(
        hash_class => 'HMACSHA2',
        iterations => 1000,
        output_len => 20,
        salt_len   => 4,
    );

    return $pbkdf2->generate($plain_password);
}

sub validate_email {
    my ($self, $email) = @_;

    return (
        Email::Valid->address(
            -address => $email, -mxcheck => 1
        ) ? 1 : 0
    );
}

sub validate_name {
    my ($self,  $name) = @_;

    if ($name =~ /^[a-zA-Z]+$/ ) {
        return 1;
    }
    else {
        return 0;
    }
}
1;
