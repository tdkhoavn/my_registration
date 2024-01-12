package MyRegistration::Model::DB;

use MyRegistration::Schema;
use DBIx::Class ();

use strict;

my ($schema_class, $connect_info);

BEGIN {
    $schema_class = 'MyRegistration::Schema';
    $connect_info = {
        dsn => 'dbi:mysql:database=my_registration;host=127.0.0.1;port=3306',
        user => 'root',
        password => 'Secret@12345',
    };
}

sub new {
    return __PACKAGE__->config( $schema_class, $connect_info );
}

sub config {
    my $class = shift;

    my $self = {
        schema => shift,
        connect_info => shift,
    };

    my $dbh = $self->{schema}->connect(
        $self->{connect_info}->{dsn},
        $self->{connect_info}->{user},
        $self->{connect_info}->{password},
    );

    return $dbh;
}
1;