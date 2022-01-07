package Examen_Web::Controller::Fulls;
use Mojo::Base 'Mojolicious::Controller';

# Llista de fulls d'examen {{{
sub llista {
	my $self = shift;
  my $id_assig = $self->stash('id_assig');
	my $permuta = $self->model->table_get( 'permuta', $id_assig );

	$self->render( 
    permuta  => $permuta,
    id_assig => $id_assig,
  );
}
# }}}

# Full d'examen {{{
sub examen {
	my $self = shift;
  my ($id_assig, $opcio, $perm_n) = ($self->stash('id_assig'), $self->stash('opcio'), $self->stash('permuta'));
	my $permuta  		 = $self->model->get_perm_def($id_assig, $perm_n)->hash;

	# Definim aquí la variable examen per tal de que estigui 
	# disponible als templates que insertem
	$self->render( 
		opcio 	 		=> $opcio,
		perm_n   		=> $perm_n,
    idioma      => $permuta->{'idioma'},
    permutacio  => $self->model->get_perm_detail($id_assig, $permuta->{'id_permuta'} ),
    assig_nom   => $self->model->assig($id_assig)->{'assig'}
	);
}
# }}}

# Full de respostes {{{
sub respostes {
	my $self = shift;
  my ($id_assig, $perm_n) = ($self->stash('id_assig'), $self->stash('permuta'));
	my $permuta = $self->model->get_perm_def($id_assig, $perm_n)->hash;

	# Definim aquí la variable examen per tal de que estigui 
	# disponible als templates que insertem
	$self->render( 
		perm_n   		=> $perm_n,
    permutacio  => $self->model->get_perm_detail($id_assig, $permuta->{'id_permuta'} ),
    assig_nom   => $self->model->assig($id_assig)->{'assig'}
	);
}
# }}}

# Totes les Preguntes {{{
# Full d'examen 
sub tots {
	my $self = shift;
  my ($id_assig, $bloc) = ($self->stash('id_assig'), $self->stash('bloc'));

	$self->render(
		bloc        => $bloc,
    preguntes   => $self->model->preg_bloc($id_assig, $bloc),
	);
}
# }}}

sub aiken {
  my $self = shift;
  my ($id_assig, $lang) = ($self->stash('id_assig'), $self->stash('lang'));
  $self->render(
    lang      => $lang,
    id_assig  => $id_assig,
    preguntes => $self->model->preg_exam($id_assig),
  );
}

sub gift {
  my $self = shift;
  my ($id_assig, $lang) = ($self->stash('id_assig'), $self->stash('lang'));
  $self->render(
    lang      => $lang,
    id_assig  => $id_assig,
    preguntes => $self->model->preg_exam($id_assig),
  );
}

1;
# vim: tabstop=2
