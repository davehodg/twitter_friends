#!/usr/bin/env perl

use strict;
use warnings;

use lib qw/lib/;
use TwitterFriends;


my $tf = TwitterFriends->new;
my $friends = $tf->friends;


exit;
