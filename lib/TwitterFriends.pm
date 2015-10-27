package TwitterFriends;

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;
use LWP::Simple;
use Scalar::Util 'blessed';
use Data::Dumper;
use Carp;

sub new {
  my ($class) = @_ ;
  my $obj = bless {}, $class ;

  my $nt = Net::Twitter::Lite::WithAPIv1_1->new
    (
     consumer_key        => $ENV{TWITTER_API_KEY},
     consumer_secret     => $ENV{TWITTER_API_SECRET},
     access_token        => $ENV{TWITTER_ACCESS_TOKEN},
     access_token_secret => $ENV{TWITTER_ACCESS_TOKEN_SECRET},
     ssl                 => 1,
    );
  $obj->{nt} = $nt;
  return $obj;
}


sub friends {
  my $self = shift;
  
  my @friends;
  my $friends;

  my $cursor = -1;

  while ($cursor) {
    my $rls = $self->{nt}->rate_limit_status;
    warn Dumper($rls->{resources}->{friends}->{'/friends/list'});
    
    eval {
      $friends = $self->{nt}->friends_list({cursor => $cursor});
      foreach my $u ( @{ $friends->{users} } ) {
        warn $u->{name}, " ", $u->{url}, " ", $u->{screen_name};
        push @friends,
          {
           friends_count   => $u->{friends_count},
           followers_count => $u->{followers_count},
           name            => $u->{name},
           created_at      => $u->{status}->{created_at},
           id              => $u->{id},
           url             => $u->{url},
           screen_name     => $u->{screen_name},
          } ;
      }    
    } ;
    if ($@) {
      croak $@;
    }
    $cursor = $friends->{next_cursor};
    sleep 5;
  }

  warn $#{ $friends };
  warn Dumper($@{ $friends });
  return \@friends;    
}


1;
