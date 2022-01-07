package Examen_Web::Obj::Bloc_Attributes;
use Mojo::Base -base;
use Examen_Web::Obj::db;

has model => sub { Examen_Web::Obj::db->new->model };

has id_assig => "";

has assig_nom => sub {
  my $self = shift;
  return $self->model->assig($self->id_assig)->{'assig'};
};

# number of blocs
has blocs => sub {
  my $self = shift;
  return $self->model->assig($self->id_assig)->{'blocs'};
};

# color for each bloc, hash-ref
has color => sub {
  my $self = shift;
  my %color;
  for my $i ( 1 .. $self->blocs  ) {
    $color{$i} = $self->model->bloc_color($self->id_assig,$i);
  }
  return \%color;
};

# name of each block, hash-ref
has name => sub {
  my $self = shift;
  my %name;
  for my $i ( 1 .. $self->blocs  ) {
    $name{$i} = $self->model->bloc_nom($self->id_assig,$i);
  }
  return \%name;
};

# preguntes en cada bloc
has n_pregs => sub {
  my $self = shift;
  my %n_pregs;
  for my $i ( 1 .. $self->blocs  ) {
    $n_pregs{$i} = $self->model->count_bloc($self->id_assig,$i);
  }
  return \%n_pregs;
};

1;
