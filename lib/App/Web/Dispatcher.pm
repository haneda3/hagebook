package App::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::Lite;
use FormValidator::Lite;
use Data::Dumper;
use Digest::SHA;

any '/' => sub {
    my ($c) = @_;

    my $model = $c->model('User');
    #$model->insert('test', 'test');

    my $auth = $model->auth('test', 'test');


    return $c->render('index.tt');
};

any '/signup' => sub {
    my ($c) = @_;

    unless ($c->req->param('submit')) {
        return $c->render('signup.tt');
    }

    my $validator = FormValidator::Lite->new( $c->req );
    $validator->set_message(
        'username.not_null' => 'username is not null',
        'username.length' => 'username length is wrong',
        'password.not_null' => 'password is not null',
        'password.length' => 'pa`ssword length is wrong',
    );
    my $res = $validator->check(
        username => ['NOT_NULL', [qw/LENGTH 4 12/]],
        password => ['NOT_NULL', [qw/LENGTH 8 32/]],
    );

    my $username = $c->req->param('username');
    my $password = $c->req->param('password');
    
    my @errors;
    if($validator->has_error) {
        for my $message ( $validator->get_error_messages ) {
        push @errors, $message;
            print Dumper $message;
        }
       return $c->render('signup.tt',
            +{
                username => $username,
                password => $password,
                error => '1',
                errors => \@errors,
            }
        );
    }

    my $model = $c->model('User');
    $model->insert($username, $password);

    return $c->render('index.tt');
    #print Dumper $c->req;
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

post '/login' => sub {
    my ($c) = @_;

    #my $validator = $c->validator(
    #    username    => { isa => 'Str' },
    #    password    => { isa => 'Str' },
    #    csrf_token  => { isa => 'Str' },
    #    remember_me => { isa => 'Int', optional => 1, default => 0 },
    #);

    #my $args = $validator->validate($c->req);

    my $validator = FormValidator::Lite->new( $c->req );
#    $validator->set_message(
#        'username.not_null' => 'username is not null',
#        'username.length' => 'username length is wrong',
#        'password.not_null' => 'password is not null',
#        'password.length' => 'password length is wrong',
#    );
    my $res = $validator->check(
        username => ['NOT_NULL', [qw/LENGTH 4-12/]],
        password => ['NOT_NULL', [qw/LENGTH 8-32/]],
    );
#    my @error_messages;
#    if($validator->has_error) {
 
    my $username = $c->req->param('username');
    my $password = $c->req->param('password');

    my $model = $c->model('User');
    if ($model->auth($username, $password)) {
        print Dumper "PPPPPPPPPPPPPPPPPPPPPPKK";
    }


    #if ($result->is_success()) {
    return $c->redirect('/');

    #} else {
    #    return $c->render('login_error.tt');
    #}
};

1;
