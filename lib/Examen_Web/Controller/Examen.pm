package Examen_Web::Controller::Examen;
use Mojo::Base 'Mojolicious::Controller';
use List::Util qw(shuffle);
use Examen_Web::Obj::Bloc_Attributes;

# atenció: distingir entre "find_resposta" i "find_respostes"

# index {{{
sub index {
	my $self     = shift;

  $self->render(
    assig => $self->model->assignatures,
  );
}
# }}}

# index_assig {{{
sub index_assig {
	my $self     = shift;
  my $id_assig = $self->stash('id_assig');

  $self->render(
    bloc      => Examen_Web::Obj::Bloc_Attributes->new( id_assig => $id_assig ),
    id_assig  => $id_assig,
    assig     => $self->model->assig($id_assig)
  );
}
# }}}

# Preguntes {{{
sub preguntes {
	my $self  = shift;
	my ($opcio, $num, $id_assig) = ($self->stash('opcio'), 	$self->stash('num'), $self->stash('id_assig')); 
	my $pregs;
  $pregs = $self->model->preg_bloc( $id_assig, $num ) if $opcio eq 'bloc';
  $pregs = $self->model->preg_exam( $id_assig       ) if $opcio eq 'examen';
  # Número de blocs
  my @blocs = ( 1 .. $self->model->bloc_count($id_assig) );

  # Ens assegurem que existeixi la url on volem anar. 
	return $self->redirect_to('/index') unless 
			$opcio =~ /bloc|examen/ and grep( /$num/, @blocs); 

  $self->render(
		url		=> "/$id_assig/preguntes/$opcio/$num",
		pregs => $pregs,
    id_assig => $id_assig
  );
}
# }}}

