# examen_web

Examen web uses [Mojolicious](https://mojolicious.org/) web framework to add and edit questions for an exam and to create different permutations for different groups. This implementation uses perlbrew to set the perl version and installs dependencies with cpanm. It can export the questions and answers in AIKEN and GIFT formats.

# Installation

Install [perlbrew](https://perlbrew.pl/), following the instructions in the web page.

    $ perlbrew install perl-5.30.3 (it works with this perl version)
    $ perlbrew switch perl-5.30.3
    $ perlbrew install-cpanm
    $ cpanm Mojolicious
    $ cpanm List::Util
    $ cpanm Mojo::SQLite
    $ ... install other necessary dependencies
    $ git clone https://github.com/mimosinnet/examen_web.git
    $ cd examen_web
    $ mkdir data
    $ cp 'file with the database' data
    $ morbo script/examen__web (testing)

Write in your broser: localhost:3000

# Production

  To run the application in production, it runs in port 8082 (assuming a reverse proxy) as defined in the *examen__web.conf* configuration file. 

  $ hypnotoad script/examen__web 

# Support

Suggestions/patches are welcomed via github at <https://github.com/mimosinnet/examen_web>

# License

Please see the [LICENSE](https://github.com/mimosinnet/P6-Color-RangeToColor/blob/master/LICENSE) file in the distribution.

© Joan Pujol (Mimosinnet)



