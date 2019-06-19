use strict;
use warnings;

use Classifier::REST;
use Test::More tests => 5;
use Plack::Test;
use HTTP::Request::Common;

my $app = Classifier::REST->to_app;
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

my $res  = $test->request( GET '/' );
ok( $res->is_success, '[GET /] successful' );
$res  = $test->request( GET '/computers' );
ok( $res->is_success, '[GET /computers] successful' );
$res  = $test->request( GET '/classes' );
ok( $res->is_success, '[GET /computers] successful' );
$res  = $test->request( GET '/distributions' );
ok( $res->is_success, '[GET /computers] successful' );
