use utf8;
package MyRegistration::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyRegistration::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 status

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 1

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 120

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 135

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 middle_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "status",
  { data_type => "tinyint", default_value => 1, is_nullable => 1 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 120 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 135 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "middle_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2024-01-07 19:25:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FRweOVMBr6t84zV4we09zg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
