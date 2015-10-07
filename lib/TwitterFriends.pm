package TwitterFriends;

use strict;
use warnings;

use Net::Twitter::Lite::WithAPIv1_1;
use Scalar::Util 'blessed';


sub new {
  my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
                                                consumer_key        => $ENV{TWITTER_API_KEY},
                                                consumer_secret     => $ENV{TWITTER_API_SECRET},
                                                access_token        => $ENV{TWITTER_ACCESS_TOKEN},
                                                access_token_secret => $ENV{TWITTER_ACCESS_TOKEN_SECRET},
                                                ssl                 => 1,
                                               );

  #my $result = $nt->update('Hello, world!');

  eval {
    my $statuses = $nt->home_timeline({ since_id => 3600, count => 10 });
    for my $status ( @$statuses ) {
      print "$status->{created_at} <$status->{user}{screen_name}> $status->{text}\n";
    }
  };
  if ( my $err = $@ ) {
    die $@ unless blessed $err && $err->isa('Net::Twitter::Lite::Error');
    
    warn
      "HTTP Response Code: ", $err->code, "\n",
      "HTTP Message......: ", $err->message, "\n",
      "Twitter error.....: ", $err->error, "\n";
  }

}
  


1;
