use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
#my $dbpath = File::Spec->catfile($basedir, 'db', 'development.db');
+{
    'db' => +{
        'user' => +{
            dsn => 'dbi:mysql:dbname=test',
            user => 'root',
            pass => '',
        },
        'session' => +{
            dsn => 'dbi:mysql:dbname=test',
            user => 'root',
            pass => '',
         },
    },
    'PASSWORD_HASH_SALT' => 'HAAAAAAAAAGE',
};
