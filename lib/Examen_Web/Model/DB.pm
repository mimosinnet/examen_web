package Examen_Web::Model::DB;
use Mojo::Base -base;
use List::Util qw/first/;

# A revisar amb exemple:
# https://github.com/kraih/mojo-pg/tree/master/examples/blog

has 'sqlite';

# Assignatures {{{

# llista d'assignatures 
sub assignatures {
  my $self = shift;
  return $self->sqlite->db->select('assignatura',undef);
}

# number of blocs
sub bloc_count {
  my ($self, $id_assig ) = @_;
  return $self->sqlite->db->select('assignatura','blocs',{ id => $id_assig } )->hash->{'blocs'};
}

# Assignatura
sub assig {
  my ($self, $id_assig ) = @_;
  return $self->sqlite->db->select('assignatura',undef,{ id => $id_assig } )->hash;
}

# }}}

# Blocs {{{

# name of a bloc
sub bloc_nom {
  my ($self, $id_assig, $bloc ) = @_;
  return $self->sqlite->db->select('blocs','nom', { id_assig => $id_assig, bloc => $bloc } )->hash->{'nom'};
}

# color of a bloc
sub bloc_color {
  my ($self, $id_assig, $bloc ) = @_;
  return $self->sqlite->db->select('blocs','color', { id_assig => $id_assig, bloc => $bloc } )->hash->{'color'};
}

# }}}

# Preguntes {{{

# Una pregunta {{{
sub pregunta {
  my ($self, $pregunta) = @_;
  return $self->sqlite->db->select('preguntes',undef, { id_pregunta => $pregunta } )->hash;
}
# }}}

# preguntes per bloc
sub preg_bloc {
  my ($self, $id_assig, $bloc) = @_;
  return $self->sqlite->db->select('preguntes',undef, { id_assig => $id_assig } ) if $bloc eq 0;
  return $self->sqlite->db->select('preguntes',undef, { bloc => $bloc, id_assig => $id_assig } );
}

# count pregs in bloc
sub count_bloc {
  my ($self, $id_assig, $bloc) = @_;
  return $self->sqlite->db->query("SELECT count(*) as n_preg FROM preguntes WHERE id_assig = '$id_assig' AND bloc = '$bloc'")->hash->{'n_preg'};
}

# count pregs in exem
sub count_exam {
  my ( $self, $id_assig ) = @_;
  return $self->sqlite->db->query("SELECT count(*) as n_preg FROM preguntes WHERE id_assig = '$id_assig' AND examen = 1 "   )->hash->{'n_preg'};
}

# count pregs in bloc by exam
sub count_exam_bloc {
  my ($self, $id_assig, $bloc) = @_;
  return $self->sqlite->db->query("SELECT count(*) as n_preg FROM preguntes WHERE id_assig = '$id_assig' AND bloc = '$bloc' AND examen = 1 ")->hash->{'n_preg'};
}

# registres per examen
sub preg_exam {
  my ($self, $id_assig) = @_;
  return $self->sqlite->db->select('preguntes',undef, { examen   => '1', id_assig => $id_assig } );
}

# llita de id_pregunta per examen
sub preg_exam_array {
  my ($self, $id_assig) = @_;
  return $self->sqlite->db->select('preguntes','id_pregunta', { id_assig => $id_assig, examen => '1' } )->arrays->flatten->to_array;
}

# llista de id_pregunta per bloc
sub preg_bloc_array {
  my ($self, $id_assig, $bloc) = @_;
  return $self->sqlite->db->select('preguntes','id_pregunta', { id_assig => $id_assig, bloc => $bloc } )->arrays->flatten->to_array;
}

# }}}

# Respostes {{{

# Respostes a Una pregunta 
sub resp_preg {
  my ($self, $pregunta) = @_;
  return $self->sqlite->db->select('respostes',undef, { id_pregunta => $pregunta } );
}

sub resposta {
  my ($self, $n_resposta) = @_;
  return $self->sqlite->db->select('respostes',undef, { id => $n_resposta } );
}

sub resp_preg_array {
  my ($self, $id_preg) = @_;
  return $self->sqlite->db->select('respostes','id', { id_pregunta => $id_preg } )->arrays->flatten->to_array;
}

sub correctes {
  my ($self, $pregunta) = @_;
  return $self->sqlite->db->query(" SELECT sum(correcte) AS correctes FROM respostes WHERE id_pregunta = '$pregunta' ")->hash->{'correctes'};
}
# }}}

# Update {{{

# update questions
sub preg_update {
  my ($self, $id_preg, $contingut ) = @_;
  return $self->sqlite->db->update('preguntes',$contingut,{ id_pregunta => $id_preg });
}

# update answers
sub resp_update {
  my ($self, $resposta, $contingut ) = @_;
  return $self->sqlite->db->update('respostes',$contingut,{ id => $resposta });
}
# }}}

# Insert {{{

# insert register
sub insert {
  my ($self, $table, $content ) = @_;
  return $self->sqlite->db->insert($table, $content);
}

# }}}

# full tables {{{

# get table 
sub table_get {
  my ($self, $table, $id_assig) = @_;
  return $self->sqlite->db->select($table,undef,{ id_assig => $id_assig });
}

# delete registers of table
sub delete_rows {
  my ($self, $table, $id_assig) = @_;
  return $self->sqlite->db->delete($table,{ id_assig => $id_assig });
}

# }}}

# permutations {{{

# get definition of permutation
sub get_perm_def {
  my ($self, $id_assig, $permuta) = @_;
  return $self->sqlite->db->select('permuta',undef,{ id_assig => $id_assig, permuta => $permuta });
}

# get detail of permutation
sub get_perm_detail {
  my ($self, $id_assig, $permuta) = @_;
  return $self->sqlite->db->select('permutacions',undef,{ id_assig => $id_assig, id_permuta => $permuta });
}

# insert definition of permutation
sub insert_permuta {
  my ($self, $register) = @_;
  return $self->sqlite->db->insert('permuta', $register);
}

# insert permutation
sub insert_permutacio {
  my ($self, $register) = @_;
  return $self->sqlite->db->insert('permutacions', $register);
}
# }}}

1;
# vim: tabstop=2
