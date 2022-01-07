package Examen_Web;
use Mojo::Base 'Mojolicious';
use Examen_Web::Obj::db;

# This method will run once at server start
sub startup {
  my $self = shift;

	$self->plugin('Config', file => 'examen__web.conf');
	$self->secrets('NovaParaulaClau per les cookies 1421452135512');

  # database model availabe as $self->model {{{
  $self->helper( model => sub { 
			state $model = Examen_Web::Obj::db->new->model;
		}
	);
	# }}}

  # Router
  my $r = $self->routes;

	# Static Pages
  $r->get('/exception')->to(template => 'exception/exception');
	# Dinamic Pages
  $r->get('/')->to('examen#index');
  # Assignatures
  $r->get('/:id_assig/index')->to('examen#index_assig');
  $r->get('/:id_assig/preguntes/:opcio/:num')->to('examen#preguntes');
	$r->get('/:id_assig/respostes/:num_pregunta')->to('examen#respostes');
	$r->get('/:id_assig/editar/:id_preg')->to('examen#editar');
	$r->get('/:id_assig/afegir')->to('examen#afegir');
  $r->get('/:id_assig/permutacions')->to('examen#permutacions');
	# Actualitzar / Update. ATENCIÓ: fer-ho diferenciat per cada assignatura, per seguretat
	$r->post('/actual_preg')->to('examen#actual_preg');
	$r->post('/actual_resp')->to('examen#actual_resp');
	$r->post('/actual_exam')->to('examen#actual_exam');
	$r->post('/crear_permuta')->to('examen#crear_permuta');
	# Fulls d'examen
	$r->get('/:id_assig/fulls_llista')->to('fulls#llista');
	$r->get('/:id_assig/full/:opcio/:permuta')->to('fulls#examen');
	$r->get('/:id_assig/full_respostes/:permuta')->to('fulls#respostes');
  $r->get('/:id_assig/full_tots/:bloc')->to('fulls#tots');
	$r->get('/:id_assig/full_aiken/:lang')->to('fulls#aiken');
	$r->get('/:id_assig/full_gift/:lang')->to('fulls#gift');
}

1;

# vim: tabstop=2