# Mostra preguntes amb respostes {{{
sub respostes {
  my $self    = shift;
  my ($id, $id_assig) = ($self->stash('num_pregunta'), $self->stash('id_assig')); 
  my $preg 	    = $self->model->pregunta($id);
  my $bloc 		  = $preg->{'bloc'};
  my $preg_cas	= $preg->{'pregunta_cas'};
  my $preg_cat	= $preg->{'pregunta_cat'};
  my $examen	  = $preg->{'examen'};

  # Trobem el índex de la pregunta anterior i posterior del bloc
  my @preg_bloc  = sort { $a <=> $b } @{$self->model->preg_bloc_array($id_assig, $bloc)};
  my %index;
  @index{@preg_bloc} = ( 0 .. $#preg_bloc );
  my $index = $index{$id};
  my $posterior = $index + 1;
  my $anterior  = $index - 1;
  $posterior    = 0 if $posterior > $#preg_bloc;
  $anterior     = scalar $#preg_bloc if $anterior < 0;

  $self->render(
    bloc_att  => Examen_Web::Obj::Bloc_Attributes->new( id_assig => $id_assig ),
    id_assig  => $id_assig,
    assig     => $self->model->assig($id_assig),
    pregunta  => $id,
    resps     => $self->model->resp_preg($id),
    bloc      => $bloc,
    preg_cas  => $preg_cas,
    preg_cat  => $preg_cat,
    examen    => $examen,
    preg_bloc => \@preg_bloc,
    posterior => $preg_bloc[ $posterior ],
    anterior  => $preg_bloc[ $anterior  ],
  )
}
# }}}

# Crear Permutacions {{{
sub permutacions {
  my $self    = shift;
  my $id_assig = $self->stash('id_assig');

  $self->render(
    id_assig  => $id_assig,
  );
}
# }}}

# editar {{{
sub editar {
	my $self 		  = shift;
  my ($id_assig, $id_preg) = ($self->stash('id_assig'), $self->stash('id_preg') ); 
  my $preg 	    = $self->model->pregunta($id_preg);
  my $bloc 		  = $preg->{'bloc'};
  my $preg_cas	= $preg->{'pregunta_cas'};
  my $preg_cat	= $preg->{'pregunta_cat'};
  my $examen	  = $preg->{'examen'};

  # Trobem el índex de la pregunta anterior i posterior del bloc
  my @preg_bloc  = sort { $a <=> $b } @{$self->model->preg_bloc_array($id_assig, $bloc)};
  my %index;
  @index{@preg_bloc} = ( 0 .. $#preg_bloc );
  my $index = $index{$id_preg};
  my $posterior = $index + 1;
  my $anterior  = $index - 1;
  $posterior    = 0 if $posterior > $#preg_bloc;
  $anterior     = scalar $#preg_bloc if $anterior < 0;

  my $bloc_att = Examen_Web::Obj::Bloc_Attributes->new( id_assig => $id_assig );

  $self->render( 
    bloc_att  => $bloc_att,
    id_assig  => $id_assig,
    assig     => $self->model->assig($id_assig),
    pregunta  => $id_preg,
    resps     => $self->model->resp_preg($id_preg),
    bloc      => $bloc,
    preg_cas  => $preg_cas,
    preg_cat  => $preg_cat,
    examen    => $examen,
    correctes => $self->model->correctes($id_preg),
    preg_bloc => \@preg_bloc,
    posterior => $preg_bloc[ $posterior ],
    anterior  => $preg_bloc[ $anterior  ],
  );
}
# }}}

# Update exam data {{{

# questions
sub actual_preg {
	my $self 		   = shift;
  my ($id_assig, $id_preg) = ($self->param('id_assig'), $self->param('id_preg') ); 

  my $preg_update = $self->model->preg_update( $id_preg, {
	  pregunta_cas => $self->param('update_preg_cas'),
	  pregunta_cat => $self->param('update_preg_cat'),
	  bloc         => $self->param('update_bloc'),
	  examen       => $self->param('update_examen'),
	});

	$self->redirect_to("/$id_assig/editar/$id_preg");
}

# answers
sub actual_resp {
	my $self 		 = shift;
  my ($id_assig, $id_preg, $id_resp) = ($self->param('id_assig'), $self->param('id_preg'), $self->param('id_resp')); 

  my $resp_update = $self->model->resp_update( $id_resp, {
	  resposta_cas => $self->param('update_resp_cas'),
	  resposta_cat => $self->param('update_resp_cat'),
	  correcte     => $self->param('update_correct'),
   });

	$self->redirect_to("/$id_assig/editar/$id_preg");
}

# if the question goes to the final exam
sub actual_exam {
	my $self 		   = shift;
  my ($id_assig, $id_preg, $url) = ($self->param('id_assig'), $self->param('id_preg'), $self->param('url')); 

  # preg_update( $question, $hashref_content )
  my $preg_update = $self->model->preg_update( $id_preg, {
	  examen    => $self->param('update_examen'),
  });

	$self->redirect_to( $url );
}

# }}}

# Add Record {{{
sub afegir {
	my $self 		 = shift;
  my $id_assig = $self->stash('id_assig');

	# add question
  # insert( $table, $hashref_content)
	my $insert = $self->model->insert('preguntes', {
    id_assig      => $id_assig,
		pregunta_cas	=> 'Pregunta en castellano',
		pregunta_cat	=> 'Pregunta en català',
		bloc					=> '1',
		examen				=> '0',
	});

	# add four optons in answers
	foreach (1..4) {
		$self->model->insert('respostes', {
      id_pregunta  => $insert->last_insert_id,
			resposta_cas => 'Respuesta en castellano',
			resposta_cat => 'Resposta en català',
			correcte		 => '0',
		});
	}

	$self->redirect_to("/$id_assig/editar/" . $insert->last_insert_id);
}
# }}}

# Permutacions {{{
sub crear_permuta {
	my $self = shift;
  my $id_assig = $self->param('id_assig');

	# número de permutacions, idioma 
	# català = 1, castellà = 2
	my @permuta_def = ( 
		[$self->param('permuta_cat'), 1],
		[$self->param('permuta_cas'), 2],
	);

	# Fem servir la taula Preguntes, doncs la taula examen ens dona registres duplicats
  # array de id_pregunta
  my @pregs = @{$self->model->preg_exam_array($id_assig)};

  $self->model->delete_rows('permuta',      $id_assig);
  $self->model->delete_rows('permutacions', $id_assig);

	# Crea la taula amb el número de permutacions {{{
  my $permuta = 0;
	foreach my $n_perm (@permuta_def) {
		for ( 1 .. $n_perm->[0] ) {
      ++$permuta;
      # insert guarda a last_insert_id la id del últim registre insertat. Es fa servir més endavant. 
			my $insert = $self->model->insert_permuta({
        id_assig => $id_assig,
        permuta  => $permuta,
        idioma 	 => $n_perm->[1],
      });
			# Crea les preguntes per a cada permutació {{{
			foreach my $n_preg ( shuffle @pregs ) {
				my @resps = @{$self->model->resp_preg_array( $n_preg )};
				@resps = shuffle @resps;
				$self->model->insert_permutacio({
          id_assig    => $id_assig,
          id_permuta  => $insert->last_insert_id,
					id_pregunta => $n_preg,
					resp_a 			=> $resps[0],
					resp_b 			=> $resps[1],
					resp_c 			=> $resps[2],
					resp_d 			=> $resps[3],
				});
      }
			# }}}
    }
	}

	# }}}

	$self->redirect_to("/$id_assig/index");

}
# }}}

1;
# vim: tabstop=2
