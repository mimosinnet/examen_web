use utf8;
package Examen_Web::Schema::Result::Examen;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Examen_Web::Schema::Result::Examen

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<examen>

=cut

__PACKAGE__->table("examen");

=head1 ACCESSORS

=head2 id_pregunta

  data_type: 'integer'
  is_nullable: 1

=head2 pregunta_cat

  data_type: 'text'
  is_nullable: 1

=head2 pregunta_cas

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 correcte

  data_type: 'integer'
  is_nullable: 1
  size: 1

=head2 resposta_cat

  data_type: 'text'
  is_nullable: 1

=head2 resposta_cas

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id_pregunta",
  { data_type => "integer", is_nullable => 1 },
  "pregunta_cat",
  { data_type => "text", is_nullable => 1 },
  "pregunta_cas",
  { data_type => "text", is_nullable => 1 },
  "id",
  { data_type => "integer", is_nullable => 1 },
  "correcte",
  { data_type => "integer", is_nullable => 1, size => 1 },
  "resposta_cat",
  { data_type => "text", is_nullable => 1 },
  "resposta_cas",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-06-07 11:09:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y4Vi24Zm6yS7AUxgsJjt1w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
