use utf8;
package Examen_Web::Schema::Result::Permuta;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Examen_Web::Schema::Result::Permuta

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<permuta>

=cut

__PACKAGE__->table("permuta");

=head1 ACCESSORS

=head2 id_permuta

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 idioma

  data_type: 'integer'
  is_nullable: 1
  size: 1

=head2 examen

  data_type: 'integer'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "id_permuta",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "idioma",
  { data_type => "integer", is_nullable => 1, size => 1 },
  "examen",
  { data_type => "integer", is_nullable => 1, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_permuta>

=back

=cut

__PACKAGE__->set_primary_key("id_permuta");

=head1 RELATIONS

=head2 permutacions

Type: has_many

Related object: L<Examen_Web::Schema::Result::Permutacion>

=cut

__PACKAGE__->has_many(
  "permutacions",
  "Examen_Web::Schema::Result::Permutacion",
  { "foreign.id_permuta" => "self.id_permuta" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-06-07 11:09:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XvPz7clSK2Oexdvlpyo+gA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
