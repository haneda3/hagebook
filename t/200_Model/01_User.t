use strict;
use warnings;
use utf8;
use 5.12.0;
use Test::More;

use t::Util;
#use App;

use Data::Dumper;

my $username = 'testuserxx';
my $password = 'passsssss';

my $c = App->new;

my $model = $c->model('User');
my $id = $model->insert($username, $password);
ok $id;

ok $model->auth($username, $password);

done_testing;

