package App::Model;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use Class::Accessor::Lite (
    new => 1,
    rw  => [ qw(c) ],
    #ro  => [ qw(baz) ],
    #wo  => [ qw(hoge) ],
);

#sub new {
#    my ($class) = @_;

#   my $self = {};

#    return bless $self, $class;
#}

#sub c {
#    my ($self, $c) = @_;#

#my $self->{"_C_"} = $c;

1;

