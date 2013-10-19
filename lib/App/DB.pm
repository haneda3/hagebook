package App::DB;
use parent qw/Teng/;

__PACKAGE__->load_plugin(qw/Count/);
__PACKAGE__->load_plugin(qw/Pager/);

1;

