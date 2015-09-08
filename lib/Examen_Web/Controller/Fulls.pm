package Examen_Web::Controller::Fulls;
use Mojo::Base 'Mojolicious::Controller';

# Llista de fulls d'examen {{{
sub llista {
	my $self = shift;
	my $permuta = $self->db->resultset('Permuta');

	$self->render( permuta => $permuta );
}
# }}}

# Full d'examen {{{
sub examen {
	my $self = shift;
	my $opcio 	 		 = $self->stash('opcio');
	my $perm_n   		 = $self->stash('permuta');
	my $permuta  		 = $self->m_examen->permutacio($perm_n);

	return $self->redirect_to( '/index' ) unless 
		$self->m_examen->is_permuta($perm_n);

	# Definim aquí la variable examen per tal de que estigui 
	# disponible als templates que insertem
	$self->render( 
		opcio 	 		=> $opcio,
		perm_n   		=> $perm_n,
		permuta			=> $permuta,
		examen 			=> $permuta->examen,
	);
}
# }}}

1;
# vim: tabstop=2
