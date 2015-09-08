use utf8;
package Examen_Web::Schema::Result::Permutacion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Examen_Web::Schema::Result::Permutacion

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<permutacions>

=cut

__PACKAGE__->table("permutacions");

=head1 ACCESSORS

=head2 id_permuta

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0
  size: 1

=head2 id_pregunta

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0
  size: 2

=head2 resp_a

  data_type: 'integer'
  is_nullable: 0
  size: 1

=head2 resp_b

  data_type: 'integer'
  is_nullable: 0
  size: 1

=head2 resp_c

  data_type: 'integer'
  is_nullable: 0
  size: 1

=head2 resp_d

  data_type: 'integer'
  is_nullable: 0
  size: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_permuta",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0, size => 1 },
  "id_pregunta",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0, size => 2 },
  "resp_a",
  { data_type => "integer", is_nullable => 0, size => 1 },
  "resp_b",
  { data_type => "integer", is_nullable => 0, size => 1 },
  "resp_c",
  { data_type => "integer", is_nullable => 0, size => 1 },
  "resp_d",
  { data_type => "integer", is_nullable => 0, size => 1 },
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id_permuta

Type: belongs_to

Related object: L<Examen_Web::Schema::Result::Permuta>

=cut

__PACKAGE__->belongs_to(
  "id_permuta",
  "Examen_Web::Schema::Result::Permuta",
  { id_permuta => "id_permuta" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_pregunta

Type: belongs_to

Related object: L<Examen_Web::Schema::Result::Pregunte>

=cut

__PACKAGE__->belongs_to(
  "id_pregunta",
  "Examen_Web::Schema::Result::Pregunte",
  { id_pregunta => "id_pregunta" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-06-07 11:09:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ERujQfQMeeIrm01pePeRkQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
