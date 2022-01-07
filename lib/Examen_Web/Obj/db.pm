package Examen_Web::Obj::db;
use Mojo::Base -base;

use Mojo::SQLite;
use Examen_Web::Model::DB;

has sqlite => sub { Mojo::SQLite->new('sqlite:data/examen.db') };

has model  => sub {
	my $self = shift;
	return Examen_Web::Model::DB->new( sqlite =>  $self->sqlite );
};

1;
