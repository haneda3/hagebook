package App::Model;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use Class::Accessor::Lite (
    new => 1,
    rw  => [ qw(c) ],
    #ro  => [ qw(c) ],
    #wo  => [ qw(c) ],
);

1;

