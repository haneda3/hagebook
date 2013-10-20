use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
+{
    'DBI' => [],
    'DBH' => +{
        dsn => 'dbi:mysql:dbname=test',
        user => 'root',
        pass => '',
    },
    'PASSWORD_HASH_SALT' => 'HOGEHOGE',
};
