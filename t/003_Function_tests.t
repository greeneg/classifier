use strict;
use warnings;

use Capture::Tiny ':all';
use Test::More tests => 3;
use Classifier::Functions qw(err_log cur_time mk_json_struct);

# first test if functions test for stderr string works
my (undef, $stderr) = capture {
  err_log("This is a test");
};

my $curr_time = cur_time();
my $json_struct = mk_json_struct();
my $value = $json_struct->{'jsonapi'}->{'version'};

is($stderr, "This is a test\n", 'Got correct value');
like($curr_time, qr/\d\d\d\d\-\d\d\-\d\dT\d\d:\d\d:\d\d\.\d\d\dZ/, 'Time string check');
is($value, "1.0", 'Got version value');
