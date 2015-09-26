package TwitterFriends;


use Net::Twitter::Lite::WithAPIv1_1;
use Scalar::Util 'blessed';


sub new {
  my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
                                                consumer_key        => $consumer_key,
                                                consumer_secret     => $consumer_secret,
                                                access_token        => $token,
                                                access_token_secret => $token_secret,
                                                ssl                 => 1,
                                               );

  #my $result = $nt->update('Hello, world!');

  eval {
    my $statuses = $nt->home_timeline({ since_id => $high_water, count => 100 });
    for my $status ( @$statuses ) {
      print "$status->{created_at} <$status->{user}{screen_name}> $status->{text}\n";
    }
  };
  if ( my $err = $@ ) {
    die $@ unless blessed $err && $err->isa('Net::Twitter::Lite::Error');
    
    warn "HTTP Response Code: ", $err->code, "\n",
      "HTTP Message......: ", $err->message, "\n",
      "Twitter error.....: ", $err->error, "\n";
  }

}
  


1;
