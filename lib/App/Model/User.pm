package App::Model::User;
use strict;
use warnings;
use utf8;
use Digest::SHA;
use parent qw/App::Model/;
use App;
use Data::Dumper;

sub _create_password {
    my ($self, $userid, $password) = @_;

    my $salt = App->config->{PASSWORD_HASH_SALT} . $userid . $userid;
    my $pw = Digest::SHA::sha256_hex($salt . $password);

    return $pw;
}

sub insert {
    my ($self, $username, $password) = @_;
    my $userid = undef;
    my $teng = $self->c->teng('user');
    my $txn = $teng->txn_scope();
    {
        my $row = $teng->insert('user',
            +{
                username => $username,
                password => '',
            }
        );

        unless ($row) {
            $txn->rollback();
            return;
        }

        my $uid = $row->id;
        my $pw = $self->_create_password($uid, $password);

        $row->update(+{password => $pw});
        $txn->commit();

        $userid = $uid;
    }

    return $userid;
}

sub auth {
    my ($self, $username, $password) = @_;

    my $teng = $self->c->teng('user');
    my $row = $teng->single('user',
        +{
            username => $username,
        }
    );
    return 0 unless ($row);

    my $userid = $row->id;
    my $pw = $self->_create_password($userid, $password);
    if ($pw eq $row->password) {
        return 1;
    }
    return 0;
}

1;

