#!/usr/bin/env perl
# Test: Examen_Web::Obj::Bloc_Attributes
use Modern::Perl;
use Test::More tests => 5;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Examen_Web::Obj::Bloc_Attributes;

my $bloc = Examen_Web::Obj::Bloc_Attributes->new( id_assig => 1 );

like($bloc->assig_nom, qr/Contemporani/, 'Nom assignatura correcte');
is($bloc->blocs, 3,                      "Hi ha 3 blocs en l'assignatura 1" );
is($bloc->color->{1}, '#e0b3ff',         "Color del bloc 1 correcte");
like($bloc->name->{1}, qr/G.ner/,        "Nom del bloc 1 correcte");
ok($bloc->n_pregs->{1} > 20,             "Més de 20 preguntes en el bloc 1");

