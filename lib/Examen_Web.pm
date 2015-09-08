package Examen_Web;
use Mojo::Base 'Mojolicious';
use Examen_Web::Schema;
use Examen_Web::Model::Examen;

has schema => sub {
	return Examen_Web::Schema->connect('dbi:SQLite:dbname=data/examen.db', '', '', 
		{sqlite_unicode => 1 } 
	) || die "Cannot connect";
};

# This method will run once at server start
sub startup {
  my $self = shift;

	$self->plugin('Config', file => 'examen__web.conf');
	$self->secrets('NovaParaulaClau per les cookies 1421452135512');

	$self->helper(db => sub { $self->app->schema });
	$self->helper(
    m_examen => sub { state $m_examen = Examen_Web::Model::Examen->new(db => shift->db) });

  # Router
  my $r = $self->routes;

	# Static Pages
  $r->get('/')->to(template => 'examen/index');
  $r->get('/index')->to(template => 'examen/index');
  $r->get('/permutacions')->to(template => 'examen/permutacions');
  $r->get('/exception')->to(template => 'exception/exception');
	# Dinamic Pages
  $r->get('/preguntes/:opcio/:num')->to('examen#preguntes');
	$r->get('/examen/:opcio')->to('examen#examen');
	$r->get('/respostes/:num_pregunta')->to('examen#respostes');
	$r->get('/editar/:num_pregunta')->to('examen#editar');
	$r->get('/afegir')->to('examen#afegir');
	# Actualitzar / Update 
	$r->post('/actual_preg')->to('examen#actual_preg');
	$r->post('/actual_resp')->to('examen#actual_resp');
	$r->post('/actual_exam')->to('examen#actual_exam');
	$r->post('/crear_permuta')->to('examen#crear_permuta');
	# Fulls d'examen
	$r->get('/fulls_llista')->to('fulls#llista');
	$r->get('/full/:opcio/:permuta')->to('fulls#examen');

}

1;

# vim: tabstop=2
